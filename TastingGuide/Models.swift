import Foundation

enum Beverage: String, Codable, CaseIterable, Identifiable {
    case beer
    case coffee
    case wine

    var id: String { rawValue }

    var title: String {
        switch self {
        case .beer: return "Beer"
        case .coffee: return "Coffee"
        case .wine: return "Wine"
        }
    }

    var symbol: String {
        switch self {
        case .beer: return "mug"
        case .coffee: return "cup.and.saucer.fill"
        case .wine: return "wineglass.fill"
        }
    }
}

/// Everything the user can tell us about a beer. Only the style is required;
/// the guidance engine degrades gracefully when optional details are missing.
struct BeerInputs: Codable, Equatable {
    var name: String = ""
    var styleKey: String?
    var malts: [String] = []
    var hops: [String] = []
    var yeastKey: String?
    var abv: Double?
    var ibu: Int?
    var notes: String = ""

    var isEmptyDetails: Bool {
        malts.isEmpty && hops.isEmpty && yeastKey == nil && abv == nil && ibu == nil
    }
}

/// Everything the user can tell us about a coffee. Variety and method drive
/// the tasting flow; process, roast and origin refine the guidance.
struct CoffeeInputs: Codable, Equatable {
    var name: String = ""
    var varietyKey: String?
    var origin: String = ""
    var processKey: String?
    var roastKey: String?
    var methodKey: String?
    var notes: String = ""
}

/// Everything the user can tell us about a wine.
struct WineInputs: Codable, Equatable {
    var name: String = ""
    var typeKey: String?
    var grapeVarieties: [String] = []
    var region: String = ""
    var vintage: Int?
    var alcoholPercentage: Double?
    var notes: String = ""

    var isEmptyDetails: Bool {
        grapeVarieties.isEmpty && region.isEmpty && vintage == nil && alcoholPercentage == nil
    }
}

struct StageAnswer: Codable, Equatable {
    var stageId: String
    var title: String
    var selected: [String] = []
    var notes: String = ""
    var rating: Int?
}

/// One saved tasting session.
extension StageAnswer: Identifiable {
    var id: String { stageId }
}

struct TastingRecord: Identifiable, Equatable {
    let id: UUID
    let beverage: Beverage
    let createdAt: Date
    var displayName: String
    var overallRating: Int?
    var summary: String
    var beerInputs: BeerInputs?
    var coffeeInputs: CoffeeInputs?
    var wineInputs: WineInputs?
    var answers: [StageAnswer]
}

extension TastingRecord {
    var defaultDisplayName: String {
        if !displayName.trimmingCharacters(in: .whitespaces).isEmpty {
            return displayName
        }
        switch beverage {
        case .beer:
            return beerInputs.flatMap { BeerKnowledge.style(forKey: $0.styleKey ?? "")?.name } ?? "Beer"
        case .coffee:
            if let m = coffeeInputs.flatMap({ CoffeeKnowledge.method(forKey: $0.methodKey ?? "")?.name }) {
                let v = coffeeInputs.flatMap { CoffeeKnowledge.variety(forKey: $0.varietyKey ?? "")?.name } ?? "Coffee"
                return "\(v) \(m)"
            }
            return "Coffee"
        case .wine:
            return wineInputs.flatMap { WineKnowledge.wineType(forKey: $0.typeKey ?? "")?.name } ?? "Wine"
        }
    }

    var subtitle: String {
        switch beverage {
        case .beer:
            let style = beerInputs.flatMap { BeerKnowledge.style(forKey: $0.styleKey ?? "")?.name } ?? "Beer"
            return style
        case .coffee:
            guard let inputs = coffeeInputs else { return "Coffee" }
            let parts: [String] = [
                CoffeeKnowledge.variety(forKey: inputs.varietyKey ?? "")?.name,
                CoffeeKnowledge.roast(forKey: inputs.roastKey ?? "")?.name,
                CoffeeKnowledge.method(forKey: inputs.methodKey ?? "")?.name
            ].compactMap { $0 }
            return parts.isEmpty ? "Coffee" : parts.joined(separator: " · ")
        case .wine:
            guard let inputs = wineInputs else { return "Wine" }
            let parts: [String] = [
                WineKnowledge.wineType(forKey: inputs.typeKey ?? "")?.name,
                inputs.region.isEmpty ? nil : inputs.region,
                inputs.vintage.map { "\($0)" }
            ].compactMap { $0 }
            return parts.isEmpty ? "Wine" : parts.joined(separator: " · ")
        }
    }
}
