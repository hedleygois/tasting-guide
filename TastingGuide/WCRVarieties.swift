import Foundation

/// Coffee varieties extracted from the World Coffee Research catalog
/// (https://varieties.worldcoffeeresearch.org). The 87 catalog pages cover
/// agronomic data; cup descriptors here are species-level defaults, with the
/// WCR summary, lineage, quality potential, bean size and yield in the blurb.
/// Varieties that already exist in the curated list are omitted.
enum WCRVarieties {
    static let catalog: [CoffeeKnowledge.VarietyInfo] = [

        CoffeeKnowledge.VarietyInfo(
            key: "s795", name: "S795",
            blurb: "High-yielding variety that is widely cultivated in India. Lineage: Selection 3. Quality potential at high altitude: Very Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "sln-6", name: "Sln.6",
            blurb: "Adapted to mid-to-high altitude Indian tropics, with good rust resistance and yields. Lineage: S.2828. Quality potential at high altitude: Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "sln-5b", name: "Sln.5B",
            blurb: "High yield and strong rust tolerance coming from both robusta and liberica parentage. Lineage: S.2931. Quality potential at high altitude: Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "paraiso", name: "Paraiso",
            blurb: "Very high-yielding and rust-resistant compact variety developed in Brazil and recently introduced to Central America. Quality potential at high altitude: Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "ipr-107", name: "IPR 107",
            blurb: "Highly resistant to coffee leaf rust, suitable for high altitude cultivation and mechanical harvesting. Quality potential at high altitude: Very Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "catigua-mg2", name: "Catigua MG2",
            blurb: "Recommended for specialty coffee production in Brazil. Broadly adaptable and drought-tolerant. Quality potential at high altitude: Very Good. Bean size: Below Average.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "ipr-103", name: "IPR 103",
            blurb: "Good tolerance to heat, drought, and low-fertility soil. Adapted to various coffee-growing regions in Brazil, with high productivity especially in the early harvests. Quality potential at high altitude: Very Good. Bean size: Average.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "s4808", name: "S4808",
            blurb: "An Indian breeding line that is not yet commercially released. Quality potential at high altitude: Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "ab3", name: "AB3",
            blurb: "High cup quality, adapted for agroforestry; limited cultivation in Java. Lineage: Java. Quality potential at high altitude: Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "bpl10", name: "BPL10",
            blurb: "Rust-tolerant with high vigor; limited cultivation in Java. Lineage: Java. Quality potential at high altitude: Very Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "kartika-1", name: "Kartika 1",
            blurb: "Adapted for agroforestry, with good yields and high resistance to rust in global trials. Quality potential at high altitude: Good. Bean size: Average.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "ec15", name: "EC15",
            blurb: "High production yield and very good quality potential. Suitable for agroforestry systems. Lineage: MundoMex. Quality potential at high altitude: Very Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "monte-claro", name: "Monte Claro",
            blurb: "Compact variety with very good cup quality and large beans, tolerance to coffee leaf rust and nematodes, and high yield potential. An important regional variety in Venezuela. Lineage: Ombligon, Lechocita. Quality potential at high altitude: Very Good. Bean size: Very Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics", "Large-bean depth"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "esperanza", name: "Esperanza",
            blurb: "Variety with very high productivity, tolerance to rust, and very good quality. Excellent adaptation to humid environments. Lineage: L4 A5. Quality potential at high altitude: Very Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "caripe", name: "Caripe",
            blurb: "Very good cup quality with large beans. An important regional variety in Monagas state in northeastern Venezuela. Lineage: Criollo Cogollo Verde, Buonaffina. Quality potential at high altitude: Very Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "obata-red", name: "Obata (Red)",
            blurb: "A high yielding, rust-resistant Brazilian variety recently introduced to Costa Rica. Lineage: Sarchimor. Quality potential at high altitude: Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "venecia", name: "Venecia",
            blurb: "Very high susceptibility to coffee leaf rust. Well-adapted to rainy zones due to late harvest during dry season. Quality potential at high altitude: Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "tekisic", name: "Tekisic",
            blurb: "A variety selected in El Salvador, and known for very good cup quality in the highest altitudes. Lineage: Improved Bourbon. Quality potential at high altitude: Very Good. Bean size: Average.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "t8667", name: "T8667",
            blurb: "High-yielding variety, resistant to rust, and adapted to warmest zones and acidic soils. Lineage: Catimor. Quality potential at high altitude: Low. Bean size: Average.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics", "Rustic, bold"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "t5296", name: "T5296",
            blurb: "Well-adapted to medium altitudes. Variety not uniform. Lineage: Sarchimor. Quality potential at high altitude: Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "t5175", name: "T5175",
            blurb: "High-yielding plant adapted to lowest altitudes. Requires high fertilization. Variety not uniform. Lineage: Catimor. Quality potential at high altitude: Very Low. Bean size: Average.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics", "Rustic, bold"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "starmaya", name: "Starmaya",
            blurb: "High yielding plant adapted to medium altitudes. Notably high acidity in the cup. Quality potential at high altitude: Very Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics", "High acidity"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "sl14", name: "SL14",
            blurb: "A good-yielding tall variety with drought and cold tolerance. Found mostly in Kenya and Uganda. Quality potential at high altitude: Good. Bean size: Average.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "ruiru-11", name: "Ruiru 11",
            blurb: "High-yielding, compact hybrid tolerant to coffee leaf rust and resistant to coffee berry disease (CBD). Released in Kenya. Quality potential at high altitude: Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "rab-c15", name: "RAB C15",
            blurb: "High yielding tall variety resistant to rust and coffee berry disease recently released in Rwanda. Quality potential at high altitude: Very Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "pop3303", name: "Pop3303/21",
            blurb: "High yielding with tolerance to drought, coffee leaf rust, and coffee berry disease. Adapted to a wide range of ecosystems. Found mostly in Rwanda. Quality potential at high altitude: Good. Bean size: Average.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "parainema", name: "Parainema",
            blurb: "Well-adapted to medium altitudes, resistant to coffee leaf rust and some nematodes. Lineage: Sarchimor. Quality potential at high altitude: Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "pache", name: "Pache",
            blurb: "A compact plant with medium yield and good quality, but highly susceptible to major diseases. Quality potential at high altitude: Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "pacas", name: "Pacas",
            blurb: "Standard quality in Central America. Very high susceptibility to coffee leaf rust. Quality potential at high altitude: Good. Bean size: Average.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "oro-azteca", name: "Oro Azteca",
            blurb: "Adapted to warmest zones and acidic soils. High yielding. Lineage: Catimor. Quality potential at high altitude: Good. Bean size: Average.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "nyasaland", name: "Nyasaland",
            blurb: "Good cup quality, but susceptible to major diseases. Preferred by smallholder farmers in Uganda. Lineage: Bugisu local, Nyasa. Quality potential at high altitude: Good. Bean size: Average.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "nemaya", name: "Nemaya (rootstock)",
            blurb: "A Robusta variety used for rootstock grafting because of its high resistance to nematodes. Arabica plants can be grafted onto Nemaya rootstock to make them resistant to nematodes. Lineage: Rootstock.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "nayarita", name: "Nayarita",
            blurb: "High yielding variety at high altitudes with very good cup quality. Lineage: EC19. Quality potential at high altitude: Very Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "mundo-maya", name: "Mundo Maya",
            blurb: "Very high yielding variety if planted in healthy soil, with very good quality at elevations above 1300 meters. Well-adapted to agroforestry conditions. Lineage: EC16. Quality potential at high altitude: Very Good. Bean size: Large.",
            descriptors: ["Balanced sweetness", "Clean cup", "Origin-driven aromatics"],
            species: "Arabica"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "perdenia", name: "Perdenia",
            blurb: "Vigorous, wide-spreading, grows into moderately large trees. High-yielding, beans relatively small in size. Lineage: Old Robusta. Bean size: Small (screen size 14 or below). Yield: 1500-3000 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "roubi-4", name: "Roubi 5",
            blurb: "High productivity in combination with large bean size. Bean size: Large (screen size >17). Yield: Medium-High kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "roubi-3", name: "Roubi 4",
            blurb: "High productivity in combination with large bean size. Bean size: Large (screen size >17). Yield: Medium-High kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "roubi-2", name: "Roubi 2",
            blurb: "Combines excellent yield and cup quality. Very high acceptance among farmers. Bean size: Large (screen size >17). Yield: Medium-High kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema", "Notable cup quality (for robusta)"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "roubi-1", name: "Roubi 1",
            blurb: "Combines excellent yield and cup quality. Very high acceptance among farmers. Bean size: Medium (screen size 15-16). Yield: Medium-High kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema", "Notable cup quality (for robusta)"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "roubi-10", name: "Roubi 10",
            blurb: "High productivity and high cup quality. Bean size: Medium (screen size 15-16). Yield: Medium-High kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema", "Notable cup quality (for robusta)"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "roubi-9", name: "Roubi 9",
            blurb: "High productivity and high cup quality. Bean size: Small (screen size 14 or below). Yield: Medium-High kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema", "Notable cup quality (for robusta)"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "roubi-8", name: "Roubi 8",
            blurb: "High productivity and high cup quality. Bean size: Medium (screen size 15-16). Yield: Medium-High kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema", "Notable cup quality (for robusta)"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "roubi-7", name: "Roubi 7",
            blurb: "Very good cup quality and high productivity. Bean size: Small (screen size 14 or below). Yield: Medium-High kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema", "Notable cup quality (for robusta)"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "roubi-6", name: "Roubi 6",
            blurb: "High productivity and high cup quality. Bean size: Medium (screen size 15-16). Yield: Medium-High kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema", "Notable cup quality (for robusta)"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "trs1", name: "TRS1",
            blurb: "Wide adaptation to different environments; average input requirements. Bean size: Medium (screen size 15-16). Yield: 4000-5000 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "tr11", name: "TR11",
            blurb: "Very high yield and quality. Strong growth. Bean size: Medium (screen size 15-16). Yield: 5000-6000 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "tr9", name: "TR9",
            blurb: "Very high yield and cup quality, large bean size. Bean size: Large (screen size >17). Yield: 5000-6000 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema", "Notable cup quality (for robusta)"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "tr4", name: "TR4",
            blurb: "High yield and wide adaptation to different environments. Bean size: Medium (screen size 15-16). Yield: 5000-7000 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "xanh-lun", name: "Xanh lun",
            blurb: "Compact, very high yield. High quality, relative drought tolerance, late to ripen. Lineage: TS5. Bean size: Large (screen size >17). Yield: 5000-6000 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "inifap-00-28", name: "INIFAP 00-28",
            blurb: "Tall plants with large and numerous leaves and fruits; highest-yielding clone for the conditions of the coast of Chiapas, Mexico. Lineage: Clon 28. Bean size: Medium (screen size 15-16).",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "inifap-00-24", name: "INIFAP 00-24",
            blurb: "Compact plant grown under the conditions of the Chiapas coast in Mexico. Reduced plant size lends itself to higher yields in dry conditions and differentiates it from any other clone. Lineage: Clon 24. Bean size: Medium (screen size 15-16).",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "inifap-97-15", name: "INIFAP 97-15",
            blurb: "Tall growth, tendency to form plants with more than three productive stems. Good yield potential, wide range of adaptation to the climatic conditions of the coast of Chiapas and Veracruz, Mexico. Lineage: Clon 15. Bean size: Medium (screen size 15-16).",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "inifap-97-14", name: "INIFAP 97-14",
            blurb: "Tall growth, tendency to form plants with more than three productive stems and good yield of cherries. Very susceptible to stem borers and anthracnose. Lineage: Clon 14. Bean size: Medium (screen size 15-16).",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "inifap-95-9", name: "INIFAP 95-9",
            blurb: "Tall plant with very large fruit. Susceptible to shoot hole borer. Lineage: Clon Romex 51. Bean size: Large (screen size >17).",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "kr-10", name: "NARO-Kituza Robusta 10",
            blurb: "Resistant to coffee wilt disease (CWD). Lineage: KR10. Bean size: Medium (screen size 15-16). Yield: 4800 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "kr-9", name: "NARO-Kituza Robusta 9",
            blurb: "Resistant to coffee wilt disease (CWD). Lineage: KR9. Bean size: Medium (screen size 15-16). Yield: 3900 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "kr-8", name: "NARO-Kituza Robusta 8",
            blurb: "Resistant to coffee wilt disease (CWD). Lineage: KR8. Bean size: Medium (screen size 15-16). Yield: 3100 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "kr-7", name: "NARO-Kituza Robusta 7",
            blurb: "Resistant to coffee wilt disease (CWD). Lineage: KR7. Bean size: Medium (screen size 15-16). Yield: 3000 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "kr-6", name: "NARO-Kituza Robusta 6",
            blurb: "Resistant to coffee wilt disease (CWD). Lineage: KR6. Bean size: Medium (screen size 15-16). Yield: 2650 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "kr-5", name: "NARO-Kituza Robusta 5",
            blurb: "Resistant to coffee wilt disease (CWD). Lineage: KR5. Bean size: Medium (screen size 15-16). Yield: 2860 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "kr-4", name: "NARO-Kituza Robusta 4",
            blurb: "Resistant to coffee wilt disease (CWD). Lineage: KR4. Bean size: Medium (screen size 15-16). Yield: 2300 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "kr-3", name: "NARO-Kituza Robusta 3",
            blurb: "Resistant to coffee wilt disease (CWD). Lineage: KR3. Bean size: Medium (screen size 15-16). Yield: 4900 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "kr-2", name: "NARO-Kituza Robusta 2",
            blurb: "Resistant to coffee wilt disease (CWD). Lineage: KR2. Bean size: Medium (screen size 15-16). Yield: 2600 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "kr-1", name: "NARO-Kituza Robusta 1",
            blurb: "Resistant to coffee wilt disease (CWD). Lineage: KR1. Bean size: Medium (screen size 15-16). Yield: 2800 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "brs-3220", name: "BRS 3220",
            blurb: "Adaptable to the environments of the Western Amazon, recognized for good productivity and bean size. Bean size: Medium (screen size 15-16). Yield: 6600 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "brs-3213", name: "BRS 3213",
            blurb: "Adaptable to the environments of the Western Amazon, recognized for good productivity and bean size. Bean size: Medium (screen size 15-16). Yield: 7200 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "brs-3210", name: "BRS 3210",
            blurb: "Good adaptability and stability in the environments of the Western Amazon. Good productivity and bean size. Bean size: Medium (screen size 15-16). Yield: 7200 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "brs-3193", name: "BRS 3193",
            blurb: "Long primary branches. Production peak in the second or third commercial harvest, which reduces the biannual production of the crop by compensating for lower yields of other clones. Bean size: Small (screen size 14 or below). Yield: 6000 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "brs-3137", name: "BRS 3137",
            blurb: "Recognized for its rusticity, presenting good vegetative and productive characteristics in dry conditions and low-fertility soils. Bean size: Small (screen size 14 or below). Yield: 6600 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "brs-2357", name: "BRS 2357",
            blurb: "Compact canopy, which allows for densification. Short stems allow one additional harvest before renewal. Bean size: Medium (screen size 15-16). Yield: 6000 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "brs-2336", name: "BRS 2336",
            blurb: "Adaptable to the environments of the Western Amazon, with high productivity and bean size. Bean size: Medium (screen size 15-16). Yield: 7200 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "brs-2314", name: "BRS 2314",
            blurb: "High cupping scores; has been classified as a 'fine robusta'. Bean size: Small (screen size 14 or below). Yield: 6600 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema", "Fine robusta - smooth"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "brs-2299", name: "BRS 2299",
            blurb: "Plant structure suitable for mechanized harvesting. Stands out for its tolerance to the root-knot nematode. Bean size: Medium (screen size 15-16). Yield: 6600 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "brs-1216", name: "BRS 1216",
            blurb: "Adaptable to the environments of the Western Amazon with high productivity. Plant structure suitable for mechanized harvesting. Resistant to nematodes and coffee rust. Bean size: Medium (screen size 15-16). Yield: 7200 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "sa-237", name: "SA 237",
            blurb: "Suitable for cultivation under agroforestry systems in areas with dry climates. Bean size: Large (screen size >17). Yield: 800-2100 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "bp-939", name: "BP 939",
            blurb: "Wide adaptability to different environments that produces best in areas with dry climates; suitable for cultivation under agroforestry systems. Bean size: Large (screen size >17). Yield: 1400-1900 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "bp-936", name: "BP 936",
            blurb: "Wide adaptability to different environments, with optimal productivity in areas with wet climates; suitable for cultivation under agroforestry systems. Bean size: Large (screen size >17). Yield: 1600-2200 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "bp-534", name: "BP 534",
            blurb: "Most commonly grown clone by farmers in Indonesia; suitable for cultivation under agroforestry systems. Bean size: Large (screen size >17). Yield: 1700-2200 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "sln-2-r", name: "Sln.2R",
            blurb: "Plants that are very vigorous and grow into moderately large trees and produce large beans. Lineage: Balehonnur Robustas, CxR (Congensis x Robusta). Bean size: Large (screen size >17). Yield: 1500-3000 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "sln-1-r", name: "Sln.1R",
            blurb: "Plants that are very vigorous and grow into moderately large trees. Lineage: S.274, CxR (Congensis x Robusta). Bean size: Medium (screen size 15-16). Yield: 1500-3000 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
        CoffeeKnowledge.VarietyInfo(
            key: "sln-3-r", name: "Sln.3R",
            blurb: "Compact plant stature with good yielding potential, suitable for high-density planting. Lineage: CxR (Congensis x Robusta). Bean size: Large (screen size >17). Yield: 1500-2500 kg/ha.",
            descriptors: ["Heavy body", "Low acidity", "Earthy", "Woody", "Strong crema"],
            species: "Robusta"
        ),
    ]
}
