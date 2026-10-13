import Foundation

/// Reference data for coffee: bean varieties, processes, roast levels and
/// brewing methods. The brewing method defines the tasting stages.
enum CoffeeKnowledge {
    struct VarietyInfo {
        let key: String
        let name: String
        let blurb: String
        let descriptors: [String]
        var species: String? = nil
    }

    struct ProcessInfo {
        let key: String
        let name: String
        let blurb: String
        let descriptors: [String]
    }

    struct RoastInfo {
        let key: String
        let name: String
        let blurb: String
        let descriptors: [String]
        let acidityWords: [String]
        let bodyWords: [String]
        let tips: [String]
    }

    struct MethodInfo {
        let key: String
        let name: String
        let blurb: String
        let parameters: [(String, String)]
        let stages: [MethodStage]
    }

    struct MethodStage {
        let id: String
        let title: String
        let prompt: String
        let guidance: String
        let ratingLabel: String
    }

    /// Hand-written, tasting-focused entries.
    static let curatedVarieties: [VarietyInfo] = [
        VarietyInfo(key: "geisha", name: "Geisha / Gesha",
                    blurb: "Prized, aromatic variety with florals and stone fruit.",
                    descriptors: ["Jasmine", "Bergamot", "Peach", "Tea-like", "Honeyed florals"]),
        VarietyInfo(key: "catuai", name: "Catuaí",
                    blurb: "Compact Brazilian-born variety with a sweet, balanced profile.",
                    descriptors: ["Chocolate", "Nuts", "Caramel", "Citrus", "Red apple"]),
        VarietyInfo(key: "bourbon", name: "Bourbon",
                    blurb: "Classic variety known for sweetness and complexity.",
                    descriptors: ["Caramel", "Buttery", "Berry", "Vanilla", "Sweetness"]),
        VarietyInfo(key: "typica", name: "Typica",
                    blurb: "Heritage variety, clean and classically sweet.",
                    descriptors: ["Clean sweetness", "Stone fruit", "Cane sugar", "Gentle acidity"]),
        VarietyInfo(key: "caturra", name: "Caturra",
                    blurb: "Bright Bourbon mutation, lively and citric.",
                    descriptors: ["Citric", "Lemon", "Crisp", "Cocoa", "Balanced"]),
        VarietyInfo(key: "sl28", name: "SL28",
                    blurb: "Kenyan variety famous for blackcurrant wineyness.",
                    descriptors: ["Blackcurrant", "Winey", "Tart", "Tomato leaf", "Grape"]),
        VarietyInfo(key: "sl34", name: "SL34",
                    blurb: "Deep, sweet Kenyan variety with rich body.",
                    descriptors: ["Deep sweetness", "Plum", "Full body", "Dark chocolate"]),
        VarietyInfo(key: "pacamara", name: "Pacamara",
                    blurb: "Big-beaned Salvadoran cross with bold fruit.",
                    descriptors: ["Big body", "Chocolate", "Cherry", "Spice", "Savory edge"]),
        VarietyInfo(key: "maragogype", name: "Maragogype (Elephant Bean)",
                    blurb: "Giant gentle mutation, soft and smooth.",
                    descriptors: ["Soft", "Smooth", "Mild acidity", "Floral sweetness"]),
        VarietyInfo(key: "mundo-novo", name: "Mundo Novo",
                    blurb: "Robust Brazilian hybrid with chocolate balance.",
                    descriptors: ["Chocolate", "Mild", "Nutty", "Low acidity", "Sweet"]),
        VarietyInfo(key: "villa-sarchi", name: "Villa Sarchi",
                    blurb: "Costa Rican dwarf variety, sweet and bright.",
                    descriptors: ["Sweet", "Bright", "Cantaloupe", "Brown sugar"]),
        VarietyInfo(key: "catimor", name: "Catimor",
                    blurb: "Hardy, high-yield variety with bold rustic notes.",
                    descriptors: ["Bold", "Earthy", "Herbal", "Dark fruit"]),
        VarietyInfo(key: "heirloom", name: "Ethiopian Heirloom",
                    blurb: "Wild Ethiopian landraces with florals and berries.",
                    descriptors: ["Blueberry", "Florals", "Winey", "Bergamot", "Stone fruit"])
    ]

    static let processes: [ProcessInfo] = [
        ProcessInfo(key: "washed", name: "Washed",
                    blurb: "Fruit removed before drying: clean, clarity-forward cup.",
                    descriptors: ["Clean", "Bright", "Crisp clarity", "Delicate sweetness"]),
        ProcessInfo(key: "natural", name: "Natural (dry)",
                    blurb: "Dried in the fruit: big fruity, fermented sweetness.",
                    descriptors: ["Berry", "Fruity", "Winey", "Fermented", "Sweet body"]),
        ProcessInfo(key: "honey", name: "Honey (pulped natural)",
                    blurb: "Mucilage left on: syrupy sweetness, balanced acidity.",
                    descriptors: ["Syrupy", "Sweet", "Round body", "Mild fruit", "Balanced"]),
        ProcessInfo(key: "anaerobic", name: "Anaerobic fermentation",
                    blurb: "Fermented in sealed tanks: intense, funky fruit.",
                    descriptors: ["Intense fruit", "Lactic", "Funky", "Tropical", "Fizzy acidity"])
    ]

    static let roasts: [RoastInfo] = [
        RoastInfo(key: "light", name: "Light roast",
                  blurb: "Origin character shines: bright, floral, tea-like.",
                  descriptors: ["Florals", "Citrus", "Tea-like", "Toast grain", "Fresh fruit"],
                  acidityWords: ["Bright", "Sparkling", "Citric", "Malic", "Sharp"],
                  bodyWords: ["Light", "Juicy", "Delicate", "Tea-like"],
                  tips: [
                      "Bitterness should be minimal - a harsh bite suggests uneven extraction.",
                      "Taste as it cools; light roasts reveal fruit best below 55 C."
                  ]),
        RoastInfo(key: "medium", name: "Medium roast",
                  blurb: "Balance point: caramel sweetness with moderate acidity.",
                  descriptors: ["Caramel", "Milk chocolate", "Nuts", "Brown sugar", "Balanced"],
                  acidityWords: ["Balanced", "Crisp", "Juicy", "Wine-like"],
                  bodyWords: ["Round", "Medium", "Smooth"],
                  tips: [
                      "Look for the sweet spot where acidity, sweetness and body meet.",
                      "Caramelization shows as brown-sugar and nut notes."
                  ]),
        RoastInfo(key: "medium-dark", name: "Medium-dark roast",
                  blurb: "Bittersweet edge with dark chocolate and molasses.",
                  descriptors: ["Dark chocolate", "Molasses", "Bittersweet", "Toasted nuts", "Cocoa powder"],
                  acidityWords: ["Mellow", "Soft", "Low", "Gentle prickle"],
                  bodyWords: ["Heavy", "Coating", "Syrupy"],
                  tips: [
                      "Acidity steps back; bittersweetness leads.",
                      "Watch for any ashy edge crossing into dark territory."
                  ]),
        RoastInfo(key: "dark", name: "Dark roast",
                  blurb: "Roast character leads: smoky, low-acid, heavy body.",
                  descriptors: ["Roasty", "Smoky", "Charcoal edge", "Bittersweet cocoa", "Pungent"],
                  acidityWords: ["Very low", "Flat", "Soft", "Ashy tingle"],
                  bodyWords: ["Very heavy", "Thick", "Coating", "Oily"],
                  tips: [
                      "Assess roast flavors (smoke, carbony) rather than origin fruit.",
                      "Any leftover sweetness shows on the finish - note how long it lasts."
                  ])
    ]

    static let methods: [MethodInfo] = [
        MethodInfo(
            key: "espresso", name: "Espresso",
            blurb: "Concentrated shot under pressure; the full-flavored benchmark.",
            parameters: [
                ("Grind", "Fine (table salt)"),
                ("Ratio", "1:2 (e.g. 18 g in, 36 g out)"),
                ("Time", "25-30 s"),
                ("Water", "90-94 C, 9 bar")
            ],
            stages: [
                MethodStage(id: "appearance", title: "Crema & Appearance",
                    prompt: "Look at the shot before the crema breaks.",
                    guidance: "Evaluate crema color (tiger striping is ideal), thickness, and persistence. Blonde, thin, or rapidly dissipating crema can signal over-extraction or stale beans.",
                    ratingLabel: "Crema quality"),
                MethodStage(id: "aroma", title: "Aroma",
                    prompt: "Stir the crema, then take short sniffs.",
                    guidance: "Espresso aromas are intense. Stir first to release volatiles, then sniff in short bursts. Intensity here will be far higher than in filter coffee.",
                    ratingLabel: "Aroma intensity"),
                MethodStage(id: "taste", title: "Taste",
                    prompt: "Take a full sip and let it coat the tongue.",
                    guidance: "Assess the balance between sweetness, acidity (brightness) and bitterness. A good shot is sweet at the front, bright in the middle, and pleasantly bitter on the swallow.",
                    ratingLabel: "Balance"),
                MethodStage(id: "body", title: "Body & Texture",
                    prompt: "Feel the weight and texture of the liquid.",
                    guidance: "Espresso should feel dense and syrupy but not astringent. Dryness or grip on the tongue points to over-extraction.",
                    ratingLabel: "Body"),
                MethodStage(id: "finish", title: "Aftertaste",
                    prompt: "Wait 15 seconds after swallowing.",
                    guidance: "A long, sweet, clean aftertaste is the mark of a good shot. Harsh, ashtray-like lingering bitterness means the grind or dose needs work.",
                    ratingLabel: "Finish length")
            ]),
        MethodInfo(
            key: "ristretto", name: "Ristretto",
            blurb: "Short-restricted shot: sweeter, denser, more concentrated.",
            parameters: [
                ("Grind", "Fine"),
                ("Ratio", "1:1 (e.g. 18 g in, 18 g out)"),
                ("Time", "18-25 s"),
                ("Water", "90-94 C, 9 bar")
            ],
            stages: [
                MethodStage(id: "appearance", title: "Appearance",
                    prompt: "Notice the thicker, darker crema.",
                    guidance: "A ristretto pulls less water through the puck, so expect a denser cup with a darker, tighter crema.",
                    ratingLabel: "Crema quality"),
                MethodStage(id: "aroma", title: "Aroma",
                    prompt: "Stir and smell.",
                    guidance: "Aromas are even more concentrated than espresso - florals and fruit can turn jammy and intense.",
                    ratingLabel: "Aroma intensity"),
                MethodStage(id: "taste", title: "Taste",
                    prompt: "Sip slowly; this is concentrated.",
                    guidance: "The shorter extraction favors early-dissolving sweet compounds. Look for syrupy sweetness with controlled bitterness and muted brightness.",
                    ratingLabel: "Sweetness"),
                MethodStage(id: "body", title: "Body & Texture",
                    prompt: "Assess the weight.",
                    guidance: "Expect the heaviest body of any method: thick, velvety, almost syrup.",
                    ratingLabel: "Body"),
                MethodStage(id: "finish", title: "Aftertaste",
                    prompt: "Wait 15 seconds.",
                    guidance: "Finish should be sweet and lingering. Sourness at the end means it ran too short.",
                    ratingLabel: "Finish length")
            ]),
        MethodInfo(
            key: "pourover", name: "Filter / Pour-over",
            blurb: "Clean drip brew (V60, Chemex) that highlights clarity and acidity.",
            parameters: [
                ("Grind", "Medium-fine"),
                ("Ratio", "1:16 (e.g. 15 g to 240 ml)"),
                ("Bloom", "30-45 s with 2x water"),
                ("Water", "90-96 C"),
                ("Time", "2:30-4:00 total")
            ],
            stages: [
                MethodStage(id: "fragrance", title: "Dry Fragrance",
                    prompt: "Smell the freshly ground coffee before brewing.",
                    guidance: "Grind a little extra and smell immediately: dry fragrance reveals the most volatile florals and fruit. Note how it compares to the brewed aroma.",
                    ratingLabel: "Fragrance"),
                MethodStage(id: "aroma", title: "Aroma & Bloom",
                    prompt: "Smell during the bloom and after brewing.",
                    guidance: "During the bloom, trapped CO2 releases aromas - this is the brightest the coffee will ever smell. After brewing, note how aromas settle.",
                    ratingLabel: "Aroma"),
                MethodStage(id: "taste", title: "Flavor",
                    prompt: "Taste at three temperatures: hot, warm, cool.",
                    guidance: "Taste immediately, again around 55-60 C, and once near room temperature. Coffees often reveal fruit and sweetness only when cool; flaws also show up as it cools.",
                    ratingLabel: "Flavor"),
                MethodStage(id: "acidity", title: "Acidity & Sweetness",
                    prompt: "Judge the brightness and how it balances sweetness.",
                    guidance: "Good acidity is lively and described as citric, malic or wine-like - not sour or vinegary. Sweetness should carry through the sip.",
                    ratingLabel: "Acidity"),
                MethodStage(id: "finish", title: "Body & Finish",
                    prompt: "Assess weight and the aftertaste.",
                    guidance: "Pour-over is the cleanest method: body is light-to-medium and the finish should be clear, long, and sweet.",
                    ratingLabel: "Finish")
            ]),
        MethodInfo(
            key: "cupping", name: "Cupping",
            blurb: "The SCA-style evaluation protocol used by professionals.",
            parameters: [
                ("Grind", "Coarse (cupping grind)"),
                ("Dose", "8.25 g per 150 ml"),
                ("Water", "93 C, poured to rim"),
                ("Steep", "4-5 min before crust break")
            ],
            stages: [
                MethodStage(id: "fragrance", title: "Fragrance (dry)",
                    prompt: "Smell the dry grounds right after grinding.",
                    guidance: "Score the fragrance for intensity and character before water touches the grounds. Florals, fruit and grain notes are common anchors.",
                    ratingLabel: "Fragrance score"),
                MethodStage(id: "aroma", title: "Aroma (crust break)",
                    prompt: "At 4-5 min, push the crust down with a spoon and smell the release.",
                    guidance: "Breaking the crust releases a burst of aromatics - the definitive aroma reading. Push the floating grounds back three times, sniffing each time, then skim the foam.",
                    ratingLabel: "Aroma score"),
                MethodStage(id: "taste", title: "Flavor & Slurp",
                    prompt: "Slurp loudly from a spoon, spraying coffee across the palate.",
                    guidance: "The loud slurp aerates the coffee so it reaches the whole palate at once. Judge dominant flavors and how they combine as the cup cools through 55 C and below.",
                    ratingLabel: "Flavor score"),
                MethodStage(id: "body", title: "Body, Acidity & Balance",
                    prompt: "Judge texture, brightness, and whether they work together.",
                    guidance: "Run the coffee over your tongue: body is weight and texture (tea-like to heavy). Acidity should be lively. Balance is whether acidity, sweetness, bitterness and body support each other.",
                    ratingLabel: "Balance score"),
                MethodStage(id: "finish", title: "Sweetness, Clean Cup & Aftertaste",
                    prompt: "Evaluate sweetness, absence of defects, and length of finish.",
                    guidance: "Sweetness is a distinct cupping criterion - look for it explicitly. Clean cup means zero off-flavors (ferment, mold, paper). Aftertaste should be pleasant and persistent.",
                    ratingLabel: "Clean cup score")
            ]),
        MethodInfo(
            key: "aeropress", name: "AeroPress",
            blurb: "Versatile immersion-press: clean body with paper-filtered clarity.",
            parameters: [
                ("Grind", "Medium-fine"),
                ("Ratio", "1:13-1:15 (e.g. 15 g to 220 ml)"),
                ("Brew time", "1:30-2:30"),
                ("Water", "85-92 C")
            ],
            stages: [
                MethodStage(id: "fragrance", title: "Dry Fragrance",
                    prompt: "Smell the grounds before adding water.",
                    guidance: "Quick but valuable: dry fragrance sets your expectations for fruit and florals.",
                    ratingLabel: "Fragrance"),
                MethodStage(id: "aroma", title: "Aroma",
                    prompt: "Smell right after pouring and stirring.",
                    guidance: "AeroPress aromas are fresh and bright since the brew is short and enclosed.",
                    ratingLabel: "Aroma"),
                MethodStage(id: "taste", title: "Flavor",
                    prompt: "Taste as soon as pressed; then again as it cools.",
                    guidance: "The press produces a hybrid of immersion richness and filter cleanliness. Compare what you taste against the dry fragrance.",
                    ratingLabel: "Flavor"),
                MethodStage(id: "body", title: "Body",
                    prompt: "Judge the weight versus a pour-over.",
                    guidance: "Expect a rounder body than pour-over but cleaner than French press - the paper removes oils.",
                    ratingLabel: "Body"),
                MethodStage(id: "finish", title: "Finish",
                    prompt: "Note the aftertaste.",
                    guidance: "Finish tends to be short and clean. Long sourness suggests too fine a grind or too long a steep.",
                    ratingLabel: "Finish")
            ]),
        MethodInfo(
            key: "french-press", name: "French Press",
            blurb: "Full-immersion brew with a heavy, textured body.",
            parameters: [
                ("Grind", "Coarse"),
                ("Ratio", "1:15 (e.g. 30 g to 450 ml)"),
                ("Steep", "4:00"),
                ("Water", "93-96 C")
            ],
            stages: [
                MethodStage(id: "appearance", title: "Appearance",
                    prompt: "Look at the brew before plunging.",
                    guidance: "Note the bloom of grounds at the surface and the oil sheen on the liquid - metal-filter brews keep the oils, which carry aroma.",
                    ratingLabel: "Appearance"),
                MethodStage(id: "aroma", title: "Aroma",
                    prompt: "Stir the crust, skim it, and smell.",
                    guidance: "Push the floating crust aside and take short sniffs. The oils give French press a richer aroma than paper-filtered methods.",
                    ratingLabel: "Aroma"),
                MethodStage(id: "taste", title: "Flavor",
                    prompt: "Taste in small sips as it cools.",
                    guidance: "Immersion brings out deep sweetness and chocolatey or nutty depth; fine sediment can add texture but also astringency if the grind is too fine.",
                    ratingLabel: "Flavor"),
                MethodStage(id: "body", title: "Body",
                    prompt: "Feel the weight and sediment.",
                    guidance: "This is the fullest-bodied filter method - expect heavy, coating texture with some fines at the bottom of the cup.",
                    ratingLabel: "Body"),
                MethodStage(id: "finish", title: "Finish",
                    prompt: "Note the aftertaste.",
                    guidance: "Oils lengthen the finish. Note whether it stays pleasant or turns flat and papery.",
                    ratingLabel: "Finish")
            ]),
        MethodInfo(
            key: "moka", name: "Moka Pot",
            blurb: "Stovetop pressure brew: strong, bittersweet, espresso-adjacent.",
            parameters: [
                ("Grind", "Fine-medium"),
                ("Ratio", "1:10 (fill basket and base)"),
                ("Heat", "Low-medium, remove before sputtering"),
                ("Water", "Preheated below the valve")
            ],
            stages: [
                MethodStage(id: "appearance", title: "Appearance",
                    prompt: "Look at the stream into the top chamber.",
                    guidance: "Golden-honey flow is ideal; steam-driven spitting yields harsh, burnt notes. Stop the brew at the hiss.",
                    ratingLabel: "Appearance"),
                MethodStage(id: "aroma", title: "Aroma",
                    prompt: "Smell immediately after brewing.",
                    guidance: "Expect roasted, cocoa-forward aromas with a hint of caramelized sugar.",
                    ratingLabel: "Aroma"),
                MethodStage(id: "taste", title: "Taste",
                    prompt: "Sip; it is stronger than filter coffee.",
                    guidance: "Moka sits between espresso and filter: bittersweet with a roasted edge. Dilute with hot water (americano-style) to judge clarity too.",
                    ratingLabel: "Flavor"),
                MethodStage(id: "body", title: "Body",
                    prompt: "Judge the texture.",
                    guidance: "Body is heavy and rustic; some metallic notes can come from an unseasoned pot.",
                    ratingLabel: "Body"),
                MethodStage(id: "finish", title: "Finish",
                    prompt: "Note the aftertaste.",
                    guidance: "Ideally bittersweet cocoa; scorched flavors linger badly - note them if present.",
                    ratingLabel: "Finish")
            ]),
        MethodInfo(
            key: "cold-brew", name: "Cold Brew",
            blurb: "Long cold steep: smooth, low-acid, chocolatey.",
            parameters: [
                ("Grind", "Extra coarse"),
                ("Ratio", "1:8 (concentrate) or 1:15 (ready to drink)"),
                ("Steep", "12-24 h in the fridge"),
                ("Water", "Cold or room temp")
            ],
            stages: [
                MethodStage(id: "aroma", title: "Aroma",
                    prompt: "Smell over the cup.",
                    guidance: "Cold extraction captures fewer aromatics - expect subdued, mellow chocolate and nut rather than bright fruit.",
                    ratingLabel: "Aroma"),
                MethodStage(id: "taste", title: "Flavor",
                    prompt: "Taste at fridge temperature.",
                    guidance: "Acidity is naturally low: look for smooth cocoa, nut and vanilla sweetness instead of sparkle.",
                    ratingLabel: "Flavor"),
                MethodStage(id: "body", title: "Body",
                    prompt: "Judge the weight.",
                    guidance: "Cold brew is round and silky; astringency means the grind was too fine or the steep too long.",
                    ratingLabel: "Body"),
                MethodStage(id: "finish", title: "Finish",
                    prompt: "Note the aftertaste.",
                    guidance: "The finish should be clean and sweet; fermented off-notes survive cold extraction if beans were poor.",
                    ratingLabel: "Finish")
            ])
        ]

    static var varieties: [VarietyInfo] {
        curatedVarieties + WCRVarieties.catalog
    }

    /// All varieties, grouped and alphabetized for the picker menus.
    static var arabicaVarieties: [VarietyInfo] {
        varieties.filter { $0.species != "Robusta" }.sorted { $0.name < $1.name }
    }

    static var robustaVarieties: [VarietyInfo] {
        varieties.filter { $0.species == "Robusta" }.sorted { $0.name < $1.name }
    }

    static func variety(forKey key: String) -> VarietyInfo? {
        varieties.first { $0.key == key || $0.name == key }
    }

    /// True when the variety has specific cup descriptors. WCR catalog entries
    /// carry agronomic data only, so their tasting suggestions are generic.
    static func hasCupDescriptors(forKey key: String) -> Bool {
        curatedVarieties.contains { $0.key == key || $0.name == key }
    }

    static func process(forKey key: String) -> ProcessInfo? {
        processes.first { $0.key == key }
    }

    static func roast(forKey key: String) -> RoastInfo? {
        roasts.first { $0.key == key }
    }

    static func method(forKey key: String) -> MethodInfo? {
        methods.first { $0.key == key }
    }
}
