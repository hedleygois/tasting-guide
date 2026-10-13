import Foundation

/// Reference data for wine: types, grape varieties, regions and tasting guidance.
enum WineKnowledge {

    // MARK: - Wine Types

    struct WineTypeInfo {
        let key: String
        let name: String
        let blurb: String
        let appearance: [String]
        let aromas: [String]
        let flavors: [String]
        let bodyWords: [String]
        let finishWords: [String]
        let abvRange: ClosedRange<Double>
        let servingTemp: String
        let glassware: String
        let tips: [String]
    }

    static let wineTypes: [WineTypeInfo] = [
        // Red Wines
        WineTypeInfo(
            key: "cabernet-sauvignon",
            name: "Cabernet Sauvignon",
            blurb: "Bold, full-bodied red with dark fruit and firm tannins.",
            appearance: ["Deep ruby", "Opaque", "Purple edge when young"],
            aromas: ["Blackcurrant", "Cassis", "Black cherry", "Cedar", "Tobacco", "Vanilla", "Green bell pepper"],
            flavors: ["Blackcurrant", "Black cherry", "Plum", "Cedar", "Vanilla", "Mocha", "Tobacco"],
            bodyWords: ["Full-bodied", "Robust", "Firm tannins", "Dense"],
            finishWords: ["Long", "Tannic", "Drying", "Complex"],
            abvRange: 13.5...15.0,
            servingTemp: "16-18 C",
            glassware: "Bordeaux glass",
            tips: [
                "Decant young Cabernet Sauvignon for 1-2 hours to soften tannins.",
                "Look for the classic 'cassis' or blackcurrant note that defines the variety.",
                "Aging potential: 10-20 years for quality examples."
            ]
        ),
        WineTypeInfo(
            key: "merlot",
            name: "Merlot",
            blurb: "Medium to full-bodied red with soft tannins and plush fruit.",
            appearance: ["Deep ruby-red", "Bright", "Medium opacity"],
            aromas: ["Plum", "Red cherry", "Black cherry", "Cocoa", "Chocolate", "Herbal", "Cedar"],
            flavors: ["Plum", "Cherry", "Chocolate", "Cocoa powder", "Herbal", "Soft spice"],
            bodyWords: ["Medium to full", "Plush", "Soft tannins", "Velvety"],
            finishWords: ["Smooth", "Round", "Fruit-forward", "Moderate length"],
            abvRange: 13.0...14.5,
            servingTemp: "15-17 C",
            glassware: "Bordeaux glass",
            tips: [
                "Merlot is often blended with Cabernet Sauvignon to soften its tannins.",
                "Right bank Bordeaux is Merlot-dominant, showing more red fruit character.",
                "Look for a plush, velvety texture - a hallmark of well-made Merlot."
            ]
        ),
        WineTypeInfo(
            key: "pinot-noir",
            name: "Pinot Noir",
            blurb: "Elegant, light to medium-bodied red with red fruit and earthy complexity.",
            appearance: ["Pale to medium ruby", "Translucent", "Garnets edge with age"],
            aromas: ["Red cherry", "Strawberry", "Raspberry", "Violet", "Rose", "Earth", "Mushroom", "Forest floor"],
            flavors: ["Red cherry", "Strawberry", "Raspberry", "Earthy", "Mushroom", "Cola", "Spice"],
            bodyWords: ["Light to medium", "Silky", "Delicate", "Elegant"],
            finishWords: ["Soft", "Graceful", "Complex", "Long"],
            abvRange: 12.5...14.0,
            servingTemp: "12-14 C",
            glassware: "Burgundy glass",
            tips: [
                "Pinot Noir is notoriously difficult to grow and shows its terroir clearly.",
                "Serve slightly cooler than other reds to highlight its delicate aromatics.",
                "Look for earthy, forest floor notes that develop with age."
            ]
        ),
        WineTypeInfo(
            key: "syrah",
            name: "Syrah / Shiraz",
            blurb: "Full-bodied red with dark fruit, spice and sometimes a smoky edge.",
            appearance: ["Deep purple-ruby", "Opaque", "Inky"],
            aromas: ["Blackberry", "Blueberry", "Plum", "Black pepper", "Clove", "Smoke", "Bacon", "Olive"],
            flavors: ["Blackberry", "Blueberry", "Plum", "Black pepper", "Chocolate", "Smoke", "Meat"],
            bodyWords: ["Full-bodied", "Rich", "Dense", "Chewy"],
            finishWords: ["Spicy", "Long", "Warm", "Complex"],
            abvRange: 13.5...15.5,
            servingTemp: "16-18 C",
            glassware: "Bordeaux glass",
            tips: [
                "Northern Rhone Syrah (like Hermitage) shows more pepper and olive.",
                "Australian Shiraz tends to be fruit-forward and jammy.",
                "The smoky, meaty character comes from the grape, not oak aging."
            ]
        ),
        WineTypeInfo(
            key: "malbec",
            name: "Malbec",
            blurb: "Medium to full-bodied red with dark fruit, violet florals and smooth texture.",
            appearance: ["Deep purple-black", "Opaque", "Inky"],
            aromas: ["Blackberry", "Plum", "Black cherry", "Violet", "Cocoa", "Tobacco", "Vanilla"],
            flavors: ["Blackberry", "Plum", "Cherry", "Cocoa", "Vanilla", "Soft spice"],
            bodyWords: ["Medium to full", "Round", "Plush", "Soft tannins"],
            finishWords: ["Smooth", "Velvety", "Moderate length", "Fruit-forward"],
            abvRange: 13.0...14.5,
            servingTemp: "15-17 C",
            glassware: "Bordeaux glass",
            tips: [
                "Argentine Malbec is known for its deep color and plush texture.",
                "Originally from Bordeaux, it found its home in Argentina's high-altitude vineyards.",
                "Look for the signature violet floral note."
            ]
        ),
        WineTypeInfo(
            key: "sangiovese",
            name: "Sangiovese",
            blurb: "Medium-bodied red with bright acidity, red fruit and earthy notes.",
            appearance: ["Ruby to garnet", "Medium opacity", "Orange edge with age"],
            aromas: ["Red cherry", "Sour cherry", "Plum", "Tomato leaf", "Earth", "Dried herbs", "Leather"],
            flavors: ["Sour cherry", "Red cherry", "Plum", "Tomato leaf", "Earth", "Herbal", "Leather"],
            bodyWords: ["Medium", "High acidity", "Medium tannins", "Rustic"],
            finishWords: ["Dry", "Tannic", "Savory", "Moderate length"],
            abvRange: 12.5...14.0,
            servingTemp: "16-18 C",
            glassware: "Bordeaux glass",
            tips: [
                "Sangiovese is the backbone of Chianti and Brunello di Montalcino.",
                "High acidity makes it excellent with food, especially tomato-based dishes.",
                "Look for sour cherry and herbal notes - hallmarks of the variety."
            ]
        ),
        WineTypeInfo(
            key: "tempranillo",
            name: "Tempranillo",
            blurb: "Medium-bodied red with red fruit, leather and tobacco notes.",
            appearance: ["Medium ruby", "Medium opacity", "Garnets edge"],
            aromas: ["Red cherry", "Plum", "Strawberry", "Leather", "Tobacco", "Dill", "Cedar"],
            flavors: ["Red cherry", "Plum", "Leather", "Tobacco", "Vanilla", "Cocoa"],
            bodyWords: ["Medium", "Moderate tannins", "Moderate acidity", "Smooth"],
            finishWords: ["Soft", "Round", "Savory", "Moderate length"],
            abvRange: 13.0...14.5,
            servingTemp: "15-17 C",
            glassware: "Bordeaux glass",
            tips: [
                "Tempranillo is Spain's noble grape, the main variety in Rioja.",
                "Oak aging adds vanilla and dill notes to Rioja.",
                "Look for a balance of red fruit and earthy, savory notes."
            ]
        ),
        WineTypeInfo(
            key: "barbera",
            name: "Barbera",
            blurb: "Medium-bodied red with high acidity, red fruit and soft tannins.",
            appearance: ["Deep ruby", "Translucent", "Bright"],
            aromas: ["Black cherry", "Red cherry", "Blackberry", "Violet", "Spice"],
            flavors: ["Black cherry", "Red cherry", "Blackberry", "Plum", "Spice"],
            bodyWords: ["Medium", "High acidity", "Low tannins", "Juicy"],
            finishWords: ["Fresh", "Bright", "Fruit-forward", "Clean"],
            abvRange: 13.0...14.5,
            servingTemp: "14-16 C",
            glassware: "Bordeaux glass",
            tips: [
                "Barbera from Piedmont, Italy, is known for its bright acidity.",
                "The low tannins make it approachable young.",
                "High acidity makes it very food-friendly."
            ]
        ),
        WineTypeInfo(
            key: "nebbiolo",
            name: "Nebbiolo",
            blurb: "Medium to full-bodied red with high acidity, high tannins and complex aromatics.",
            appearance: ["Pale ruby", "Translucent", "Garnets edge", "Orange hues with age"],
            aromas: ["Rose", "Tar", "Truffle", "Leather", "Red cherry", "Strawberry", "Earth"],
            flavors: ["Red cherry", "Strawberry", "Rose", "Tar", "Truffle", "Leather", "Tannic"],
            bodyWords: ["Medium to full", "High acidity", "High tannins", "Structured"],
            finishWords: ["Long", "Drying", "Complex", "Powerful"],
            abvRange: 13.5...15.0,
            servingTemp: "16-18 C",
            glassware: "Bordeaux glass",
            tips: [
                "Nebbiolo from Barolo and Barbaresco in Piedmont is Italy's most age-worthy wine.",
                "Young Nebbiolo can be astringent; decanting or aging helps.",
                "Look for the classic 'tar and roses' combination."
            ]
        ),
        
        // White Wines
        WineTypeInfo(
            key: "chardonnay",
            name: "Chardonnay",
            blurb: "Full-bodied white with diverse styles from crisp unoaked to rich buttery.",
            appearance: ["Pale straw", "Golden", "Bright", "Sometimes cloudy if unfiltered"],
            aromas: ["Apple", "Pear", "Citrus", "Melon", "Butter", "Vanilla", "Toast", "Brioche"],
            flavors: ["Apple", "Pear", "Citrus", "Melon", "Butter", "Vanilla", "Toast", "Caramel"],
            bodyWords: ["Medium to full", "Creamy", "Rich", "Oily"],
            finishWords: ["Long", "Buttery", "Complex", "Clean"],
            abvRange: 12.5...14.5,
            servingTemp: "10-12 C",
            glassware: "Burgundy glass",
            tips: [
                "Unoaked Chardonnay shows crisp apple and citrus notes.",
                "Oaked Chardonnay has butter, vanilla and toast from barrel aging.",
                "Chablis from Burgundy is a classic unoaked, mineral-driven style."
            ]
        ),
        WineTypeInfo(
            key: "sauvignon-blanc",
            name: "Sauvignon Blanc",
            blurb: "Crisp, aromatic white with herbal and citrus notes.",
            appearance: ["Pale straw", "Water-white", "Green tints", "Bright"],
            aromas: ["Grapefruit", "Lime", "Passion fruit", "Gooseberry", "Grass", "Bell pepper", "Cat pee"],
            flavors: ["Grapefruit", "Lime", "Passion fruit", "Grass", "Herbal", "Mineral"],
            bodyWords: ["Light to medium", "Crisp", "High acidity", "Zesty"],
            finishWords: ["Clean", "Fresh", "Bright", "Herbal"],
            abvRange: 12.0...13.5,
            servingTemp: "8-10 C",
            glassware: "Sauvignon Blanc glass",
            tips: [
                "Sancerre and Pouilly-Fume from the Loire are classic examples.",
                "New Zealand Sauvignon Blanc is known for its intense passion fruit character.",
                "The 'cat pee' aroma (pyrazine) is a distinctive marker of the variety."
            ]
        ),
        WineTypeInfo(
            key: "riesling",
            name: "Riesling",
            blurb: "Aromatic white ranging from bone-dry to lusciously sweet.",
            appearance: ["Pale straw", "Green tints", "Golden when aged", "Bright"],
            aromas: ["Lime", "Green apple", "Peach", "Apricot", "Petrol", "Honey", "Gasoline"],
            flavors: ["Lime", "Green apple", "Peach", "Apricot", "Honey", "Mineral", "Petrol"],
            bodyWords: ["Light to medium", "High acidity", "Often off-dry or sweet", "Silky"],
            finishWords: ["Long", "Clean", "Mineral", "Sweet or dry depending on style"],
            abvRange: 8.0...12.0,
            servingTemp: "8-10 C",
            glassware: "Riesling glass",
            tips: [
                "Mosel Riesling is light, floral and often off-dry.",
                "Alsace Riesling is typically dry and fuller-bodied.",
                "Petrol or gasoline notes are normal and desirable in aged Riesling."
            ]
        ),
        WineTypeInfo(
            key: "pinot-grigio",
            name: "Pinot Grigio / Pinot Gris",
            blurb: "Crisp to medium-bodied white with citrus and stone fruit.",
            appearance: ["Pale straw", "Sometimes copper-pink", "Bright"],
            aromas: ["Pear", "Apple", "Citrus", "Almond", "Honey", "White flowers"],
            flavors: ["Pear", "Apple", "Citrus", "Almond", "Honey", "Spice"],
            bodyWords: ["Light to medium", "Crisp", "Moderate acidity", "Round"],
            finishWords: ["Clean", "Fresh", "Moderate length"],
            abvRange: 12.0...13.5,
            servingTemp: "8-10 C",
            glassware: "White wine glass",
            tips: [
                "Italian Pinot Grigio is typically light, crisp and dry.",
                "Alsace Pinot Gris is richer, with honey and spice notes.",
                "Skin contact can add copper color and more body."
            ]
        ),
        WineTypeInfo(
            key: "viognier",
            name: "Viognier",
            blurb: "Full-bodied, aromatic white with stone fruit and floral notes.",
            appearance: ["Golden", "Oily", "Deep color for white", "Bright"],
            aromas: ["Peach", "Apricot", "Orange blossom", "Violet", "Vanilla", "Honey"],
            flavors: ["Peach", "Apricot", "Mango", "Orange blossom", "Vanilla", "Honey"],
            bodyWords: ["Full-bodied", "Oily", "Rich", "Creamy"],
            finishWords: ["Long", "Perfumed", "Spicy", "Warm"],
            abvRange: 13.5...15.0,
            servingTemp: "10-12 C",
            glassware: "White wine glass",
            tips: [
                "Viognier from Condrieu in the Rhone Valley is the benchmark.",
                "The wine can be rich and oily, almost like a light red.",
                "Look for the signature orange blossom and peach aromatics."
            ]
        ),
        WineTypeInfo(
            key: "gewurztraminer",
            name: "Gewurztraminer",
            blurb: "Aromatic, off-dry white with lychee and rose notes.",
            appearance: ["Deep gold", "Oily", "Dense", "Bright"],
            aromas: ["Lychee", "Rose", "Ginger", "Tropical fruit", "Spice", "Perfumed"],
            flavors: ["Lychee", "Rose", "Ginger", "Tropical fruit", "Spice", "Slight sweetness"],
            bodyWords: ["Medium to full", "Oily", "Rich", "Spicy"],
            finishWords: ["Long", "Perfumed", "Slightly sweet", "Exotic"],
            abvRange: 13.0...14.5,
            servingTemp: "10-12 C",
            glassware: "White wine glass",
            tips: [
                "Alsace produces the most renowned Gewurztraminer.",
                "The variety name means 'spiced Traminer' in German.",
                "Look for the intense lychee and rose aromatics - unmistakable."
            ]
        ),
        
        // Rose Wines
        WineTypeInfo(
            key: "rose",
            name: "Rosé",
            blurb: "Crisp, dry pink wine with red fruit and herbal notes.",
            appearance: ["Pink", "Salmon", "Onion skin", "Bright"],
            aromas: ["Strawberry", "Raspberry", "Watermelon", "Rose", "Herbal", "Citrus"],
            flavors: ["Strawberry", "Raspberry", "Watermelon", "Citrus", "Herbal", "Mineral"],
            bodyWords: ["Light", "Crisp", "High acidity", "Dry"],
            finishWords: ["Clean", "Fresh", "Bright", "Refreshing"],
            abvRange: 12.0...13.5,
            servingTemp: "8-10 C",
            glassware: "White wine glass",
            tips: [
                "Provençal rosé is typically pale, dry and crisp.",
                "Dark colored rosé often indicates more skin contact or sweeter style.",
                "Serve well-chilled for maximum refreshment."
            ]
        ),
        
        // Sparkling Wines
        WineTypeInfo(
            key: "champagne",
            name: "Champagne",
            blurb: "Elegant sparkling wine from Champagne with fine bubbles and complexity.",
            appearance: ["Pale gold", "Fine persistent bubbles", "Bright", "Clear"],
            aromas: ["Green apple", "Citrus", "Brioche", "Almond", "Toast", "Yeast"],
            flavors: ["Green apple", "Citrus", "Brioche", "Almond", "Mineral", "Yeast"],
            bodyWords: ["Light to medium", "Crisp", "High acidity", "Effervescent"],
            finishWords: ["Long", "Clean", "Fresh", "Complex"],
            abvRange: 12.0...12.5,
            servingTemp: "6-8 C",
            glassware: "Flute or tulip",
            tips: [
                "Champagne is only from the Champagne region of France.",
                "Brut is dry, Extra Brut is very dry, Brut Nature is bone dry.",
                "Look for fine, persistent bubbles and complexity from autolysis."
            ]
        ),
        WineTypeInfo(
            key: "sparkling",
            name: "Sparkling Wine",
            blurb: "Bubbly wine made in various styles and methods.",
            appearance: ["Pale straw to gold", "Bubbles of varying size", "Bright"],
            aromas: ["Apple", "Pear", "Citrus", "Yeast", "Bread"],
            flavors: ["Apple", "Pear", "Citrus", "Bread", "Yeast"],
            bodyWords: ["Light", "Crisp", "High acidity", "Bubbly"],
            finishWords: ["Clean", "Fresh", "Refreshing"],
            abvRange: 11.0...12.5,
            servingTemp: "6-8 C",
            glassware: "Flute",
            tips: [
                "Methods: Traditional (bottle fermented), Charmat (tank), Carbonation.",
                "Prosecco from Italy uses the Charmat method - fruity and approachable.",
                "Cava from Spain is traditional method, often great value."
            ]
        ),
        
        // Dessert & Fortified Wines
        WineTypeInfo(
            key: "port",
            name: "Port",
            blurb: "Sweet, fortified wine from Portugal with rich dark fruit.",
            appearance: ["Deep ruby", "Tawny with age", "Opaque", "Legs on glass"],
            aromas: ["Blackberry", "Plum", "Raisin", "Chocolate", "Caramel", "Spice"],
            flavors: ["Blackberry", "Plum", "Raisin", "Chocolate", "Caramel", "Nutty", "Spice"],
            bodyWords: ["Full-bodied", "Rich", "Sweet", "Viscous"],
            finishWords: ["Long", "Sweet", "Warming", "Complex"],
            abvRange: 19.0...20.0,
            servingTemp: "14-16 C",
            glassware: "Port glass",
            tips: [
                "Ruby Port is fruity and young; Tawny Port is aged in barrel, showing nutty notes.",
                "Vintage Port is from a single year, meant for long aging.",
                "Serve with chocolate or blue cheese."
            ]
        ),
        WineTypeInfo(
            key: "sherry",
            name: "Sherry",
            blurb: "Fortified wine from Jerez with a range of dry to sweet styles.",
            appearance: ["Pale straw to deep amber", "Clear", "Bright"],
            aromas: ["Almond", "Hazelnut", "Caramel", "Raisin", "Bread", "Yeast", "Salt"],
            flavors: ["Almond", "Hazelnut", "Caramel", "Raisin", "Salt", "Yeast"],
            bodyWords: ["Medium to full", "Dry to sweet", "Complex", "Nutty"],
            finishWords: ["Long", "Nutty", "Dry or sweet", "Complex"],
            abvRange: 15.0...22.0,
            servingTemp: "12-14 C",
            glassware: "Sherry glass",
            tips: [
                "Fino and Manzanilla are dry, pale sherries with a saline character.",
                "Amontillado and Oloroso are darker, richer, often slightly sweet.",
                "Pedro Ximenez (PX) is very sweet, almost syrupy."
            ]
        ),
        WineTypeInfo(
            key: "sauternes",
            name: "Sauternes",
            blurb: "Sweet dessert wine from Bordeaux with honey and apricot notes.",
            appearance: ["Deep gold", "Golden amber", "Viscous", "Legs on glass"],
            aromas: ["Apricot", "Peach", "Honey", "Vanilla", "Saffron", "Botrytis (noble rot)"],
            flavors: ["Apricot", "Peach", "Honey", "Vanilla", "Caramel", "Spice"],
            bodyWords: ["Full-bodied", "Sweet", "Rich", "Viscous", "Oily"],
            finishWords: ["Very long", "Sweet", "Complex", "Honeyed"],
            abvRange: 13.5...15.0,
            servingTemp: "10-12 C",
            glassware: "Dessert wine glass",
            tips: [
                "Made from botrytized (noble rot) Semillon, Sauvignon Blanc and Muscadelle.",
                "The botrytis adds complexity and concentration.",
                "Pairs perfectly with foie gras or blue cheese."
            ]
        ),
        WineTypeInfo(
            key: "ice-wine",
            name: "Ice Wine",
            blurb: "Very sweet dessert wine made from grapes frozen on the vine.",
            appearance: ["Golden to amber", "Syrupy", "Legs on glass", "Bright"],
            aromas: ["Honey", "Peach", "Apricot", "Tropical fruit", "Caramel", "Citrus"],
            flavors: ["Honey", "Peach", "Apricot", "Mango", "Caramel", "Balanced acidity"],
            bodyWords: ["Very sweet", "Rich", "Syrupy", "Concentrated"],
            finishWords: ["Very long", "Sweet", "Balanced", "Honeyed"],
            abvRange: 8.0...12.0,
            servingTemp: "8-10 C",
            glassware: "Small dessert wine glass",
            tips: [
                "Grapes must freeze to at least -8°C before picking.",
                "Canada and Germany are leading producers.",
                "The high acidity balances the extreme sweetness."
            ]
        )
    ]

    // MARK: - Grape Varieties

    struct GrapeVarietyInfo {
        let key: String
        let name: String
        let blurb: String
        let color: String  // "red", "white", or "both"
        let descriptors: [String]
    }

    static let grapeVarieties: [GrapeVarietyInfo] = [
        // Red Grapes
        GrapeVarietyInfo(
            key: "cabernet-sauvignon",
            name: "Cabernet Sauvignon",
            blurb: "King of red grapes, bold and structured.",
            color: "red",
            descriptors: ["Blackcurrant", "Cassis", "Cedar", "Tobacco", "Bell pepper", "Dark fruit"]
        ),
        GrapeVarietyInfo(
            key: "merlot",
            name: "Merlot",
            blurb: "Plush, fruity red grape with soft tannins.",
            color: "red",
            descriptors: ["Plum", "Cherry", "Chocolate", "Cocoa", "Soft", "Velvety"]
        ),
        GrapeVarietyInfo(
            key: "pinot-noir",
            name: "Pinot Noir",
            blurb: "Elegant, delicate red grape with red fruit and earth.",
            color: "red",
            descriptors: ["Red cherry", "Strawberry", "Earth", "Mushroom", "Silky", "Complex"]
        ),
        GrapeVarietyInfo(
            key: "syrah",
            name: "Syrah",
            blurb: "Spicy, full-bodied red grape with dark fruit.",
            color: "red",
            descriptors: ["Blackberry", "Blueberry", "Pepper", "Smoke", "Meat", "Spice"]
        ),
        GrapeVarietyInfo(
            key: "malbec",
            name: "Malbec",
            blurb: "Deep colored red with violet florals and dark fruit.",
            color: "red",
            descriptors: ["Blackberry", "Plum", "Violet", "Cocoa", "Inky", "Deep"]
        ),
        GrapeVarietyInfo(
            key: "sangiovese",
            name: "Sangiovese",
            blurb: "High acid, medium-bodied red with cherry and earth.",
            color: "red",
            descriptors: ["Sour cherry", "Tomato leaf", "Earth", "Herbal", "Savory", "Tannic"]
        ),
        GrapeVarietyInfo(
            key: "tempranillo",
            name: "Tempranillo",
            blurb: "Spanish red with leather, tobacco and red fruit.",
            color: "red",
            descriptors: ["Red cherry", "Leather", "Tobacco", "Vanilla", "Cedar", "Dill"]
        ),
        GrapeVarietyInfo(
            key: "barbera",
            name: "Barbera",
            blurb: "High acid Italian red with bright fruit.",
            color: "red",
            descriptors: ["Black cherry", "Red cherry", "High acidity", "Juicy", "Zesty"]
        ),
        GrapeVarietyInfo(
            key: "nebbiolo",
            name: "Nebbiolo",
            blurb: "Aromatic Italian red with rose, tar and cherry.",
            color: "red",
            descriptors: ["Rose", "Tar", "Cherry", "Truffle", "Leather", "High tannin"]
        ),
        GrapeVarietyInfo(
            key: "grenache",
            name: "Grenache",
            blurb: "Fruity, spicy red grape, often used in blends.",
            color: "red",
            descriptors: ["Red berries", "Spice", "White pepper", "Herbal", "Medium tannins"]
        ),
        GrapeVarietyInfo(
            key: "mourvedre",
            name: "Mourvèdre",
            blurb: "Dark, tannic red grape with meaty character.",
            color: "red",
            descriptors: ["Black fruit", "Meat", "Game", "Earth", "Spice", "Tannic"]
        ),
        GrapeVarietyInfo(
            key: "carignan",
            name: "Carignan",
            blurb: "Rustic, high-acid red grape from Southern France and Spain.",
            color: "red",
            descriptors: ["Dark berries", "Earth", "Spice", "High acidity", "Tannic", "Rustic"]
        ),
        GrapeVarietyInfo(
            key: "zinfandel",
            name: "Zinfandel",
            blurb: "Fruity, jammy red grape, often spicy.",
            color: "red",
            descriptors: ["Blackberry", "Raspberry", "Jam", "Pepper", "Spice", "Briary"]
        ),
        GrapeVarietyInfo(
            key: "petit-verdot",
            name: "Petit Verdot",
            blurb: "Deep colored blending grape with violet and dark fruit.",
            color: "red",
            descriptors: ["Violet", "Black fruit", "Inky", "Tannic", "Spice", "Structure"]
        ),
        GrapeVarietyInfo(
            key: "carmenerem",
            name: "Carmenère",
            blurb: "Chilean red with green pepper and dark fruit.",
            color: "red",
            descriptors: ["Black fruit", "Green pepper", "Spice", "Earth", "Medium tannins"]
        ),
        
        // White Grapes
        GrapeVarietyInfo(
            key: "chardonnay",
            name: "Chardonnay",
            blurb: "Versatile white grape, from crisp to rich buttery.",
            color: "white",
            descriptors: ["Apple", "Pear", "Citrus", "Butter", "Vanilla", "Toast", "Oak"]
        ),
        GrapeVarietyInfo(
            key: "sauvignon-blanc",
            name: "Sauvignon Blanc",
            blurb: "Crisp, aromatic white with herbal and citrus notes.",
            color: "white",
            descriptors: ["Grapefruit", "Lime", "Grass", "Bell pepper", "Herbal", "Fresh"]
        ),
        GrapeVarietyInfo(
            key: "riesling",
            name: "Riesling",
            blurb: "Aromatic white ranging from bone-dry to lusciously sweet.",
            color: "white",
            descriptors: ["Lime", "Apple", "Peach", "Petrol", "Honey", "Mineral", "Floral"]
        ),
        GrapeVarietyInfo(
            key: "pinot-gris",
            name: "Pinot Gris",
            blurb: "Medium to full-bodied white with stone fruit and spice.",
            color: "white",
            descriptors: ["Pear", "Apple", "Stone fruit", "Honey", "Spice", "Rich"]
        ),
        GrapeVarietyInfo(
            key: "viognier",
            name: "Viognier",
            blurb: "Full-bodied aromatic white with peach and floral notes.",
            color: "white",
            descriptors: ["Peach", "Apricot", "Orange blossom", "Vanilla", "Oily", "Rich"]
        ),
        GrapeVarietyInfo(
            key: "gewurztraminer",
            name: "Gewurztraminer",
            blurb: "Aromatic white with lychee and rose notes.",
            color: "white",
            descriptors: ["Lychee", "Rose", "Ginger", "Tropical", "Spice", "Perfumed"]
        ),
        GrapeVarietyInfo(
            key: "chenin-blanc",
            name: "Chenin Blanc",
            blurb: "Versatile white from dry to sweet, with high acidity.",
            color: "white",
            descriptors: ["Apple", "Pear", "Quince", "Honey", "Mineral", "High acidity"]
        ),
        GrapeVarietyInfo(
            key: "semillon",
            name: "Semillon",
            blurb: "Full-bodied white often used in blends, can develop honeyed notes.",
            color: "white",
            descriptors: ["Lemon", "Apple", "Honey", "Wax", "Oily", "Age-worthy"]
        ),
        GrapeVarietyInfo(
            key: "muscat",
            name: "Muscat",
            blurb: "Very aromatic white with floral and grapey notes.",
            color: "white",
            descriptors: ["Orange blossom", "Grape", "Floral", "Sweet", "Aromatic", "Fresh"]
        ),
        GrapeVarietyInfo(
            key: "marsanne",
            name: "Marsanne",
            blurb: "Rich, full-bodied white from the Rhone Valley.",
            color: "white",
            descriptors: ["Peach", "Pear", "Almond", "Honey", "Rich", "Oily"]
        ),
        GrapeVarietyInfo(
            key: "rousanne",
            name: "Roussanne",
            blurb: "Aromatic white grape often blended with Marsanne.",
            color: "white",
            descriptors: ["Pear", "Apple", "Herbal", "Honey", "Spice", "Floral"]
        ),
        GrapeVarietyInfo(
            key: "albarino",
            name: "Albariño",
            blurb: "Crisp, aromatic white from Spain with peach and citrus.",
            color: "white",
            descriptors: ["Peach", "Citrus", "Apricot", "Floral", "Mineral", "Fresh"]
        ),
        GrapeVarietyInfo(
            key: "gruner-veltliner",
            name: "Grüner Veltliner",
            blurb: "Austrian white with white pepper and stone fruit.",
            color: "white",
            descriptors: ["White pepper", "Stone fruit", "Apple", "Mineral", "Fresh", "Spice"]
        )
    ]

    // MARK: - Wine Regions

    struct RegionInfo {
        let key: String
        let name: String
        let country: String
        let blurb: String
    }

    static let regions: [RegionInfo] = [
        RegionInfo(
            key: "bordeaux",
            name: "Bordeaux",
            country: "France",
            blurb: "Classic red blends (Cabernet Sauvignon, Merlot) and sweet whites (Sauternes)."
        ),
        RegionInfo(
            key: "burgundy",
            name: "Burgundy",
            country: "France",
            blurb: "Pinot Noir reds and Chardonnay whites, terroir-driven."
        ),
        RegionInfo(
            key: "rhone",
            name: "Rhône",
            country: "France",
            blurb: "Syrah-based reds (Hermitage, Côte-Rôtie) and Viognier whites (Condrieu)."
        ),
        RegionInfo(
            key: "loire",
            name: "Loire",
            country: "France",
            blurb: "Sauvignon Blanc (Sancerre, Pouilly-Fumé) and Chenin Blanc (Vouvray)."
        ),
        RegionInfo(
            key: "alsace",
            name: "Alsace",
            country: "France",
            blurb: "Aromatic whites: Riesling, Gewurztraminer, Pinot Gris."
        ),
        RegionInfo(
            key: "champagne",
            name: "Champagne",
            country: "France",
            blurb: "Sparkling wines from Chardonnay, Pinot Noir, Pinot Meunier."
        ),
        RegionInfo(
            key: "tuscany",
            name: "Tuscany",
            country: "Italy",
            blurb: "Sangiovese-based reds (Chianti, Brunello) and Super Tuscans."
        ),
        RegionInfo(
            key: "piedmont",
            name: "Piedmont",
            country: "Italy",
            blurb: "Nebbiolo (Barolo, Barbaresco) and Barbera."
        ),
        RegionInfo(
            key: "veneto",
            name: "Veneto",
            country: "Italy",
            blurb: "Valpolicella, Amarone, Soave, Prosecco."
        ),
        RegionInfo(
            key: "rioja",
            name: "Rioja",
            country: "Spain",
            blurb: "Tempranillo-based reds with oak aging."
        ),
        RegionInfo(
            key: "rioriba",
            name: "Priorat",
            country: "Spain",
            blurb: "Powerful red blends (Garnacha, Cariñena)."
        ),
        RegionInfo(
            key: "porto",
            name: "Porto",
            country: "Portugal",
            blurb: "Fortified sweet red wines from Touriga Nacional and other varieties."
        ),
        RegionInfo(
            key: "douro",
            name: "Douro",
            country: "Portugal",
            blurb: "Full-bodied reds and Port wines."
        ),
        RegionInfo(
            key: "napa-valley",
            name: "Napa Valley",
            country: "USA",
            blurb: "Cabernet Sauvignon, Merlot, Chardonnay - bold and fruit-forward."
        ),
        RegionInfo(
            key: "sonoma",
            name: "Sonoma",
            country: "USA",
            blurb: "Diverse region with Pinot Noir, Chardonnay, Zinfandel."
        ),
        RegionInfo(
            key: "oregon",
            name: "Oregon",
            country: "USA",
            blurb: "Pinot Noir and Pinot Gris, elegant and balanced."
        ),
        RegionInfo(
            key: "washington",
            name: "Washington",
            country: "USA",
            blurb: "Syrah, Cabernet Sauvignon, Merlot - structured and fruity."
        ),
        RegionInfo(
            key: "coonawarra",
            name: "Coonawarra",
            country: "Australia",
            blurb: "Cabernet Sauvignon with unique 'terra rossa' soil character."
        ),
        RegionInfo(
            key: "barossa-valley",
            name: "Barossa Valley",
            country: "Australia",
            blurb: "Shiraz-based reds, bold and fruit-forward."
        ),
        RegionInfo(
            key: "marlborough",
            name: "Marlborough",
            country: "New Zealand",
            blurb: "Sauvignon Blanc - intensely aromatic with passion fruit."
        ),
        RegionInfo(
            key: "central-otago",
            name: "Central Otago",
            country: "New Zealand",
            blurb: "Pinot Noir - elegant and fruit-forward."
        ),
        RegionInfo(
            key: "mendoza",
            name: "Mendoza",
            country: "Argentina",
            blurb: "Malbec - deep colored, fruity and plush."
        ),
        RegionInfo(
            key: "colchagua",
            name: "Colchagua",
            country: "Chile",
            blurb: "Carmenère and Cabernet Sauvignon."
        ),
        RegionInfo(
            key: "casablanca",
            name: "Casablanca",
            country: "Chile",
            blurb: "Sauvignon Blanc and Pinot Noir."
        ),
        RegionInfo(
            key: "swartland",
            name: "Swartland",
            country: "South Africa",
            blurb: "Chenin Blanc and Syrah, old vine complexity."
        ),
        RegionInfo(
            key: "stellenbosch",
            name: "Stellenbosch",
            country: "South Africa",
            blurb: "Cabernet Sauvignon and red blends."
        )
    ]

    // MARK: - Stage Expectations

    struct WineStageExpectations {
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

    static let expectations: [String: WineStageExpectations] = [
        "cabernet-sauvignon": WineStageExpectations(
            appearance: "Deep ruby to opaque purple-black; legs should coat the glass. Haze would be a fault.",
            aroma: "Classic cassis and blackcurrant over cedar and tobacco; green bell pepper notes are typical but should not dominate.",
            taste: "Blackcurrant and black cherry fruit with cedar and tobacco; firm tannins and good acidity for structure.",
            mouthfeel: "Full-bodied with firm, drying tannins; should coat the palate without being harsh or astringent.",
            finish: "Long, with lingering tannins and dark fruit; should invite another sip rather than taste bitter or hot from alcohol."
        ),
        "pinot-noir": WineStageExpectations(
            appearance: "Pale to medium ruby with garnet edges; translucent, not opaque. Deep color suggests over-extraction.",
            aroma: "Delicate red cherry, strawberry and floral notes (violet, rose) with earthy undertones.",
            taste: "Red cherry and strawberry fruit with earth and mushroom; high acidity with silky, soft tannins.",
            mouthfeel: "Light to medium body with high acidity and silky texture; should feel elegant and graceful.",
            finish: "Long, complex, with red fruit and earth lingering; should never be heavy or tannic."
        ),
        "chardonnay": WineStageExpectations(
            appearance: "Pale straw to golden;unoaked versions are lighter, oaked versions show deeper gold. Cloudiness is a fault unless unfiltered.",
            aroma: "Apple, pear and citrus with buttery, vanilla and toast notes from oak; tropical fruit in warmer climates.",
            taste: "Apple and pear fruit with citrus; buttery and vanilla from oak; good acidity to balance richness.",
            mouthfeel: "Medium to full body with creamy or oily texture; unoaked should be crisp, oaked should be rich but not flabby.",
            finish: "Long with balanced acidity and fruit; oak should add complexity, not dominate."
        ),
        "sauvignon-blanc": WineStageExpectations(
            appearance: "Pale straw to green-tinted; water-white edge; bright and clear.",
            aroma: "Intense grapefruit, lime and passion fruit with herbal grass and bell pepper notes.",
            taste: "Grapefruit, lime and passion fruit with grassy herbal notes; high acidity.",
            mouthfeel: "Light to medium body with zesty, high acidity; should be crisp and refreshing.",
            finish: "Clean, fresh and bright; herbal notes should persist but not be overly vegetal."
        ),
        "riesling": WineStageExpectations(
            appearance: "Pale straw to green-tinted; can develop golden hues with age; bright.",
            aroma: "Lime, green apple and peach with petrol/gasoline notes in aged examples; mineral and floral in great sites.",
            taste: "Lime, green apple and stone fruit; petrol in aged examples; high acidity with varying sweetness depending on style.",
            mouthfeel: "Light to medium with high acidity; sweet styles should have balancing acidity, dry styles should not be flabby.",
            finish: "Long and clean with lime and mineral notes; petrol adds complexity in aged examples."
        ),
        "syrah": WineStageExpectations(
            appearance: "Deep purple-ruby, nearly opaque; inky appearance.",
            aroma: "Blackberry, blueberry and plum with black pepper, clove and smoky, meaty notes.",
            taste: "Blackberry, blueberry and plum with spice; smoky, meaty character in cooler climates; jammy in warmer climates.",
            mouthfeel: "Full-bodied with rich, dense texture; tannins should be ripe and integrated.",
            finish: "Long with spice and dark fruit; smoke and meat notes add complexity in cooler climate examples."
        ),
        "rose": WineStageExpectations(
            appearance: "Pink ranging from pale salmon to deeper onion skin; bright and clear. Deep color may indicate skin contact or sweetness.",
            aroma: "Strawberry, raspberry and watermelon with rose and herbal notes.",
            taste: "Red berries and watermelon with citrus; should be bone-dry unless labeled otherwise; herbal notes add complexity.",
            mouthfeel: "Light body with crisp, high acidity; should be refreshing and clean.",
            finish: "Clean, fresh and short to medium length; should not have lingering sweetness unless intended."
        ),
        "champagne": WineStageExpectations(
            appearance: "Pale gold with fine, persistent bubbles forming a mousse; should be crystal clear.",
            aroma: "Green apple, citrus, brioche and toast from autolysis; mineral and almond notes.",
            taste: "Green apple and citrus with brioche and autolysis notes; should have fine, integrated bubbles.",
            mouthfeel: "Light to medium body with crisp acidity; bubbles should be fine and persistent, not coarse or aggressive.",
            finish: "Long and clean with apple and brioche; should be refreshing and complex."
        ),
        "port": WineStageExpectations(
            appearance: "Deep ruby to tawny (with age); opaque with legs that coat the glass; may have some sediment in aged examples.",
            aroma: "Blackberry, plum, raisin, chocolate, caramel and spice; nutty in aged tawny examples.",
            taste: "Ripe dark fruit with chocolate, caramel and spice; nutty in aged tawny examples; should be sweet but balanced.",
            mouthfeel: "Full-bodied, rich and viscous; should coat the palate without being cloying; alcohol warmth is normal.",
            finish: "Very long with sweet dark fruit and spice; should be complex and satisfying, not hot or harsh."
        )
    ]

    // MARK: - Lookup functions

    static func wineType(forKey key: String) -> WineTypeInfo? {
        wineTypes.first { $0.key == key }
    }

    static func grapeVariety(forKey key: String) -> GrapeVarietyInfo? {
        grapeVarieties.first { $0.key == key || $0.name.lowercased() == key.lowercased() }
    }

    static func region(forKey key: String) -> RegionInfo? {
        regions.first { $0.key == key || $0.name.lowercased() == key.lowercased() }
    }

    static func expectations(forKey key: String) -> WineStageExpectations? {
        expectations[key]
    }
}
