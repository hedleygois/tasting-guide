# Tasting Guide

A modern iOS app for guiding beer, coffee, and **wine** tasting experiences. Built with SwiftUI, this app helps you document and explore the nuances of your favorite beverages with a comprehensive knowledge base and intuitive interface.

## Features

### Beer Tasting
- **Extensive Style Database**: West Coast IPA, English Bitter (and variants), Cream Ale, English IPA, IPL, Czech Lager, Italian Pilsener, and more
- **Malt Selection**: Caramunich, Carapils, Melanoidin, Munich, Vienna, Pilsner, and many others (alphabetically ordered)
- **Hops Selection**: Complete catalog including Australian and New Zealand varieties (Nectaron, etc.), plus classics like Magnum, Zeus, Cascade, Centennial, and more
- **Style-Specific Guidance**: Know what to expect from each style (e.g., West Coast IPA should be clear, not hazy)
- **Multi-Select Interface**: Dropdown selectors with chip displays for easy selection and deselection

### Coffee Tasting
- **Bean Varieties**: Complete World Coffee Research (WCR) catalog with 1000+ varieties
- **Roast Levels**: Light, Medium, Dark, and everything in between
- **Brew Methods**: Espresso, Ristretto, Filtered, Cupping, and more
- **Tasting Guidance**: Step-by-step guidance based on your selections

### Wine Tasting ⭐ NEW
- **Comprehensive Wine Types**: 20+ wine types including Cabernet Sauvignon, Pinot Noir, Chardonnay, Syrah, Merlot, Sauvignon Blanc, Riesling, and more
- **Grape Variety Database**: 30+ grape varieties with detailed descriptors (Cabernet Sauvignon, Merlot, Pinot Noir, Chardonnay, Sauvignon Blanc, etc.)
- **Global Regions**: 30+ wine regions from Bordeaux to Napa Valley, Tuscany to Barossa Valley
- **Vintage & ABV Support**: Track vintage years and alcohol percentages
- **Type-Specific Guidance**: Know what to expect from each wine type, including appearance, aroma, taste, mouthfeel, and finish
- **Sparkling Wine Support**: Special guidance for Champagne and other sparkling wines

### Core Functionality
- **Save Tasting Results**: Local SQLite database storage for all beverage types
- **Tasting History**: Browse and review past tastings across beer, coffee, and wine
- **Modern UI**: Brown, caramel, and deep purple-wine color themes
- **Info Banners**: Helpful notifications when selecting items without tasting information

## Screenshots

*(Add your screenshots here as you capture them from the simulator or device)*

## Requirements

- iOS 15.0+ (or specify your minimum deployment target)
- Xcode 14.0+
- Swift 5.7+

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/hedleygois/tasting-guide.git
   ```

2. Open the project in Xcode:
   ```bash
   cd tasting-guide
   open TastingGuide.xcodeproj
   ```

3. Build and run on your preferred simulator or device.

## Project Structure

```
TastingGuide/
├── TastingGuideApp.swift          # Main app entry point
├── RootView.swift                 # Root view with navigation
├── HomeView.swift                 # Main home screen
├── NewTastingFlowView.swift      # Tasting creation flow
├── TastingDetailView.swift        # Tasting details display
├── HistoryView.swift              # Tasting history browser
├── Models.swift                   # Data models (beer, coffee, wine)
├── BeerKnowledge.swift            # Beer styles, malts, hops data
├── CoffeeKnowledge.swift          # Coffee varieties and roast data
├── WineKnowledge.swift            # Wine types, grapes, regions, and guidance
├── WCRVarieties.swift             # World Coffee Research variety catalog
├── GuidanceEngine.swift           # Tasting guidance logic (beer, coffee, wine)
├── TastingStore.swift             # SQLite database operations
├── Theme.swift                    # App theming and colors
└── Components.swift               # Reusable UI components

TastingGuide.xcodeproj/
├── project.pbxproj               # Xcode project configuration
└── xcshareddata/
    └── xcschemes/
        └── TastingGuide.xcscheme  # Build scheme
```

## Data Sources

### Beer Data
- **Styles**: Comprehensive list including regional specialties
- **Malts**: 50+ malt varieties with descriptions
- **Hops**: 100+ hop varieties from around the world, including:
  - Australian & New Zealand: Nectaron, Galaxy, Motueka, Nelson Sauvin, etc.
  - European: Hallertau, Tettnang, Saaz, etc.
  - American: Cascade, Centennial, Citra, Simcoe, Magnum, Zeus, etc.

### Coffee Data
- **Varieties**: Extracted from [World Coffee Research](https://varieties.worldcoffeeresearch.org/) - 1000+ coffee bean varieties
- **Roast Levels**: Light, Medium, Dark with sub-categories
- **Brew Methods**: Multiple preparation styles with guidance

### Wine Data
- **Types**: 20+ wine styles with detailed expectations
- **Grapes**: 30+ grape varieties with tasting descriptors
- **Regions**: 30+ wine regions from around the world
- **Vintage Data**: Support for tracking wine years and alcohol percentages

## Usage

### Creating a New Tasting

1. Tap "New Tasting" from the home screen
2. Select whether you're tasting beer, coffee, or wine
3. For beer:
   - Select style (required)
   - Optionally add malts (multi-select with chips)
   - Optionally add hops (multi-select with chips)
   - Get style-specific expectations
4. For coffee:
   - Select bean variety from WCR catalog
   - Select roast level
   - Select brew method
   - Get variety-specific guidance
5. For wine:
   - Select wine type (required)
   - Optionally add grape varieties (multi-select with chips)
   - Optionally add region
   - Optionally add vintage year and ABV
   - Get type-specific expectations
6. Document your tasting notes
7. Save to your local database

### Browsing History

- View all past tastings in chronological order
- Filter by beer or coffee
- Search by style, variety, or date
- Tap any tasting to view full details

## Customization

### Adding New Styles or Varieties

Edit the appropriate knowledge file:
- `BeerKnowledge.swift` - for beer styles, malts, hops
- `CoffeeKnowledge.swift` - for coffee varieties and roasts
- `WineKnowledge.swift` - for wine types, grapes, regions
- `WCRVarieties.swift` - auto-generated from WCR data

All lists are alphabetically ordered for easy navigation.

### Updating WCR Varieties

The coffee varieties are extracted from World Coffee Research's sitemap. To update:

1. Visit https://varieties.worldcoffeeresearch.org/sitemaps-2-sitemap.xml
2. Extract the variety data
3. Update `WCRVarieties.swift`

## Theming

The app uses a custom color scheme for each beverage type:
- **Beer**: Golden to amber gradients (hop gold, caramel, toffee)
- **Coffee**: Coffee to deep brown gradients (crema, espresso, bark)
- **Wine**: Deep purple to burgundy gradients (wine red, garnet, deep purple)

Shared colors:
- Primary: Deep brown (#4A2C2A)
- Secondary: Caramel (#C68642)
- Accent: Light tan (#E8C4A0)
- Background: Cream (#FFF8F0)

Colors are defined in `Theme.swift` and can be customized there.

## Database

The app uses SQLite for local storage via `TastingStore.swift`. The database:
- Stores all tasting sessions
- Persists across app launches
- Is sandboxed to the app's container
- Can be exported for backup

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

This project is proprietary. All rights reserved.

## Acknowledgments

- [World Coffee Research](https://worldcoffeeresearch.org/) for the comprehensive coffee variety catalog
- The craft beer community for style definitions and expectations
- Wine industry resources for wine type and grape variety information
- Mistral Vibe for development assistance

## Contact

For questions or feedback, please open an issue on GitHub.

---

**Tasting Guide** - Your companion for exploring the world of beer, coffee, and wine, one sip at a time.
