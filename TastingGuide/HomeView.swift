import SwiftUI

struct HomeView: View {
    @ObservedObject private var store = TastingStore.shared
    @State private var sheetBeverage: Beverage?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    header
                    beverageCards
                    if !store.tastings.isEmpty {
                        recentSection
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 28)
            }
            .background(Theme.appBackground.ignoresSafeArea())
            .navigationTitle("Tasting Guide")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(item: $sheetBeverage) { beverage in
            NewTastingFlowView(beverage: beverage)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Guided tasting")
                .font(.largeTitle.bold())
                .foregroundStyle(Theme.toffee)
            Text("Describe what you know - the guide adapts to what you have.")
                .font(.subheadline)
                .foregroundStyle(Theme.creamDim)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 8)
    }

    private var beverageCards: some View {
        VStack(spacing: 16) {
            beverageCard(
                beverage: .beer,
                title: "Beer tasting",
                caption: "28 styles · malts, hops, yeast and stats refine the guidance",
                gradient: Theme.beerGradient
            )
            beverageCard(
                beverage: .coffee,
                title: "Coffee tasting",
                caption: "Variety, roast and method - espresso, ristretto, filter, cupping and more",
                gradient: Theme.coffeeGradient
            )
            beverageCard(
                beverage: .wine,
                title: "Wine tasting",
                caption: "Comprehensive wine guide with types, grapes, regions and vintage info",
                gradient: Theme.wineGradient
            )
        }
    }

    private func beverageCard(beverage: Beverage, title: String, caption: String, gradient: LinearGradient) -> some View {
        Button {
            sheetBeverage = beverage
        } label: {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(Theme.espressoDeep.opacity(0.35))
                        .frame(width: 56, height: 56)
                    Image(systemName: beverage.symbol)
                        .font(.system(size: 26))
                        .foregroundStyle(Theme.espressoDeep)
                }
                .background(Circle().fill(Theme.cream.opacity(0.9)).frame(width: 54, height: 54))
                .frame(width: 54, height: 54)

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.title3.bold())
                        .foregroundStyle(Theme.espressoDeep)
                    Text(caption)
                        .font(.footnote)
                        .foregroundStyle(Theme.espressoDeep.opacity(0.75))
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(Theme.espressoDeep.opacity(0.7))
            }
            .padding(18)
            .background(gradient)
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .shadow(color: .black.opacity(0.35), radius: 10, y: 5)
        }
        .buttonStyle(.plain)
    }

    private var recentSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent tastings")
                .font(.headline)
                .foregroundStyle(Theme.toffee)
                .frame(maxWidth: .infinity, alignment: .leading)

            ForEach(store.tastings.prefix(5)) { record in
                NavigationLink(value: record.id) {
                    TastingRow(record: record)
                }
                .buttonStyle(.plain)
            }
        }
        .navigationDestination(for: UUID.self) { id in
            if let record = store.tastings.first(where: { $0.id == id }) {
                TastingDetailView(record: record)
            }
        }
    }
}

struct TastingRow: View {
    let record: TastingRecord

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: record.beverage.symbol)
                .font(.system(size: 18))
                .foregroundStyle(record.beverage == .beer ? Theme.hopGold : Theme.crema)
                .frame(width: 40, height: 40)
                .background(Theme.caramel.opacity(0.14))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 3) {
                Text(record.defaultDisplayName)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Theme.cream)
                Text(record.subtitle)
                    .font(.caption)
                    .foregroundStyle(Theme.creamDim)
                    .lineLimit(1)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                StaticRating(rating: record.overallRating)
                Text(record.createdAt, format: .dateTime.month(.abbreviated).day())
                    .font(.caption2)
                    .foregroundStyle(Theme.creamDim.opacity(0.7))
            }
        }
        .padding(12)
        .background(Theme.bark.opacity(0.85))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(Theme.caramel.opacity(0.14), lineWidth: 1)
        )
    }
}
