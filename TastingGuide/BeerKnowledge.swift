import Foundation

/// Reference data for beer styles and ingredients. When the user only knows
/// the style, these defaults provide the tasting guidance.
enum BeerKnowledge {
    struct StyleInfo {
        let key: String
        let name: String
        let blurb: String
        let appearance: [String]
        let aromas: [String]
        let flavors: [String]
        let bodyWords: [String]
        let finishWords: [String]
        let abvRange: ClosedRange<Double>
        let ibuRange: ClosedRange<Int>
        let servingTemp: String
        let glassware: String
        let tips: [String]
    }

    struct HopInfo {
        let key: String
        let name: String
        let descriptors: [String]
    }

    struct MaltInfo {
        let key: String
        let name: String
        let descriptors: [String]
    }

    struct YeastInfo {
        let key: String
        let name: String
        let descriptors: [String]
    }

    static let styles: [StyleInfo] = [
        StyleInfo(
            key: "american-ipa", name: "American IPA",
            blurb: "Hop-forward, assertively bitter pale ale with citrus-pine character.",
            appearance: ["Golden amber", "Crystal clear", "White head", "Lacing on the glass"],
            aromas: ["Grapefruit", "Pine", "Resin", "Citrus zest", "Floral", "Caramel (background)"],
            flavors: ["Grapefruit pith", "Pine resin", "Bitter finish", "Cracker malt", "Tangerine", "Tropical hint"],
            bodyWords: ["Medium", "Dry finish", "Crisp carbonation"],
            finishWords: ["Lingering bitterness", "Dry", "Resinous"],
            abvRange: 5.5...7.5, ibuRange: 40...70,
            servingTemp: "7-10 C", glassware: "Tulip or nonic pint",
            tips: [
                "Let it warm a few minutes out of the fridge; hop aroma opens up.",
                "Swirl gently, then take several short sniffs rather than one deep one."
            ]),
        StyleInfo(
            key: "hazy-ipa", name: "Hazy / New England IPA",
            blurb: "Juicy, low-bitterness IPA with a soft body and opaque look.",
            appearance: ["Hazy / opaque", "Straw to deep gold", "Dense white head", "Suspended haze"],
            aromas: ["Tropical fruit", "Juicy peach", "Mango", "Citrus juice (not zest)", "Stone fruit"],
            flavors: ["Juicy", "Soft bitterness", "Mango", "Peach", "Creamy oats", "Orange cream"],
            bodyWords: ["Soft and full", "Smooth", "Medium-low carbonation", "Creamy"],
            finishWords: ["Short, juicy", "Little bitterness", "Sweet-ish"],
            abvRange: 5.5...8.5, ibuRange: 20...45,
            servingTemp: "7-10 C", glassware: "Tulip or teku",
            tips: [
                "Haze and head retention are style traits, not flaws here.",
                "Freshness matters: check for a canned-on date if available."
            ]),
        StyleInfo(
            key: "double-ipa", name: "Double IPA",
            blurb: "Bigger, stronger IPA with intense hops and noticeable alcohol.",
            appearance: ["Deep gold to amber", "Clear to hazy", "Persisting head"],
            aromas: ["Intense citrus", "Tropical", "Resin", "Alcohol", "Sweet malt", "Peach"],
            flavors: ["Big hop bite", "Boozy warmth", "Grapefruit", "Sweet malt backbone", "Pine"],
            bodyWords: ["Full", "Slightly slick", "Warming"],
            finishWords: ["Long, bitter", "Alcohol warmth", "Resin"],
            abvRange: 7.5...10.0, ibuRange: 60...100,
            servingTemp: "8-12 C", glassware: "Tulip",
            tips: [
                "Sip slowly; warmth builds as it sits.",
                "Alcohol should warm, not burn - heat can mean aging or a rough ferment."
            ]),
        StyleInfo(
            key: "west-coast-ipa", name: "West Coast IPA",
            blurb: "The classic clear IPA: pine and grapefruit over a dry, crisp malt backbone.",
            appearance: ["Golden amber", "Brilliant clarity", "Sticky white head", "Lacing on the glass"],
            aromas: ["Pine", "Grapefruit pith", "Resin", "Cedar", "Caramel (background)"],
            flavors: ["Pine resin", "Grapefruit", "Cracker malt", "Dry finish", "Assertive bitter bite", "Dank"],
            bodyWords: ["Medium", "Dry", "Crisp carbonation"],
            finishWords: ["Lingering bitterness", "Dry", "Clean malt exit"],
            abvRange: 5.5...7.5, ibuRange: 45...70,
            servingTemp: "7-10 C", glassware: "Nonic pint or teku",
            tips: [
                "Compare with a hazy IPA side by side: clarity and dryness are the tell.",
                "Bitterness should be assertive but clean, never harsh."
            ]),
        StyleInfo(
            key: "english-ipa", name: "English IPA",
            blurb: "Historic style: biscuity malt with earthy, marmalade-like English hops.",
            appearance: ["Amber-gold", "Mostly clear", "Persistent head"],
            aromas: ["Marmalade", "Earthy hops", "Biscuit", "Lemon rind", "Honeyish malt"],
            flavors: ["Orange marmalade", "Earthy hop spice", "Biscuit malt", "Drying finish", "Fruity hint"],
            bodyWords: ["Medium", "Dry", "Moderate carbonation"],
            finishWords: ["Dry and bitter", "Hoppy-earthy", "Crisp for its strength"],
            abvRange: 5.0...7.5, ibuRange: 35...60,
            servingTemp: "8-10 C", glassware: "Nonic pint",
            tips: [
                "The hop signature is earthy and marmalade-like, not citrus-pine.",
                "Malt plays a bigger role than in American IPAs."
            ]),
        StyleInfo(
            key: "pale-lager", name: "German Pilsner / Pale Lager",
            blurb: "Crisp, snappy German-style pils with cracker malt and herbal-spicy hops.",
            appearance: ["Pale gold", "Brilliant clarity", "Bright white head", "Effervescent"],
            aromas: ["Cracker", "Bread", "Spicy hops", "Floral", "Grainy sweetness"],
            flavors: ["Crackers", "Pils malt", "Spicy hop bite", "Crisp", "Grainy", "Slight sweetness"],
            bodyWords: ["Light", "Dry", "High, sharp carbonation"],
            finishWords: ["Crisp and snappy", "Dry", "Clean"],
            abvRange: 4.0...5.5, ibuRange: 20...40,
            servingTemp: "4-7 C", glassware: "Flute or willi becher",
            tips: [
                "Cold is correct here; let the aromas come through anyway.",
                "Flaws show easily in lagers - any buttery or sulfur note is worth noting."
            ]),
        StyleInfo(
            key: "czech-lager", name: "Czech Pale Lager (Svetly Lezak)",
            blurb: "Decoction-brewed Bohemian lager: richer malt and softer bitterness than German pils.",
            appearance: ["Deep gold", "Brilliant", "Dense white head"],
            aromas: ["Rich bread crust", "Honeyed malt", "Saaz spice", "Floral"],
            flavors: ["Toasted bread", "Honey-like malt", "Spicy Saaz", "Soft round bitterness"],
            bodyWords: ["Medium-full (for a lager)", "Smooth", "Moderate carbonation"],
            finishWords: ["Malty finish", "Soft bitterness", "Balanced"],
            abvRange: 4.0...5.5, ibuRange: 20...35,
            servingTemp: "5-8 C", glassware: "Tulip or mug",
            tips: [
                "The decoction mash creates a malt depth German pils doesn't show.",
                "Saaz bitterness reads soft and rounded, never sharp."
            ]),
        StyleInfo(
            key: "italian-pilsner", name: "Italian Pilsner",
            blurb: "Modern Italian take: dry-hopped pilsner with a delicate hop veil over crisp malt.",
            appearance: ["Pale gold", "Brilliant clarity", "Bright head"],
            aromas: ["Delicate dry-hop aromatics", "Floral", "Fresh herbs", "Pils malt"],
            flavors: ["Cracker malt", "Noble hop flavor", "Green herb", "Balanced bitterness", "Clean"],
            bodyWords: ["Light-medium", "Crisp", "Softened by dry hop"],
            finishWords: ["Crisp", "Gently bitter", "Short and clean"],
            abvRange: 4.5...5.5, ibuRange: 22...35,
            servingTemp: "5-7 C", glassware: "Flute or willi becher",
            tips: [
                "Dry-hopping sets it apart from a classic pils: aroma leads, bitterness stays moderate.",
                "Tipopils lineage: look for a gentle hop veil over clean malt."
            ]),
        StyleInfo(
            key: "ipl", name: "India Pale Lager (IPL)",
            blurb: "Lager fermentation meets IPA hops: crisp, clean and cold-conditioned.",
            appearance: ["Deep gold", "Crystal clear", "Bright white head"],
            aromas: ["Bright tropical / citrus (dry hop)", "Clean lager base", "Floral"],
            flavors: ["Hop-forward tropical", "Clean cracker malt", "Crisp dryness", "Restrained esters"],
            bodyWords: ["Medium-light", "Very crisp", "Lagered smoothness"],
            finishWords: ["Clean hop bite", "Dry", "No lingering yeast"],
            abvRange: 5.5...7.5, ibuRange: 40...60,
            servingTemp: "5-8 C", glassware: "Lager glass or teku",
            tips: [
                "The hallmark is hop aroma over a flawlessly clean lager body.",
                "Any fruity esters blur the style - note their absence."
            ]),
        StyleInfo(
            key: "cream-ale", name: "Cream Ale",
            blurb: "American classic: cool-fermented ale with corn or rice for a smooth, light body.",
            appearance: ["Pale straw", "Brilliant clarity", "Short white head"],
            aromas: ["Corn sweetness", "Light grain", "Subtle fruity ester", "Floral hint"],
            flavors: ["Corn / grain sweetness", "Crisp", "Light fruit", "Low hop", "Smooth"],
            bodyWords: ["Light", "Creamy-smooth", "Moderate carbonation"],
            finishWords: ["Crisp and dry", "Clean", "Refreshingly light"],
            abvRange: 4.2...5.6, ibuRange: 10...25,
            servingTemp: "4-7 C", glassware: "Pint glass or tumbler",
            tips: [
                "Despite the name there is no cream - it is the smooth, corn-fed body.",
                "Notice how the adjunct softens the body versus an all-malt lager."
            ]),
        StyleInfo(
            key: "hefeweizen", name: "German Hefeweizen",
            blurb: "Cloudy wheat beer defined by banana and clove yeast character.",
            appearance: ["Hazy straw", "Tall, mousse-like head", "Yeast in suspension"],
            aromas: ["Banana", "Clove", "Bubblegum", "Wheat", "Vanilla hint"],
            flavors: ["Banana", "Clove spice", "Wheat bread", "Soft sweetness", "Light tartness"],
            bodyWords: ["Fluffy", "Light-medium", "Creamy carbonation"],
            finishWords: ["Soft", "Slightly tart", "Refreshing"],
            abvRange: 4.5...5.6, ibuRange: 8...15,
            servingTemp: "7-9 C", glassware: "Weizen vase",
            tips: [
                "Pour with the bottle rolling at the end to rouse the yeast.",
                "Banana vs cloye balance reflects fermentation temperature."
            ]),
        StyleInfo(
            key: "witbier", name: "Belgian Witbier",
            blurb: "Spiced wheat ale with orange peel and coriander.",
            appearance: ["Very pale straw", "Hazy", "Fluffy white head"],
            aromas: ["Coriander", "Orange peel", "Wheat", "Spicy", "Light grain"],
            flavors: ["Orange", "Coriander", "Wheat softness", "Spicy sweetness", "Creamy"],
            bodyWords: ["Light", "Silky", "Soft carbonation"],
            finishWords: ["Refreshing", "Spicy", "Dry-ish"],
            abvRange: 4.5...5.5, ibuRange: 8...20,
            servingTemp: "6-8 C", glassware: "Tumbler",
            tips: [
                "The spice comes from actual coriander and curaçao orange peel.",
                "Great beer for checking how spice and fruit interact on the nose."
            ]),
        StyleInfo(
            key: "saison", name: "Saison / Farmhouse Ale",
            blurb: "Dry, peppery, fruity farmhouse ale with rustic yeast character.",
            appearance: ["Deep gold", "Light haze acceptable", "Rocky white head"],
            aromas: ["Black pepper", "Orchard fruit", "Hay", "Lemon", "Earthy spice"],
            flavors: ["Peppery", "Dry fruitiness", "Hay / barnyard", "Cracker", "Lemon zest"],
            bodyWords: ["Light-medium", "Highly carbonated", "Dry"],
            finishWords: ["Very dry", "Spicy", "Lingering yeast notes"],
            abvRange: 5.0...8.0, ibuRange: 20...35,
            servingTemp: "8-12 C", glassware: "Tulip",
            tips: [
                "Yeast character is the star - look for pepper, hay, and stone fruit.",
                "Expect bone-dry finish with lively carbonation."
            ]),
        StyleInfo(
            key: "english-bitter", name: "English Bitter (Ordinary / Best / ESB)",
            blurb: "Cask-conditioned English session ale: Ordinary and Best are lighter, ESB richer.",
            appearance: ["Amber to copper", "Low carbonation", "Off-white head", "Slight haze acceptable"],
            aromas: ["Toasty malt", "Earthy English hops", "Apple / pear esters", "Biscuit"],
            flavors: ["Toasted malt", "Toffee", "Fruity esters", "Earthy hop", "Grainy sweetness"],
            bodyWords: ["Low carbonation", "Medium-light", "Soft cask feel"],
            finishWords: ["Malty-dry", "Gentle hop bitterness", "Moreish"],
            abvRange: 3.2...6.0, ibuRange: 25...40,
            servingTemp: "Cellar temp 11-13 C", glassware: "Nonic pint or dimpled mug",
            tips: [
                "Ordinary (~3.5%) through ESB (~5.5%): strength rises, malt depth follows.",
                "Served with low carbonation - focus on the malt and yeast interplay."
            ]),
        StyleInfo(
            key: "dubbel", name: "Belgian Dubbel",
            blurb: "Malty dark Belgian ale with raisin, plum and caramel notes.",
            appearance: ["Deep amber-brown", "Clear", "Dense tan head"],
            aromas: ["Raisin", "Plum", "Caramel", "Dark bread", "Light cocoa"],
            flavors: ["Dark fruit", "Caramel", "Bread crust", "Gentle cocoa", "Mild spice"],
            bodyWords: ["Medium-full", "Silky", "Smooth carbonation"],
            finishWords: ["Malty sweet", "Drying", "Subtle spice"],
            abvRange: 6.0...8.0, ibuRange: 15...25,
            servingTemp: "10-12 C", glassware: "Chalice or goblet",
            tips: [
                "Sweetness should be balanced by dryness from the Belgian yeast.",
                "Compare dark fruit notes to an American amber - subtler, less bitter."
            ]),
        StyleInfo(
            key: "tripel", name: "Belgian Tripel",
            blurb: "Strong golden ale with spicy yeast and deceptive lightness.",
            appearance: ["Pale gold", "Slight haze", "Huge creamy head"],
            aromas: ["Peppery", "Honey", "Pear", "Alcohol", "Candy sugar"],
            flavors: ["Spicy", "Honeyed sweetness", "Pear / apple", "Warm alcohol", "Bready"],
            bodyWords: ["Light but coating", "Highly carbonated", "Deceptively light"],
            finishWords: ["Dry for its strength", "Warming", "Spicy"],
            abvRange: 7.5...9.5, ibuRange: 20...35,
            servingTemp: "10-12 C", glassware: "Chalice",
            tips: [
                "The candy sugar dries out the beer - strength hides in the finish.",
                "Take small sips; it opens up as it warms."
            ]),
        StyleInfo(
            key: "amber-ale", name: "Amber / Red Ale",
            blurb: "Malt-forward ale with toffee, caramel and a balanced hop edge.",
            appearance: ["Amber to copper-red", "Clear", "Off-white head"],
            aromas: ["Toffee", "Caramel", "Toast", "Light citrus", "Biscuit"],
            flavors: ["Caramel", "Toasted malt", "Toffee", "Light citrus", "Bread crust"],
            bodyWords: ["Medium", "Smooth", "Moderate carbonation"],
            finishWords: ["Malt-leaning", "Balanced bitterness", "Toasty"],
            abvRange: 4.5...6.5, ibuRange: 20...35,
            servingTemp: "8-10 C", glassware: "Nonic pint",
            tips: [
                "Focus on malt depth: layers of toast, caramel and biscuit.",
                "Hops should support, not dominate."
            ]),
        StyleInfo(
            key: "brown-ale", name: "Brown Ale",
            blurb: "Nutty, gently roasted ale with chocolate and toast undertones.",
            appearance: ["Chestnut brown", "Clear", "Tan head"],
            aromas: ["Hazelnut", "Toasted bread", "Chocolate", "Caramel", "Nutty"],
            flavors: ["Nutty", "Milk chocolate", "Toast", "Caramel", "Slight earthy hops"],
            bodyWords: ["Medium", "Round", "Soft carbonation"],
            finishWords: ["Malty", "Gently nutty", "Low bitterness"],
            abvRange: 4.5...6.5, ibuRange: 15...30,
            servingTemp: "8-10 C", glassware: "Nonic pint",
            tips: [
                "Roast should be gentle, more toast than burnt.",
                "Look for nutty toffee interplay on the mid-palate."
            ]),
        StyleInfo(
            key: "dry-stout", name: "Dry Stout",
            blurb: "Roasty black beer with coffee character and a famously dry finish.",
            appearance: ["Black", "Persistent tan head", "Opaque"],
            aromas: ["Roasted barley", "Coffee", "Dark chocolate", "Slight earthy hop"],
            flavors: ["Roasted barley", "Espresso bitterness", "Dark chocolate", "Bone dry"],
            bodyWords: ["Light-medium", "Smooth", "Nitro feel if on tap"],
            finishWords: ["Very dry", "Roasty bitterness", "Clean"],
            abvRange: 3.8...5.0, ibuRange: 25...45,
            servingTemp: "8-10 C", glassware: "Stout tulip",
            tips: [
                "Despite the color it is light-bodied - note the dryness.",
                "Dark roast character is the profile; burnt harshness is a flaw."
            ]),
        StyleInfo(
            key: "imperial-stout", name: "Imperial Stout",
            blurb: "Massive dark beer with chocolate, dark fruit and warming alcohol.",
            appearance: ["Pitch black", "Thick mocha head", "Oily legs"],
            aromas: ["Dark chocolate", "Dark fruit", "Molasses", "Roast", "Boozy"],
            flavors: ["Bittersweet chocolate", "Raisin / prune", "Molasses", "Roast", "Warming"],
            bodyWords: ["Full", "Viscous", "Coating"],
            finishWords: ["Long roast", "Warming", "Bittersweet"],
            abvRange: 8.0...12.0, ibuRange: 50...80,
            servingTemp: "12-14 C", glassware: "Snifter",
            tips: [
                "Serve cool, not cold, and let it sit - aromas evolve for 15+ minutes.",
                "Sip tiny amounts; look for chocolate, fruit and roast layers."
            ]),
        StyleInfo(
            key: "porter", name: "Porter",
            blurb: "Balanced dark ale with chocolate and caramel maltiness.",
            appearance: ["Dark brown", "Ruby edges", "Tan head"],
            aromas: ["Chocolate", "Caramel", "Toffee", "Roasted malt", "Mild fruit"],
            flavors: ["Chocolate", "Caramel", "Toast", "Roast", "Slight sweetness"],
            bodyWords: ["Medium", "Smooth", "Moderate carbonation"],
            finishWords: ["Malty", "Mild roast", "Low-medium bitterness"],
            abvRange: 4.5...7.0, ibuRange: 20...40,
            servingTemp: "10-12 C", glassware: "Nonic pint or tulip",
            tips: [
                "Compared to stout: less roast, more caramel sweetness.",
                "Check for fruity esters layered under the chocolate."
            ]),
        StyleInfo(
            key: "marzen", name: "Märzen / Oktoberfest",
            blurb: "Toasty amber lager with bread crust and a clean finish.",
            appearance: ["Amber-orange", "Brilliant clarity", "Off-white head"],
            aromas: ["Bread crust", "Toast", "Munich malt", "Light noble hops"],
            flavors: ["Toasted bread", "Maltiness", "Cracker", "Subtle hop spice"],
            bodyWords: ["Medium", "Smooth lager body", "Moderate carbonation"],
            finishWords: ["Clean", "Malty-dry", "Balanced"],
            abvRange: 5.5...6.5, ibuRange: 18...28,
            servingTemp: "7-9 C", glassware: "Maß or dimpled mug",
            tips: [
                "All about Munich malt depth: crust, toast and a whisper of sweetness.",
                "Lager smoothness means no yeast fruitiness - note the clean finish."
            ]),
        StyleInfo(
            key: "doppelbock", name: "Bock / Doppelbock",
            blurb: "Deep, malty lager with toffee, dark fruit and big body.",
            appearance: ["Deep copper-brown", "Clear", "Creamy tan head"],
            aromas: ["Toffee", "Caramelized sugar", "Dark bread", "Plum", "Munich malt"],
            flavors: ["Toffee", "Dark bread", "Raisin", "Malt sweetness", "Clean alcohol"],
            bodyWords: ["Full", "Silky", "Gentle carbonation"],
            finishWords: ["Lingering malt", "Slightly sweet", "Warming"],
            abvRange: 6.5...9.5, ibuRange: 15...30,
            servingTemp: "10-12 C", glassware: "Willi becher",
            tips: [
                "Malt complexity without roast; warmth without harshness.",
                "Aroma should lean toffee and bread pudding."
            ]),
        StyleInfo(
            key: "barleywine", name: "Barleywine",
            blurb: "Intense, richly malty strong ale with big fruit and hop backbone.",
            appearance: ["Deep amber to mahogany", "Low head", "Legs on the glass"],
            aromas: ["Dark fruit", "Caramel", "Sherry-like", "Hops (English types)", "Alcohol"],
            flavors: ["Toffee", "Raisin", "Fig", "Resinous hops", "Warming"],
            bodyWords: ["Full", "Syrupy", "Low carbonation"],
            finishWords: ["Long", "Bittersweet", "Warming"],
            abvRange: 8.0...12.0, ibuRange: 40...80,
            servingTemp: "12-14 C", glassware: "Snifter",
            tips: [
                "Sip and savor; the profile changes as it warms.",
                "Vintage matters - age softens hops and adds sherry notes."
            ]),
        StyleInfo(
            key: "berliner-weisse", name: "Berliner Weisse / Sour Ale",
            blurb: "Tart, light wheat beer with lactic sourness.",
            appearance: ["Pale straw", "Hazy", "Short-lived head"],
            aromas: ["Lactic tang", "Wheat", "Light fruit", "Clean tartness"],
            flavors: ["Tart", "Lactic", "Lemon", "Wheat", "Light cracker"],
            bodyWords: ["Very light", "Prickly carbonation", "Crisp"],
            finishWords: ["Very dry", "Tart", "Clean and short"],
            abvRange: 2.5...5.0, ibuRange: 3...10,
            servingTemp: "6-8 C", glassware: "Berliner bowl",
            tips: [
                "Sourness should be clean, like yogurt or lemon, not vinegar.",
                "Great palate calibration beer - note acidity before sweetness."
            ]),
        StyleInfo(
            key: "gose", name: "Gose",
            blurb: "Salty, tart wheat ale brewed with coriander.",
            appearance: ["Hazy pale gold", "Thin white head"],
            aromas: ["Salt", "Coriander", "Lactic tang", "Wheat"],
            flavors: ["Tart", "Salty", "Coriander", "Lemon", "Wheat"],
            bodyWords: ["Light", "Refreshing", "Light carbonation"],
            finishWords: ["Dry", "Saline", "Tart"],
            abvRange: 4.0...5.5, ibuRange: 5...12,
            servingTemp: "6-8 C", glassware: "Tumbler",
            tips: [
                "Salt and acid interact on the tongue - note where each lands.",
                "Coriander should be herbal, not overpowering."
            ]),
        StyleInfo(
            key: "scotch-ale", name: "Scottish / Scotch Ale",
            blurb: "Malty-sweet, full ale with caramel and a whisper of smoke.",
            appearance: ["Deep copper-brown", "Clear", "Creamy head"],
            aromas: ["Caramel", "Toffee", "Peat smoke hint", "Bready"],
            flavors: ["Caramel", "Toasted malt", "Mild smoke", "Raisin", "Sweet"],
            bodyWords: ["Full", "Malt-coating", "Low carbonation"],
            finishWords: ["Sweet", "Gently smoky", "Malty"],
            abvRange: 6.0...10.0, ibuRange: 15...30,
            servingTemp: "10-12 C", glassware: "Thistle glass",
            tips: [
                "Balance is malt vs smoke, not malt vs hops.",
                "Look for kettle caramelization (toffee) rather than roasted notes."
            ]),
        StyleInfo(
            key: "sour-funky", name: "Wild / Funky Sour",
            blurb: "Barrel-aged sour with barnyard funk and complex acidity.",
            appearance: ["Variable amber", "Hazy", "Little head"],
            aromas: ["Hay", "Leather", "Barnyard", "Green apple", "Oak"],
            flavors: ["Funky", "Tart", "Green apple", "Earthy", "Oak tannin"],
            bodyWords: ["Light-medium", "Dry", "Tannic edge"],
            finishWords: ["Tart", "Earthy", "Long funky"],
            abvRange: 5.0...9.0, ibuRange: 0...15,
            servingTemp: "10-12 C", glassware: "Stemmed tulip",
            tips: [
                "Funk (Brettanomyces) reads as hay, leather or barnyard.",
                "Acidity can be lactic (soft) or acetic (vinegar) - note which."
            ])
    ]

    /// What a well-made example of each style should show at every stage,
    /// including what would be off-style (e.g. haze in a West Coast IPA).
    struct StageExpectations {
        let appearance: String
        let aroma: String
        let taste: String
        let mouthfeel: String
        let finish: String

        func forStage(_ id: String) -> String? {
            switch id {
            case "appearance": return appearance
            case "aroma": return aroma
            case "taste": return taste
            case "mouthfeel": return mouthfeel
            case "finish": return finish
            default: return nil
            }
        }
    }

    static let expectations: [String: StageExpectations] = [
        "american-ipa": StageExpectations(
            appearance: "Clear to slightly hazy gold-amber with a lasting white head; heavy haze would be off-style.",
            aroma: "Hop-led nose - citrus, pine, resin - over a gentle caramel backdrop; malt should not dominate.",
            taste: "Assertive hop bitterness up front with cracker-dry malt behind; hop flavor should echo the nose.",
            mouthfeel: "Medium body with crisp carbonation; it should dry out rather than sit sweet.",
            finish: "Long, dry, resiny bitterness that invites the next sip."),
        "west-coast-ipa": StageExpectations(
            appearance: "Brilliant clarity is the hallmark - haze would be off-style; gold to amber with sticky lace.",
            aroma: "Pine, grapefruit pith and resin lead; malt stays well in the background.",
            taste: "Dry, crackery malt under assertive, clean bitterness; juicy tropical softness is not the target.",
            mouthfeel: "Medium, dry and crisp; a sweet or heavy body would be off-style.",
            finish: "Long, clean bitterness with a dry malt exit."),
        "english-ipa": StageExpectations(
            appearance: "Amber-gold, mostly clear, with a persistent head.",
            aroma: "Earthy, marmalade-like English hops over biscuity malt.",
            taste: "Biscuit malt and orange marmalade in balance; bitterness firm but earthy, never sharp pine.",
            mouthfeel: "Medium and dry with moderate carbonation.",
            finish: "Dry, hoppy-earthy; crisper than its strength suggests."),
        "hazy-ipa": StageExpectations(
            appearance: "Opaque haze is expected, not a flaw; expect a dense, long-lasting white head.",
            aroma: "Juicy, fruit-forward aromatics; harsh pine resin would be off-style.",
            taste: "Soft, low bitterness with juicy stone and tropical fruit over a light, sweetish malt base.",
            mouthfeel: "Soft, full, creamy body with lower carbonation; crisp dryness would be off-style.",
            finish: "Short and juicy with little lingering bitterness."),
        "double-ipa": StageExpectations(
            appearance: "Deep gold to amber, clarity varies, with a sustained head and visible legs.",
            aroma: "Intense hop aromatics with a noticeable but clean alcohol lift.",
            taste: "Big hop bite over firm malt; the alcohol warms but should not burn.",
            mouthfeel: "Full, slightly slick and warming.",
            finish: "Long, bitter, warming - resiny and persistent."),
        "english-bitter": StageExpectations(
            appearance: "Amber to copper; low carbonation is correct for cask; slight haze is fine.",
            aroma: "Toasty malt, fruity apple-pear esters and earthy hops.",
            taste: "Malt-forward with restrained English hop balance; bitterness should be gentle.",
            mouthfeel: "Low, soft carbonation with a medium-light cask body.",
            finish: "Malty-dry and moreish, pulling you back for the next sip."),
        "cream-ale": StageExpectations(
            appearance: "Pale straw and brilliantly clear with a short white head.",
            aroma: "Light grain, corn sweetness and only faint esters.",
            taste: "Smooth, lightly sweet grain with minimal hop presence.",
            mouthfeel: "Light and creamy-smooth; any harshness is off-style.",
            finish: "Crisp, dry, clean and refreshing."),
        "pale-lager": StageExpectations(
            appearance: "Pale gold, brilliantly clear and sparkling, under a dense white head.",
            aroma: "Cracker-dry malt with spicy-floral noble hops.",
            taste: "Crisp pils malt and a snappy hop bite; sweetness should be minimal.",
            mouthfeel: "Light body with high, sharp carbonation.",
            finish: "Dry and snappy with a clean, bitter exit."),
        "czech-lager": StageExpectations(
            appearance: "Deep gold, brilliant, with a dense lasting head.",
            aroma: "Richer, honeyed bread crust than German pils, with Saaz spice.",
            taste: "Toastier malt fullness with soft, rounded Saaz bitterness - never sharp.",
            mouthfeel: "Medium-full for a lager and smooth; thinness would be off-style.",
            finish: "Malty with soft bitterness - a fuller exit than German pils."),
        "italian-pilsner": StageExpectations(
            appearance: "Pale gold with brilliant clarity.",
            aroma: "A delicate dry-hop veil over pils malt - floral and fresh-herb.",
            taste: "Clean cracker malt with moderate noble-hop flavor; aroma leads, bitterness stays restrained.",
            mouthfeel: "Light-medium and crisp.",
            finish: "Short, clean, gently bitter."),
        "ipl": StageExpectations(
            appearance: "Deep gold and crystal clear; haze would be off-style.",
            aroma: "Bright dry-hop aromatics over a clean lager base; no yeast fruitiness.",
            taste: "Hop flavor forward over clean cracker malt; esters should be absent.",
            mouthfeel: "Medium-light, very crisp, with lagered smoothness.",
            finish: "Clean hop bite, dry, with no yeast echo."),
        "hefeweizen": StageExpectations(
            appearance: "Hazy straw with a towering mousse head; brilliant clarity would make it a Kristalweizen.",
            aroma: "Banana and clove dominate; hop aromatics should be nearly absent.",
            taste: "Wheat softness with banana-clove balance; bitterness minimal.",
            mouthfeel: "Fluffy, creamy carbonation on a light-medium body.",
            finish: "Soft, slightly tart and refreshing."),
        "witbier": StageExpectations(
            appearance: "Very pale, hazy straw with a fluffy head; the haze is expected from wheat and proteins.",
            aroma: "Coriander and orange peel over soft wheat.",
            taste: "Spicy-sweet wheat with orange notes and low bitterness.",
            mouthfeel: "Light, silky, softly carbonated.",
            finish: "Refreshing, spicy, dry-ish."),
        "saison": StageExpectations(
            appearance: "Deep gold with a rocky white head; light haze is acceptable.",
            aroma: "Peppery yeast, orchard fruit and hay.",
            taste: "Dry, spicy and fruity; rustic yeast character leads.",
            mouthfeel: "Light-medium body with very high carbonation.",
            finish: "Bone dry, spicy, with lingering yeast notes."),
        "dubbel": StageExpectations(
            appearance: "Deep amber-brown, clear, under a dense tan head.",
            aroma: "Raisin, plum, caramel and dark bread.",
            taste: "Dark fruit and caramel with gentle cocoa behind; yeast spice underneath.",
            mouthfeel: "Medium-full, silky, with smooth carbonation.",
            finish: "Malty sweet that dries to subtle spice."),
        "tripel": StageExpectations(
            appearance: "Pale gold with slight haze and a huge, creamy head.",
            aroma: "Peppery, honeyed, pear-like with noticeable alcohol.",
            taste: "Spicy-fruity with honeyed sweetness that dries out; warming.",
            mouthfeel: "Light but coating, highly carbonated - deceptively light.",
            finish: "Dry for its strength, warming and spicy."),
        "amber-ale": StageExpectations(
            appearance: "Amber to copper-red, clear, with an off-white head.",
            aroma: "Toffee, toast and light citrus.",
            taste: "Caramel-forward malt with supportive hops; balance leans malty.",
            mouthfeel: "Medium and smooth.",
            finish: "Malty with balanced bitterness."),
        "brown-ale": StageExpectations(
            appearance: "Chestnut brown, clear, with a tan head.",
            aroma: "Nutty, toasted, gently chocolatey.",
            taste: "Nutty toast and light chocolate with mild bitterness.",
            mouthfeel: "Medium, round and soft.",
            finish: "Malty and gently nutty."),
        "dry-stout": StageExpectations(
            appearance: "Jet black and opaque with a persistent tan head.",
            aroma: "Roasted barley, coffee and dark chocolate.",
            taste: "Espresso-like roast over a bone-dry backbone; sweetness would be off-style.",
            mouthfeel: "Light-medium and smooth - not heavy despite the color.",
            finish: "Very dry, roasty and clean."),
        "imperial-stout": StageExpectations(
            appearance: "Pitch black with a thick mocha head and oily legs.",
            aroma: "Dark chocolate, dark fruit, molasses and alcohol.",
            taste: "Bittersweet chocolate and dark fruit; dense and warming.",
            mouthfeel: "Full, viscous and coating.",
            finish: "Long roast, warming, bittersweet."),
        "porter": StageExpectations(
            appearance: "Dark brown with ruby edges under a tan head.",
            aroma: "Chocolate, caramel and a touch of roast.",
            taste: "Chocolate-caramel balance with roast behind; sweeter and less burnt than stout.",
            mouthfeel: "Medium and smooth.",
            finish: "Malty with mild roast."),
        "marzen": StageExpectations(
            appearance: "Amber-orange with brilliant clarity.",
            aroma: "Bread crust and toast with a light noble spiciness.",
            taste: "Toasted malt richness with a clean lager finish; bitterness low to moderate.",
            mouthfeel: "Medium and smooth.",
            finish: "Clean and malt-dry."),
        "doppelbock": StageExpectations(
            appearance: "Deep copper-brown, clear, with a creamy tan head.",
            aroma: "Toffee, dark bread and plum.",
            taste: "Deep malt sweetness with clean, non-harsh alcohol; hops stay in the background.",
            mouthfeel: "Full and silky with gentle carbonation.",
            finish: "Lingering malt, slightly sweet and warming."),
        "barleywine": StageExpectations(
            appearance: "Deep amber to mahogany with a low head and legs on the glass.",
            aroma: "Dark fruit, caramel, sherry-like notes, English hops and alcohol.",
            taste: "Toffee, raisin and fig over resinous hops; intense but balanced.",
            mouthfeel: "Full, syrupy, with low carbonation.",
            finish: "Long, bittersweet and warming."),
        "berliner-weisse": StageExpectations(
            appearance: "Pale straw, hazy, with a short-lived head.",
            aroma: "Lactic tang, wheat and light fruit.",
            taste: "Clean tartness with light wheat sweetness; sour like lemon or yogurt, never vinegar.",
            mouthfeel: "Very light and prickly.",
            finish: "Very dry, tart and short."),
        "gose": StageExpectations(
            appearance: "Hazy pale gold with a thin white head.",
            aroma: "Salt, coriander and a lactic tang.",
            taste: "Tart and saline with coriander spice; the salt should be subtle, not briny.",
            mouthfeel: "Light and refreshing.",
            finish: "Dry, saline and tart."),
        "scotch-ale": StageExpectations(
            appearance: "Deep copper-brown, clear, with a creamy head.",
            aroma: "Caramel, toffee and a faint whiff of peat smoke.",
            taste: "Deep malt sweetness with a whisper of smoke; hop presence minimal.",
            mouthfeel: "Full, malt-coating, with low carbonation.",
            finish: "Sweet and gently smoky."),
        "sour-funky": StageExpectations(
            appearance: "Variable amber, often hazy, with little head.",
            aroma: "Hay, leather, barnyard, green apple and oak.",
            taste: "Funky, tart and earthy; complexity from wild yeast and layered acidity.",
            mouthfeel: "Light-medium, dry, with a tannic edge.",
            finish: "Tart, earthy and long.")
    ]

    static func expectations(forKey key: String) -> StageExpectations? {
        expectations[key]
    }

    static let hops: [HopInfo] = [
        // US classic and modern
        HopInfo(key: "cascade", name: "Cascade", descriptors: ["Grapefruit", "Floral", "Citrus zest"]),
        HopInfo(key: "centennial", name: "Centennial", descriptors: ["Floral", "Lemon", "Citrus"]),
        HopInfo(key: "columbus", name: "Columbus / Zeus / CTZ", descriptors: ["Pungent", "Resinous", "Blackcurrant", "Dank"]),
        HopInfo(key: "chinook", name: "Chinook", descriptors: ["Pine", "Grapefruit", "Spicy"]),
        HopInfo(key: "amarillo", name: "Amarillo", descriptors: ["Orange", "Tangerine", "Floral"]),
        HopInfo(key: "simcoe", name: "Simcoe", descriptors: ["Pine", "Resin", "Grapefruit pith"]),
        HopInfo(key: "citra", name: "Citra", descriptors: ["Passionfruit", "Tropical", "Lime", "Gooseberry"]),
        HopInfo(key: "mosaic", name: "Mosaic", descriptors: ["Tropical", "Blueberry", "Pine", "Peach"]),
        HopInfo(key: "comet", name: "Comet", descriptors: ["Wild raspberry", "Tangerine", "Herbal"]),
        HopInfo(key: "cluster", name: "Cluster", descriptors: ["Earthy", "Floral", "Rustic spice"]),
        HopInfo(key: "nugget", name: "Nugget", descriptors: ["Herbal", "Woody", "Clean bittering"]),
        HopInfo(key: "warrior", name: "Warrior", descriptors: ["Clean bitterness", "Subtle citrus", "Pine hint"]),
        HopInfo(key: "magnum", name: "Magnum", descriptors: ["Neutral bittering", "Mild spice", "Subtle herbal"]),
        HopInfo(key: "azacca", name: "Azacca", descriptors: ["Mango", "Pineapple", "Citrus"]),
        HopInfo(key: "el-dorado", name: "El Dorado", descriptors: ["Tropical", "Pear", "Candy-like"]),
        HopInfo(key: "strata", name: "Strata", descriptors: ["Dank", "Berry", "Herbal"]),
        // European classic
        HopInfo(key: "saaz", name: "Saaz", descriptors: ["Spicy", "Herbal", "Noble floral"]),
        HopInfo(key: "hallertau", name: "Hallertau Mittelfrüh", descriptors: ["Grassy", "Floral", "Soft spice"]),
        HopInfo(key: "tettnang", name: "Tettnang", descriptors: ["Herbal", "Lemon spice", "Delicate"]),
        HopInfo(key: "spalt", name: "Spalt", descriptors: ["Woody", "Spicy", "Earthy noble"]),
        HopInfo(key: "perle", name: "Perle", descriptors: ["Minty", "Herbal", "Spicy"]),
        HopInfo(key: "northern-brewer", name: "Northern Brewer", descriptors: ["Minty", "Woody", "Pine", "Herbal"]),
        HopInfo(key: "challenger", name: "Challenger", descriptors: ["Cedar", "Earthy spice", "Fruity hint"]),
        HopInfo(key: "ektg", name: "East Kent Goldings", descriptors: ["Earthy", "Honey", "Marmalade"]),
        HopInfo(key: "fuggle", name: "Fuggle", descriptors: ["Earthy", "Woody", "Minty"]),
        HopInfo(key: "brewers-gold", name: "Brewers Gold", descriptors: ["Blackcurrant", "Spicy", "Rustic"]),
        HopInfo(key: "mandarina", name: "Mandarina Bavaria", descriptors: ["Mandarin", "Tangerine", "Bergamot"]),
        // Australia
        HopInfo(key: "galaxy", name: "Galaxy", descriptors: ["Passionfruit", "Peach", "Tropical"]),
        HopInfo(key: "vic-secret", name: "Vic Secret", descriptors: ["Pineapple", "Resin", "Tropical"]),
        HopInfo(key: "ella", name: "Ella", descriptors: ["Floral", "Tropical fruit", "Subtle spice"]),
        HopInfo(key: "enigma", name: "Enigma", descriptors: ["Pinot noir", "Dark fruit", "Raspberry", "Light tropical"]),
        HopInfo(key: "topaz", name: "Topaz", descriptors: ["Resinous", "Lychee", "Apricot", "Tropical"]),
        HopInfo(key: "helga", name: "Helga", descriptors: ["Floral", "Spicy", "Delicate herbal"]),
        HopInfo(key: "pride-of-ringwood", name: "Pride of Ringwood", descriptors: ["Woody", "Herbal", "Earthy"]),
        // New Zealand
        HopInfo(key: "nelson-sauvin", name: "Nelson Sauvin", descriptors: ["White wine", "Grape", "Fresh gooseberry"]),
        HopInfo(key: "nectaron", name: "Nectaron", descriptors: ["Nectarine", "Peach", "Passionfruit", "Tropical"]),
        HopInfo(key: "motueka", name: "Motueka", descriptors: ["Lime", "Lemon zest", "Tropical", "Fresh herbs"]),
        HopInfo(key: "riwaka", name: "Riwaka", descriptors: ["Grapefruit", "Passionfruit", "Intense citrus"]),
        HopInfo(key: "wakatu", name: "Wakatu", descriptors: ["Lime", "Floral", "Spice"]),
        HopInfo(key: "taiheke", name: "Taiheke", descriptors: ["Grapefruit", "Citrus", "Pine", "Floral"]),
        HopInfo(key: "pacific-jade", name: "Pacific Jade", descriptors: ["Citrus", "Herbal", "Black pepper"]),
        HopInfo(key: "pacific-gem", name: "Pacific Gem", descriptors: ["Earthy", "Woody", "Blackberry"]),
        HopInfo(key: "southern-cross", name: "Southern Cross", descriptors: ["Spice", "Lemon", "Woody"]),
        HopInfo(key: "dr-rudi", name: "Dr Rudi", descriptors: ["Pine", "Resin", "Pepper"]),
        HopInfo(key: "waimea", name: "Waimea", descriptors: ["Grapefruit", "Pine", "Resin", "Orange"]),
        HopInfo(key: "kohatu", name: "Kohatu", descriptors: ["Peach", "Pine", "Passionfruit"])
    ]

    static let malts: [MaltInfo] = [
        MaltInfo(key: "pilsner", name: "Pilsner malt", descriptors: ["Cracker", "Delicate grain", "Honeyish light"]),
        MaltInfo(key: "pale", name: "Pale ale malt", descriptors: ["Biscuit", "Bread", "Gentle toast"]),
        MaltInfo(key: "vienna", name: "Vienna", descriptors: ["Toast", "Biscuit", "Amber crust"]),
        MaltInfo(key: "munich", name: "Munich", descriptors: ["Bread crust", "Toffee", "Malty depth"]),
        MaltInfo(key: "melanoidin", name: "Melanoidin", descriptors: ["Rich bread crust", "Toasty", "Deep malt", "Honeyed depth"]),
        MaltInfo(key: "aromatic", name: "Aromatic", descriptors: ["Intense malt", "Biscuit", "Bread crust", "Warm toast"]),
        MaltInfo(key: "carahell", name: "CaraHell", descriptors: ["Honey", "Light caramel", "Soft sweetness"]),
        MaltInfo(key: "carapils", name: "CaraPils (dextrine)", descriptors: ["Subtle sweetness", "Fuller body", "Soft grain"]),
        MaltInfo(key: "crystal-40", name: "Crystal 40", descriptors: ["Caramel", "Light toffee"]),
        MaltInfo(key: "crystal-80", name: "Crystal 60-80", descriptors: ["Toffee", "Dark caramel"]),
        MaltInfo(key: "caramunich", name: "CaraMunich", descriptors: ["Dark caramel", "Toffee", "Raisin hint", "Bread crust"]),
        MaltInfo(key: "crystal-120", name: "Crystal 120", descriptors: ["Raisin", "Burnt sugar", "Prune"]),
        MaltInfo(key: "carared", name: "CaraRed", descriptors: ["Red fruit hint", "Caramel", "Biscuity sweetness"]),
        MaltInfo(key: "special-b", name: "Special B", descriptors: ["Raisin", "Dried fruit", "Burnt caramel", "Dark cherry"]),
        MaltInfo(key: "amber", name: "Amber malt", descriptors: ["Dry toast", "Biscuit", "Nutty"]),
        MaltInfo(key: "biscuit", name: "Biscuit / Victory", descriptors: ["Biscuity", "Nutty toast"]),
        MaltInfo(key: "pale-chocolate", name: "Pale chocolate malt", descriptors: ["Cocoa", "Light roast", "Coffee edge"]),
        MaltInfo(key: "chocolate", name: "Chocolate malt", descriptors: ["Chocolate", "Roast", "Coffee edge"]),
        MaltInfo(key: "brown-malt", name: "Brown malt", descriptors: ["Nutty roast", "Dry brown bread", "Toasted hazelnut"]),
        MaltInfo(key: "roasted-barley", name: "Roasted barley", descriptors: ["Coffee", "Burnt", "Dry roast"]),
        MaltInfo(key: "black", name: "Black malt", descriptors: ["Espresso", "Char", "Bitter roast"]),
        MaltInfo(key: "oat", name: "Oats", descriptors: ["Silky", "Soft nutty", "Creamy"]),
        MaltInfo(key: "rye", name: "Rye", descriptors: ["Spicy", "Earthy", "Dry grain"]),
        MaltInfo(key: "wheat", name: "Wheat", descriptors: ["Light bread", "Soft grain", "Slight haze"]),
        MaltInfo(key: "maize", name: "Flaked maize", descriptors: ["Corn sweetness", "Creamy light", "Cooked corn"]),
        MaltInfo(key: "rice", name: "Flaked rice", descriptors: ["Crisp dryness", "Neutral", "Light body"]),
        MaltInfo(key: "smoked", name: "Smoked malt", descriptors: ["Woodsmoke", "Campfire", "Bacon note"]),
        MaltInfo(key: "honey", name: "Honey malt", descriptors: ["Honey", "Sweet malt", "Golden"])
    ]

    static let yeasts: [YeastInfo] = [
        YeastInfo(key: "american-ale", name: "American ale yeast", descriptors: ["Clean", "Neutral", "Lets hops/malt shine"]),
        YeastInfo(key: "english-ale", name: "English ale yeast", descriptors: ["Apple", "Pear", "Fruity esters"]),
        YeastInfo(key: "hefeweizen", name: "Hefeweizen yeast", descriptors: ["Banana", "Clove", "Bubblegum"]),
        YeastInfo(key: "belgian", name: "Belgian ale yeast", descriptors: ["Peppery", "Phenolic", "Stone fruit"]),
        YeastInfo(key: "lager", name: "Lager yeast", descriptors: ["Clean", "Crisp", "Restrained"]),
        YeastInfo(key: "kveik", name: "Kveik", descriptors: ["Tropical ester", "Peach", "Clean"])
    ]

    static func style(forKey key: String) -> StyleInfo? {
        styles.first { $0.key == key || $0.name == key }
    }

    /// Accepts either the internal key or the display name: the UI pickers
    /// store display names, while older records may hold keys.
    static func hop(forKey key: String) -> HopInfo? {
        hops.first { $0.key == key || $0.name == key }
    }

    static func malt(forKey key: String) -> MaltInfo? {
        malts.first { $0.key == key || $0.name == key }
    }

    static func yeast(forKey key: String) -> YeastInfo? {
        yeasts.first { $0.key == key || $0.name == key }
    }
}
