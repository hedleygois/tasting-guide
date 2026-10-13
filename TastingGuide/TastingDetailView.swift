import SwiftUI

struct TastingDetailView: View {
    let record: TastingRecord

    @ObservedObject private var store = TastingStore.shared
    @State private var confirmingDelete = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerCard
                inputsCard
                answersCard
                if !record.summary.isEmpty {
                    summaryCard
                }
                SecondaryButton(title: "Delete tasting", systemImage: "trash") {
                    confirmingDelete = true
                }
                .padding(.bottom, 24)
            }
            .padding(16)
        }
        .background(Theme.appBackground.ignoresSafeArea())
        .navigationTitle(record.defaultDisplayName)
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog("Delete this tasting?", isPresented: $confirmingDelete, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                store.delete(record)
                dismiss()
            }
        }
    }

    private var headerCard: some View {
        card {
            HStack(spacing: 14) {
                Image(systemName: record.beverage.symbol)
                    .font(.system(size: 24))
                    .foregroundStyle(Theme.espressoDeep)
                    .frame(width: 48, height: 48)
                    .background(Theme.caramelButton)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text(record.defaultDisplayName)
                        .font(.title3.bold())
                        .foregroundStyle(Theme.toffee)
                    Text(record.subtitle)
                        .font(.caption)
                        .foregroundStyle(Theme.creamDim)
                    Text(record.createdAt, format: .dateTime.year().month(.wide).day().hour().minute())
                        .font(.caption2)
                        .foregroundStyle(Theme.creamDim.opacity(0.7))
                }

                Spacer()
                StaticRating(rating: record.overallRating)
            }
        }
    }

    private var inputFacts: [(String, String)] {
        var facts: [(String, String)] = []
        if let beer = record.beerInputs {
            if let style = BeerKnowledge.style(forKey: beer.styleKey ?? "") {
                facts.append(("Style", style.name))
            }
            if let abv = beer.abv { facts.append(("ABV", String(format: "%.1f%%", abv))) }
            if let ibu = beer.ibu { facts.append(("IBU", "\(ibu)")) }
            if !beer.hops.isEmpty {
                facts.append(("Hops", beer.hops.compactMap { BeerKnowledge.hop(forKey: $0)?.name ?? $0 }.joined(separator: ", ")))
            }
            if !beer.malts.isEmpty {
                facts.append(("Malts", beer.malts.compactMap { BeerKnowledge.malt(forKey: $0)?.name ?? $0 }.joined(separator: ", ")))
            }
            if let yeast = beer.yeastKey, let y = BeerKnowledge.yeast(forKey: yeast) {
                facts.append(("Yeast", y.name))
            }
        }
        if let coffee = record.coffeeInputs {
            if let variety = CoffeeKnowledge.variety(forKey: coffee.varietyKey ?? "") {
                facts.append(("Variety", variety.name))
            }
            if !coffee.origin.isEmpty { facts.append(("Origin", coffee.origin)) }
            if let process = CoffeeKnowledge.process(forKey: coffee.processKey ?? "") {
                facts.append(("Process", process.name))
            }
            if let roast = CoffeeKnowledge.roast(forKey: coffee.roastKey ?? "") {
                facts.append(("Roast", roast.name))
            }
            if let method = CoffeeKnowledge.method(forKey: coffee.methodKey ?? "") {
                facts.append(("Method", method.name))
            }
        }
        if let wine = record.wineInputs {
            if let wineType = WineKnowledge.wineType(forKey: wine.typeKey ?? "") {
                facts.append(("Type", wineType.name))
            }
            if !wine.grapeVarieties.isEmpty {
                facts.append(("Grapes", wine.grapeVarieties.compactMap { WineKnowledge.grapeVariety(forKey: $0)?.name ?? $0 }.joined(separator: ", ")))
            }
            if !wine.region.isEmpty { facts.append(("Region", wine.region)) }
            if let vintage = wine.vintage { facts.append(("Vintage", "\(vintage)")) }
            if let abv = wine.alcoholPercentage { facts.append(("ABV", String(format: "%.1f%%", abv))) }
        }
        return facts
    }

    private var inputsCard: some View {
        card {
            VStack(alignment: .leading, spacing: 12) {
                Text("What you started with")
                    .font(.headline)
                    .foregroundStyle(Theme.toffee)

                ForEach(inputFacts, id: \.0) { fact in
                    HStack(alignment: .top) {
                        Text(fact.0)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(Theme.caramelSoft)
                            .frame(width: 90, alignment: .leading)
                        Text(fact.1)
                            .font(.caption)
                            .foregroundStyle(Theme.cream)
                        Spacer()
                    }
                }

                if let notes = record.beerInputs?.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.caption)
                        .foregroundStyle(Theme.creamDim)
                }
                if let notes = record.coffeeInputs?.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.caption)
                        .foregroundStyle(Theme.creamDim)
                }
                if let notes = record.wineInputs?.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.caption)
                        .foregroundStyle(Theme.creamDim)
                }
            }
        }
    }

    private var answersCard: some View {
        card {
            VStack(alignment: .leading, spacing: 16) {
                Text("Your tasting notes")
                    .font(.headline)
                    .foregroundStyle(Theme.toffee)

                if record.answers.isEmpty {
                    Text("No stage notes recorded.")
                        .font(.caption)
                        .foregroundStyle(Theme.creamDim)
                }

                ForEach(record.answers) { answer in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(answer.title)
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(Theme.cream)
                            Spacer()
                            StaticRating(rating: answer.rating)
                        }
                        if !answer.selected.isEmpty {
                            WrapChips(labels: answer.selected)
                        }
                        if !answer.notes.isEmpty {
                            Text(answer.notes)
                                .font(.caption)
                                .foregroundStyle(Theme.creamDim)
                        }
                    }
                    .padding(.bottom, 6)
                }
            }
        }
    }

    private var summaryCard: some View {
        card {
            VStack(alignment: .leading, spacing: 8) {
                Text("Final thoughts")
                    .font(.headline)
                    .foregroundStyle(Theme.toffee)
                Text(record.summary)
                    .font(.subheadline)
                    .foregroundStyle(Theme.cream)
            }
        }
    }
}

struct WrapChips: View {
    let labels: [String]

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 92), spacing: 6)], alignment: .leading, spacing: 6) {
            ForEach(labels, id: \.self) { label in
                Chip(label: label, isSelected: true, action: nil)
            }
        }
    }
}
