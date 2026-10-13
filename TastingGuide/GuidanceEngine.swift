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
    var subStages: [TastingStage]? = nil
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

    // MARK: Wine

    static func wineIntro(for inputs: WineInputs) -> GuidanceIntro {
        let wineType = WineKnowledge.wineType(forKey: inputs.typeKey ?? "")
        let wineTypeName = wineType?.name ?? "Wine"

        var facts: [(String, String)] = [("Type", wineTypeName)]
        if !inputs.grapeVarieties.isEmpty {
            facts.append(("Grapes", inputs.grapeVarieties.compactMap { WineKnowledge.grapeVariety(forKey: $0)?.name ?? $0 }.joined(separator: ", ")))
        }
        if !inputs.region.isEmpty { facts.append(("Region", inputs.region)) }
        if let vintage = inputs.vintage { facts.append(("Vintage", "\(vintage)")) }
        if let abv = inputs.alcoholPercentage { facts.append(("ABV", String(format: "%.1f%%", abv))) }

        let confidence: String?
        if inputs.isEmptyDetails {
            confidence = "You entered only the wine type, so these notes describe a typical \(wineTypeName). Taste and confirm what you actually perceive - your palate wins over the reference."
        } else {
            confidence = "Guidance combines the type, grapes, region and vintage you provided."
        }

        var tips = wineType?.tips ?? []
        tips.append("Take a good look at the wine against a white background to assess color and clarity.")
        tips.append("Swirl the wine in your glass to release aromas - the 'legs' or 'tears' on the sides are normal.")
        if let abv = inputs.alcoholPercentage, abv >= 14.0 {
            tips.append("At \(String(format: "%.1f", abv))% ABV, this is a full-bodied wine - expect alcohol warmth on the finish.")
        }

        return GuidanceIntro(
            title: inputs.name.isEmpty ? wineTypeName : inputs.name,
            subtitle: "Guided wine tasting · \(wineTypeName)",
            confidenceNote: confidence,
            facts: facts,
            tips: tips
        )
    }

    static func wineStages(for inputs: WineInputs) -> [TastingStage] {
        let wineType = WineKnowledge.wineType(forKey: inputs.typeKey ?? "")
        let grapeWords = inputs.grapeVarieties.flatMap { WineKnowledge.grapeVariety(forKey: $0)?.descriptors ?? [] }
        let wineTypeWords = wineType?.aromas ?? []
        let region = WineKnowledge.region(forKey: inputs.region)

        let appearanceSuggestions = (wineType?.appearance ?? []) + colorWords(from: inputs.grapeVarieties)
        let aromaSuggestions = unique((wineType?.aromas ?? []) + grapeWords + (region?.blurb.components(separatedBy: .whitespacesAndNewlines).filter { $0.count > 4 } ?? []))
        let flavorSuggestions = unique((wineType?.flavors ?? []) + grapeWords)
        let bodySuggestions = unique((wineType?.bodyWords ?? []) + wineBodyWords(forAbv: inputs.alcoholPercentage))
        let finishSuggestions = unique((wineType?.finishWords ?? []) + finishWords(forVintage: inputs.vintage))

        let stageExpectations = WineKnowledge.expectations(forKey: inputs.typeKey ?? "")

        // Sparkling wine has an additional step for bubbles
        let isSparkling = inputs.typeKey == "champagne" || inputs.typeKey == "sparkling"

        var stages: [TastingStage] = [
            TastingStage(
                id: "appearance",
                title: "Appearance",
                prompt: "Hold the glass against a white background and tilt it to look at the color gradient.",
                guidance: "Assess color intensity (pale to deep), hue (ruby, garnet, purple, gold, straw), clarity (clear vs cloudy - though some unfiltered wines are intentionally cloudy), and brightness. For sparkling wines, also assess the bubbles.",
                suggestions: unique(appearanceSuggestions),
                ratingLabel: "Visual appeal",
                expectation: stageExpectations?.forStage("appearance")),
            TastingStage(
                id: "aroma",
                title: "Aroma / Nose",
                prompt: "Swirl the wine and take several short sniffs.",
                guidance: "Wine aromas fall into three categories: Primary (from the grape - fruit, floral, herbal), Secondary (from fermentation and aging - yeast, butter, vanilla, toast), and Tertiary (from bottle aging - leather, tobacco, earth, petrol). Try to identify notes in each category.",
                suggestions: aromaSuggestions,
                ratingLabel: "Aroma complexity",
                expectation: stageExpectations?.forStage("aroma")),
            TastingStage(
                id: "taste",
                title: "Taste / Palate",
                prompt: "Take a sip and let it coat your entire mouth.",
                guidance: "Assess the wine's components: Fruit (what types?), Sweetness (dry to sweet), Acidity (low to high - makes your mouth water), Tannin (in reds - the drying sensation), Alcohol (warmth), and Body (light to full). Check how the flavors match the aromas.",
                suggestions: flavorSuggestions,
                ratingLabel: "Flavor complexity",
                expectation: stageExpectations?.forStage("taste"))
        ]

        if isSparkling {
            stages.append(TastingStage(
                id: "bubbles",
                title: "Bubbles",
                prompt: "Watch the bubbles rise and assess their quality.",
                guidance: "Evaluate the bubble size (fine vs coarse), persistence (how long they last), and mousse (the foam at the surface). Fine, persistent bubbles are a sign of quality in traditional method sparkling wines.",
                suggestions: ["Fine bubbles", "Persistent", "Form a mousse", "Delicate beading"],
                ratingLabel: "Bubble quality"
            ))
        }

        stages.append(contentsOf: [
            TastingStage(
                id: "mouthfeel",
                title: "Mouthfeel & Texture",
                prompt: "Focus on the wine's texture and structure.",
                guidance: "Assess body (light, medium, full), texture (oily, creamy, silky, coarse), carbonation if present, and the balance between the wine's components. A well-balanced wine has harmony between fruit, acidity, tannin (in reds), sweetness, and alcohol.",
                suggestions: bodySuggestions,
                ratingLabel: "Mouthfeel",
                expectation: stageExpectations?.forStage("mouthfeel")),
            TastingStage(
                id: "finish",
                title: "Finish & Overall",
                prompt: "Wait 10-15 seconds after swallowing and assess the aftertaste.",
                guidance: "Count how long the flavor lingers (short, medium, long), whether it's clean or has any faults (bitterness from tannin, heat from alcohol, sweetness), and whether it invites another sip. Then give the wine one overall score.",
                suggestions: finishSuggestions,
                ratingLabel: "Overall",
                expectation: stageExpectations?.forStage("finish"))
        ])

        return stages
    }

    private static func colorWords(from grapeVarieties: [String]) -> [String] {
        var words: [String] = []
        for key in grapeVarieties {
            if let variety = WineKnowledge.grapeVariety(forKey: key) {
                switch variety.color {
                case "red":
                    words.append("Deep ruby-purple tones")
                case "white":
                    words.append("Pale straw-gold tones")
                case "both":
                    words.append("Variable color tones")
                default:
                    break
                }
            }
        }
        return words
    }

    private static func wineBodyWords(forAbv abv: Double?) -> [String] {
        guard let abv else { return [] }
        if abv >= 14.0 { return ["Full-bodied", "Rich", "Warming"] }
        if abv >= 13.0 { return ["Medium to full-bodied", "Round"] }
        if abv <= 11.5 { return ["Light-bodied", "Crisp"] }
        return []
    }

    private static func finishWords(forVintage vintage: Int?) -> [String] {
        guard let vintage else { return [] }
        let currentYear = Calendar.current.component(.year, from: Date())
        let age = currentYear - vintage
        if age >= 10 { return ["Complex", "Developed", "Tertiary notes"] }
        if age >= 5 { return ["Mature", "Integrated", "Balanced"] }
        if age < 2 { return ["Youthful", "Fresh", "Primary fruit"] }
        return []
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
