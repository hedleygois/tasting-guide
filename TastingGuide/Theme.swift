import SwiftUI

/// Brown and caramel palette that ties together the coffee and beer themes.
enum Theme {
    static let espressoDeep = Color(hex: 0x140C07)   // near-black espresso
    static let espresso = Color(hex: 0x231610)        // rich coffee background
    static let bark = Color(hex: 0x2E1D14)           // dark card surface
    static let walnut = Color(hex: 0x3A261A)         // lighter card surface
    static let caramel = Color(hex: 0xC8924A)        // primary accent
    static let caramelSoft = Color(hex: 0xD9AB6B)    // softer accent
    static let toffee = Color(hex: 0xE9CC9A)         // highlights / headings
    static let cream = Color(hex: 0xF5EBDD)          // primary text
    static let creamDim = Color(hex: 0xCDBCA8)      // secondary text
    static let hopGold = Color(hex: 0xD8A94E)       // beer accent
    static let crema = Color(hex: 0xE3B87C)         // coffee accent

    static let appBackground = LinearGradient(
        colors: [Color(hex: 0x1A110A), Color(hex: 0x241610), Color(hex: 0x160E08)],
        startPoint: .top, endPoint: .bottom
    )

    static let beerGradient = LinearGradient(
        colors: [Color(hex: 0xD8A94E), Color(hex: 0xA86A2D), Color(hex: 0x5C3418)],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )

    static let coffeeGradient = LinearGradient(
        colors: [Color(hex: 0xE3B87C), Color(hex: 0x8A5426), Color(hex: 0x402310)],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )

    static let caramelButton = LinearGradient(
        colors: [Color(hex: 0xD9AB6B), Color(hex: 0xB67C36)],
        startPoint: .top, endPoint: .bottom
    )

    static func gradient(for beverage: Beverage) -> LinearGradient {
        beverage == .beer ? beerGradient : coffeeGradient
    }
}

extension Color {
    init(hex: UInt32) {
        let r = Double((hex >> 16) & 0xFF) / 255.0
        let g = Double((hex >> 8) & 0xFF) / 255.0
        let b = Double(hex & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
