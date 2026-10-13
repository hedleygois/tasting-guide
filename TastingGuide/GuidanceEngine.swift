import Foundation

/// One guided step of a tasting session.
struct TastingStage: Identifiable {
    let id: String
    let title: String
    let prompt: String
    let guidance: String
    let suggestions: [String]
    let ratingLabel: String
    var expectation: String? = nil
}

/// Header information shown before / alongside the guided stages.
struct GuidanceIntro {
    let title: String
    let subtitle: String
    let confidenceNote: String?
    let facts: [(String, String)]
    let tips: [String]
}

/// Builds tasting guidance from whatever the user provided. The more inputs
/// available, the more specific the suggestions; with only a beer style or a
/// coffee variety + method, the engine leans on the knowledge base defaults.
enum GuidanceEngine {

    // MARK: Beer

    static func beerIntro(for inputs: BeerInputs) -> GuidanceIntro {
        let style = BeerKnowledge.style(forKey: inputs.styleKey ?? "")
        let styleName = style?.name ?? "Beer"

        var facts: [(String, String)] = [("Style", styleName)]
        if let abv = inputs.abv { facts.append(("ABV", String(format: "%.1f%%", abv))) }
        if let ibu = inputs.ibu { facts.append(("IBU", "\(ibu)")) }
        if !inputs.hops.isEmpty {
            facts.append(("Hops", inputs.hops.compactMap { BeerKnowledge.hop(forKey: $0)?.name ?? $0 }.joined(separator: ", ")))
        }
        if !inputs.malts.isEmpty {
            facts.append(("Malts", inputs.malts.compactMap { BeerKnowledge.malt(forKey: $0)?.name ?? $0 }.joined(separator: ", ")))
        }
        if let yeast = inputs.yeastKey, let y = BeerKnowledge.yeast(forKey: yeast) {
            facts.append(("Yeast", y.name))
        }
        if let style {
            facts.append(("Serve at", style.servingTemp))
            facts.append(("Glassware", style.glassware))
        }

        let confidence: String?
        if inputs.isEmptyDetails {
            confidence = "You entered only the style, so these notes describe a typical \(styleName). Taste and confirm what you actually perceive - your palate wins over the reference."
        } else {
            confidence = "Guidance is tailored to the style plus the ingredients you listed."
        }

        var tips = style?.tips ?? []
        tips.append("Take short sniffs; olfactory receptors fatigue quickly.")
        if let abv = inputs.abv, abv >= 7.0 {
            tips.append("At \(String(format: "%.1f", abv))% ABV, alcohol warmth is expected - note where you feel it.")
        }

        return GuidanceIntro(
            title: inputs.name.isEmpty ? styleName : inputs.name,
            subtitle: "Guided beer tasting · \(styleName)",
            confidenceNote: confidence,
            facts: facts,
            tips: tips
        )
    }

    static func beerStages(for inputs: BeerInputs) -> [TastingStage] {
        let style = BeerKnowledge.style(forKey: inputs.styleKey ?? "")
        let hopWords = inputs.hops.flatMap { BeerKnowledge.hop(forKey: $0)?.descriptors ?? [] }
        let maltWords = inputs.malts.flatMap { BeerKnowledge.malt(forKey: $0)?.descriptors ?? [] }
        let yeastWords = inputs.yeastKey.flatMap { BeerKnowledge.yeast(forKey: $0)?.descriptors ?? [] } ?? []

        let appearanceSuggestions = (style?.appearance ?? []) + maltColorWords(from: inputs.malts)
        let aromaSuggestions = unique((style?.aromas ?? []) + hopWords + yeastWords + maltWords.prefix(3))
        let flavorSuggestions = unique((style?.flavors ?? []) + hopWords + maltWords + yeastWords)
        let bodySuggestions = unique((style?.bodyWords ?? []) + bodyWords(forAbv: inputs.abv) + (inputs.malts.contains("oat") ? ["Silky oat smoothness"] : []))
        let finishSuggestions = unique((style?.finishWords ?? []) + finishWords(forIbu: inputs.ibu, style: style))

        let stageExpectations = BeerKnowledge.expectations(forKey: inputs.styleKey ?? "")

        return [
            TastingStage(
                id: "appearance",
                title: "Appearance",
                prompt: "Hold the beer up to the light and look.",
                guidance: "Judge color against the style expectation, clarity (hazy vs bright - check the style's norms), head color and retention, and the lacing it leaves on the glass.",
                suggestions: unique(appearanceSuggestions),
                ratingLabel: "Visual appeal",
                expectation: stageExpectations?.forStage("appearance")),
            TastingStage(
                id: "aroma",
                title: "Aroma",
                prompt: "Swirl gently, then take several short snips of aroma.",
                guidance: "Nose first for malt (bread, caramel, roast), then hops (citrus, pine, tropical) and yeast character (fruit, spice). Aroma is most of what we call flavor.",
                suggestions: aromaSuggestions,
                ratingLabel: "Aroma",
                expectation: stageExpectations?.forStage("aroma")),
            TastingStage(
                id: "taste",
                title: "Taste",
                prompt: "Take a full sip and let it spread across the tongue.",
                guidance: "Work front to back: initial sweetness, mid-palate hop flavor and malt depth, then bitterness on the swallow. Check how the flavors you smelled carry into the taste.",
                suggestions: flavorSuggestions,
                ratingLabel: "Flavor",
                expectation: stageExpectations?.forStage("taste")),
            TastingStage(
                id: "mouthfeel",
                title: "Mouthfeel",
                prompt: "Focus on texture, carbonation and warmth.",
                guidance: "Assess body (water-thin to full), carbonation (flat to prickly), finishing dryness or sweetness, and any alcohol warmth.",
                suggestions: bodySuggestions,
                ratingLabel: "Mouthfeel",
                expectation: stageExpectations?.forStage("mouthfeel")),
            TastingStage(
                id: "finish",
                title: "Finish & Overall",
                prompt: "Wait a few seconds after swallowing.",
                guidance: "Count how long the flavor lingers, whether it is bitter, sweet, dry or roasty, and whether it invites the next sip. Then give the beer one overall score.",
                suggestions: finishSuggestions,
                ratingLabel: "Overall",
                expectation: stageExpectations?.forStage("finish"))
        ]
    }

    private static func maltColorWords(from malts: [String]) -> [String] {
        var words: [String] = []
        for key in malts {
            switch key {
            case "crystal-120", "special-b", "chocolate", "pale-chocolate", "brown-malt", "roasted-barley", "black":
                words.append("Deep brown-black tones")
            case "crystal-40", "crystal-80", "caramunich", "carared", "amber", "munich", "vienna", "melanoidin":
                words.append("Amber-copper tones")
            default:
                break
            }
        }
        return words
    }

    private static func bodyWords(forAbv abv: Double?) -> [String] {
        guard let abv else { return [] }
        if abv >= 7.0 { return ["Alcohol warmth", "Fuller body"] }
        if abv <= 4.2 { return ["Light body"] }
        return []
    }

    private static func finishWords(forIbu ibu: Int?, style: BeerKnowledge.StyleInfo?) -> [String] {
        guard let ibu else {
            return ["Invites the next sip", "Clean ending"]
        }
        if ibu >= 55 { return ["Assertive bitterness", "Resinous"] }
        if ibu >= 30 { return ["Balanced bitterness"] }
        return ["Low bitterness", "Malty ending"]
    }

    // MARK: Coffee

    static func coffeeIntro(for inputs: CoffeeInputs) -> GuidanceIntro {
        let variety = CoffeeKnowledge.variety(forKey: inputs.varietyKey ?? "")
        let roast = CoffeeKnowledge.roast(forKey: inputs.roastKey ?? "")
        let process = CoffeeKnowledge.process(forKey: inputs.processKey ?? "")
        let method = CoffeeKnowledge.method(forKey: inputs.methodKey ?? "")

        var facts: [(String, String)] = []
        if let method {
            facts.append(("Method", method.name))
            for parameter in method.parameters {
                facts.append(parameter)
            }
        }
        if let variety { facts.append(("Variety", variety.name)) }
        if !inputs.origin.isEmpty { facts.append(("Origin", inputs.origin)) }
        if let process { facts.append(("Process", process.name)) }
        if let roast { facts.append(("Roast", roast.name)) }

        var tips = roast?.tips ?? []
        tips.append("Taste more than once: flavors shift as temperature drops.")
        if method?.key == "espresso" || method?.key == "ristretto" {
            tips.append("Pull your shot, then start tasting within a minute - espresso changes fast.")
        }
        if method?.key == "cupping" {
            tips.append("Cupping scores are relative. Stay consistent across cups to compare fairly.")
        }
        if let variety,
           let varietyKey = inputs.varietyKey,
           !CoffeeKnowledge.hasCupDescriptors(forKey: varietyKey) {
            let species = variety.species == "Robusta" ? "robusta" : "arabica"
            tips.append("Cup notes for \(variety.name) are not in the guide yet - suggestions use general \(species) expectations. Trust your own palate.")
        }

        let title = inputs.name.isEmpty
            ? ((variety?.name ?? "Coffee") + " " + (method?.name ?? "")).trimmingCharacters(in: .whitespaces)
            : inputs.name

        var subtitleParts: [String] = []
        if let method { subtitleParts.append(method.name) }
        if let variety { subtitleParts.append(variety.name) }
        if let roast { subtitleParts.append(roast.name) }

        let confidence: String?
        if inputs.processKey == nil && inputs.roastKey == nil {
            confidence = "You entered the variety and method, so guidance leans on those. Adding roast and process would sharpen it further."
        } else if inputs.roastKey == nil {
            confidence = "Roast level not given - acidity and body suggestions are generalized."
        } else {
            confidence = "Guidance combines the variety, process, roast and method you entered."
        }

        return GuidanceIntro(
            title: title,
            subtitle: "Guided coffee tasting · " + subtitleParts.joined(separator: " · "),
            confidenceNote: confidence,
            facts: facts,
            tips: tips
        )
    }

    static func coffeeStages(for inputs: CoffeeInputs) -> [TastingStage] {
        let variety = CoffeeKnowledge.variety(forKey: inputs.varietyKey ?? "")
        let roast = CoffeeKnowledge.roast(forKey: inputs.roastKey ?? "")
        let process = CoffeeKnowledge.process(forKey: inputs.processKey ?? "")
        let method = CoffeeKnowledge.method(forKey: inputs.methodKey ?? "")

        let varietyWords = variety?.descriptors ?? []
        let processWords = process?.descriptors ?? []
        let roastWords = roast?.descriptors ?? []
        let acidityWords = roast?.acidityWords ?? ["Bright", "Balanced", "Mellow"]
        let bodyWords = roast?.bodyWords ?? ["Light", "Medium", "Heavy"]

        let aromaSuggestions = unique(varietyWords + processWords + roastWords)
        let flavorSuggestions = unique(varietyWords + processWords + roastWords + ["Sweetness", "Bitterness well integrated"])
        let stageSuffix = method?.key == "cupping" ? " (cupping scores)" : ""

        return (method?.stages ?? []).map { stage in
            let suggestions: [String]
            switch stage.id {
            case "fragrance", "aroma", "appearance":
                suggestions = aromaSuggestions
            case "taste":
                suggestions = flavorSuggestions
            case "acidity", "body":
                suggestions = unique(bodyWords + (stage.id == "acidity" ? acidityWords : []) + ["Coating", "Juicy", "Tea-like"])
            default:
                suggestions = unique(["Sweet aftertaste", "Clean finish", "Lingering", "Short", "Fruity echo", "Cocoa echo"] + roastWords.prefix(2))
            }
            return TastingStage(
                id: method.map { $0.key + "-" + stage.id } ?? stage.id,
                title: stage.title,
                prompt: stage.prompt,
                guidance: stage.guidance,
                suggestions: stage.id == "appearance" && method?.key == "espresso"
                    ? suggestions + ["Tiger-striped crema", "Blonding crema"]
                    : suggestions,
                ratingLabel: stage.ratingLabel + stageSuffix,
                expectation: coffeeExpectation(forStageId: stage.id, variety: variety, process: process, roast: roast)
            )
        }
    }

    /// Builds a "what to expect" line for a coffee stage from whatever the
    /// user told us about variety, process and roast.
    private static func coffeeExpectation(forStageId id: String,
                                           variety: CoffeeKnowledge.VarietyInfo?,
                                           process: CoffeeKnowledge.ProcessInfo?,
                                           roast: CoffeeKnowledge.RoastInfo?) -> String? {
        switch id {
        case "fragrance", "aroma", "appearance":
            var parts: [String] = []
            if let variety {
                parts.append("a \(variety.name) typically shows \(variety.descriptors.prefix(3).joined(separator: ", ").lowercased())")
            }
            if let roast {
                parts.append("\(roast.name.lowercased()) keeps the aromatics \(roast.acidityWords.prefix(2).joined(separator: " and ").lowercased())")
            }
            return parts.isEmpty ? nil : "Expected: " + parts.joined(separator: "; ") + "."
        case "taste":
            var parts: [String] = []
            if let roast {
                parts.append("the \(roast.name.lowercased()) side brings \(roast.descriptors.prefix(3).joined(separator: ", ").lowercased())")
            }
            if let process {
                parts.append("the \(process.name.lowercased()) process adds \(process.descriptors.prefix(2).joined(separator: " and ").lowercased())")
            }
            if let variety {
                parts.append("a \(variety.name) should still carry its fruit and florals")
            }
            return parts.isEmpty ? nil : "Expected flavor direction: " + parts.joined(separator: "; ") + "."
        case "acidity":
            return roast.map { "Expected acidity for \($0.name.lowercased()): \($0.acidityWords.joined(separator: ", ").lowercased())." }
        case "body":
            return roast.map { "Expected body for \($0.name.lowercased()): \($0.bodyWords.joined(separator: ", ").lowercased())." }
        default:
            return "Expected aftertaste: pleasant and clean - ash, paper or ferment notes are faults, not style."
        }
    }

    // MARK: Helpers

    private static func unique(_ words: [String]) -> [String] {
        var seen = Set<String>()
        return words.filter { seen.insert($0).inserted }
    }
}
