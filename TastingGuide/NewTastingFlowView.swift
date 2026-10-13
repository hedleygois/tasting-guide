import SwiftUI

// MARK: - Flow container

struct NewTastingFlowView: View {
    enum Phase { case input, guided, summary, saved }

    private let initialBeverage: Beverage
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var store = TastingStore.shared

    @State private var beverage: Beverage
    @State private var phase: Phase = .input
    @State private var beerInputs = BeerInputs()
    @State private var coffeeInputs = CoffeeInputs()
    @State private var answers: [StageAnswer] = []
    @State private var overallRating: Int?
    @State private var summaryText = ""

    init(beverage: Beverage) {
        initialBeverage = beverage
        _beverage = State(initialValue: beverage)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                switch phase {
                case .input:
                    InputStepView(
                        beverage: $beverage,
                        beerInputs: $beerInputs,
                        coffeeInputs: $coffeeInputs
                    ) {
                        beginGuidedFlow()
                    }
                case .guided:
                    GuidedFlowView(
                        beverage: beverage,
                        intro: currentIntro,
                        stages: currentStages,
                        answers: $answers,
                        onFinish: { phase = .summary }
                    )
                case .summary:
                    SummaryStepView(
                        beverage: beverage,
                        intro: currentIntro,
                        answers: answers,
                        overallRating: $overallRating,
                        summaryText: $summaryText,
                        onSave: { save() }
                    )
                case .saved:
                    SavedStepView(
                        beverage: beverage,
                        onDone: { dismiss() },
                        onAnother: { reset() }
                    )
                }
            }
            .background(Theme.appBackground.ignoresSafeArea())
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(Theme.caramelSoft)
                }
            }
        }
        .preferredColorScheme(.dark)
    }

    private var navigationTitle: String {
        switch phase {
        case .input: "New \(beverage.title) Tasting"
        case .guided: "Guided Tasting"
        case .summary: "Summary"
        case .saved: "Saved"
        }
    }

    private var currentIntro: GuidanceIntro {
        beverage == .beer
            ? GuidanceEngine.beerIntro(for: beerInputs)
            : GuidanceEngine.coffeeIntro(for: coffeeInputs)
    }

    private var currentStages: [TastingStage] {
        beverage == .beer
            ? GuidanceEngine.beerStages(for: beerInputs)
            : GuidanceEngine.coffeeStages(for: coffeeInputs)
    }

    private func beginGuidedFlow() {
        answers = currentStages.map {
            StageAnswer(stageId: $0.id, title: $0.title)
        }
        phase = .guided
    }

    private func save() {
        let record = TastingRecord(
            id: UUID(),
            beverage: beverage,
            createdAt: Date(),
            displayName: beverage == .beer ? beerInputs.name : coffeeInputs.name,
            overallRating: overallRating,
            summary: summaryText,
            beerInputs: beverage == .beer ? beerInputs : nil,
            coffeeInputs: beverage == .coffee ? coffeeInputs : nil,
            answers: answers
        )
        store.insert(record)
        phase = .saved
    }

    private func reset() {
        beerInputs = BeerInputs()
        coffeeInputs = CoffeeInputs()
        answers = []
        overallRating = nil
        summaryText = ""
        beverage = initialBeverage
        phase = .input
    }
}

// MARK: - Step 1: inputs

struct InputStepView: View {
    @Binding var beverage: Beverage
    @Binding var beerInputs: BeerInputs
    @Binding var coffeeInputs: CoffeeInputs
    var onContinue: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 22) {
                Picker("", selection: $beverage) {
                    ForEach(Beverage.allCases) { item in
                        Text(item.title).tag(item)
                    }
                }
                .pickerStyle(.segmented)

                switch beverage {
                case .beer: BeerInputForm(inputs: $beerInputs)
                case .coffee: CoffeeInputForm(inputs: $coffeeInputs)
                }

                PrimaryButton(
                    title: canContinue ? "Start guided tasting" : canContinueTitle,
                    systemImage: "sparkles"
                ) {
                    if canContinue { onContinue() }
                }
                .opacity(canContinue ? 1.0 : 0.4)
            }
            .padding(16)
        }
    }

    private var canContinue: Bool {
        switch beverage {
        case .beer: return beerInputs.styleKey != nil
        case .coffee: return coffeeInputs.varietyKey != nil && coffeeInputs.methodKey != nil
        }
    }

    private var canContinueTitle: String {
        switch beverage {
        case .beer: return "Pick a style to continue"
        case .coffee:
            if coffeeInputs.varietyKey == nil { return "Pick the bean variety to continue" }
            return "Pick a tasting method to continue"
        }
    }
}

// MARK: - Beer input form

struct BeerInputForm: View {
    @Binding var inputs: BeerInputs

    var body: some View {
        VStack(spacing: 22) {
            card {
                VStack(alignment: .leading, spacing: 14) {
                    SectionHeader(title: "The essentials", subtitle: "Style is all you need - everything else sharpens the guidance.")

                    ThemedField(title: "Beer name (optional)", text: $inputs.name)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Style *")
                            .font(.caption)
                            .foregroundStyle(Theme.creamDim)
                        Menu {
                            Picker("Style", selection: $inputs.styleKey) {
                                ForEach(BeerKnowledge.styles, id: \.key) { style in
                                    Text(style.name).tag(style.key as String?)
                                }
                            }
                        } label: {
                            HStack {
                                Text(inputs.styleKey.flatMap { BeerKnowledge.style(forKey: $0)?.name } ?? "Choose a style")
                                    .font(.subheadline.weight(.medium))
                                    .foregroundStyle(inputs.styleKey == nil ? Theme.creamDim : Theme.toffee)
                                Spacer()
                                Image(systemName: "chevron.up.chevron.down")
                                    .font(.caption)
                                    .foregroundStyle(Theme.caramelSoft)
                            }
                            .padding(12)
                            .background(Theme.espresso.opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .strokeBorder(Theme.creamDim.opacity(0.15), lineWidth: 1)
                            )
                        }

                        if let style = inputs.styleKey.flatMap({ BeerKnowledge.style(forKey: $0) }) {
                            Text(style.blurb)
                                .font(.caption)
                                .foregroundStyle(Theme.creamDim)
                                .padding(.top, 2)
                        }
                    }
                }
            }

            card {
                VStack(alignment: .leading, spacing: 14) {
                    SectionHeader(title: "Ingredients", subtitle: "Known malts, hops and yeast add specific descriptors to look for.")

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Malts")
                            .font(.caption)
                            .foregroundStyle(Theme.creamDim)
                        DropdownMultiSelect(
                            label: "Add malts",
                            options: BeerKnowledge.malts.map(\.name).sorted(),
                            selection: $inputs.malts
                        )
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Hops")
                            .font(.caption)
                            .foregroundStyle(Theme.creamDim)
                        DropdownMultiSelect(
                            label: "Add hops",
                            options: BeerKnowledge.hops.map(\.name).sorted(),
                            selection: $inputs.hops
                        )
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Yeast")
                            .font(.caption)
                            .foregroundStyle(Theme.creamDim)
                        Menu {
                            Picker("Yeast", selection: $inputs.yeastKey) {
                                Text("Not sure").tag(String?.none)
                                ForEach(BeerKnowledge.yeasts, id: \.key) { yeast in
                                    Text(yeast.name).tag(yeast.key as String?)
                                }
                            }
                        } label: {
                            HStack {
                                Text(inputs.yeastKey.flatMap { BeerKnowledge.yeast(forKey: $0)?.name } ?? "Not sure")
                                    .font(.subheadline.weight(.medium))
                                    .foregroundStyle(inputs.yeastKey == nil ? Theme.creamDim : Theme.toffee)
                                Spacer()
                                Image(systemName: "chevron.up.chevron.down")
                                    .font(.caption)
                                    .foregroundStyle(Theme.caramelSoft)
                            }
                            .padding(12)
                            .background(Theme.espresso.opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                    }
                }
            }

            card {
                VStack(alignment: .leading, spacing: 16) {
                    SectionHeader(title: "Stats", subtitle: "Only if you know them.")

                    NumberSliderRow(title: "ABV", range: 2.0...14.0, step: 0.1, unit: "%", value: $inputs.abv)
                    NumberSliderRow(title: "IBU", range: 0...120, step: 1, unit: "", value: Binding<Double?>(
                        get: { inputs.ibu.map(Double.init) },
                        set: { inputs.ibu = $0.map { Int($0) } }
                    ))
                }
            }

            card {
                VStack(alignment: .leading, spacing: 10) {
                    SectionHeader(title: "Anything else?", subtitle: "Brewery notes, can art, thoughts before tasting.")
                    ThemedField(title: "Notes (optional)", text: $inputs.notes)
                }
            }
        }
    }
}

// MARK: - Coffee input form

struct CoffeeInputForm: View {
    @Binding var inputs: CoffeeInputs

    var body: some View {
        VStack(spacing: 22) {
            card {
                VStack(alignment: .leading, spacing: 14) {
                    SectionHeader(title: "The beans", subtitle: "Variety drives the guidance; origin and process refine it.")

                    ThemedField(title: "Coffee name (optional)", text: $inputs.name)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Bean variety *")
                            .font(.caption)
                            .foregroundStyle(Theme.creamDim)
                        Menu {
                            Menu("Arabica (\(CoffeeKnowledge.arabicaVarieties.count))") {
                                Picker("Variety", selection: $inputs.varietyKey) {
                                    ForEach(CoffeeKnowledge.arabicaVarieties, id: \.key) { variety in
                                        Text(variety.name).tag(variety.key as String?)
                                    }
                                }
                            }
                            Menu("Robusta (\(CoffeeKnowledge.robustaVarieties.count))") {
                                Picker("Variety", selection: $inputs.varietyKey) {
                                    ForEach(CoffeeKnowledge.robustaVarieties, id: \.key) { variety in
                                        Text(variety.name).tag(variety.key as String?)
                                    }
                                }
                            }
                        } label: { menuLabel(inputs.varietyKey.flatMap { CoffeeKnowledge.variety(forKey: $0)?.name }, placeholder: "e.g. Catuaí, Geisha, SL28, Roubi 1...") }

                        if let variety = inputs.varietyKey.flatMap({ CoffeeKnowledge.variety(forKey: $0) }) {
                            Text(variety.blurb)
                                .font(.caption)
                                .foregroundStyle(Theme.creamDim)
                                .padding(.top, 2)

                            if !CoffeeKnowledge.hasCupDescriptors(forKey: inputs.varietyKey ?? "") {
                                InfoBanner(text: "No variety-specific tasting notes for \(variety.name) yet - guidance will use general \(variety.species == "Robusta" ? "robusta" : "arabica") expectations. Adding roast and process helps refine it.")
                            }
                        }
                    }

                    ThemedField(title: "Origin (optional) - farm, region, country", text: $inputs.origin)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Process (optional)")
                            .font(.caption)
                            .foregroundStyle(Theme.creamDim)
                        Menu {
                            Picker("Process", selection: $inputs.processKey) {
                                Text("Not sure").tag(String?.none)
                                ForEach(CoffeeKnowledge.processes, id: \.key) { process in
                                    Text(process.name).tag(process.key as String?)
                                }
                            }
                        } label: { menuLabel(inputs.processKey.flatMap { CoffeeKnowledge.process(forKey: $0)?.name }, placeholder: "Washed, natural, honey...") }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Roast level (optional)")
                            .font(.caption)
                            .foregroundStyle(Theme.creamDim)
                        Menu {
                            Picker("Roast", selection: $inputs.roastKey) {
                                Text("Not sure").tag(String?.none)
                                ForEach(CoffeeKnowledge.roasts, id: \.key) { roast in
                                    Text(roast.name).tag(roast.key as String?)
                                }
                            }
                        } label: { menuLabel(inputs.roastKey.flatMap { CoffeeKnowledge.roast(forKey: $0)?.name }, placeholder: "Light, medium, dark...") }
                    }
                }
            }

            card {
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "How are you tasting it? *", subtitle: "The method defines each guided step.")
                    ForEach(CoffeeKnowledge.methods, id: \.key) { method in
                        Button {
                            inputs.methodKey = method.key
                        } label: {
                            OptionRow(
                                title: method.name,
                                detail: method.blurb,
                                isSelected: inputs.methodKey == method.key
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }

            card {
                VStack(alignment: .leading, spacing: 10) {
                    SectionHeader(title: "Anything else?", subtitle: "Roaster, tasting notes from the bag, thoughts.")
                    ThemedField(title: "Notes (optional)", text: $inputs.notes)
                }
            }
        }
    }

    private func menuLabel(_ text: String?, placeholder: String) -> some View {
        HStack {
            Text(text ?? placeholder)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(text == nil ? Theme.creamDim : Theme.toffee)
            Spacer()
            Image(systemName: "chevron.up.chevron.down")
                .font(.caption)
                .foregroundStyle(Theme.caramelSoft)
        }
        .padding(12)
        .background(Theme.espresso.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(Theme.creamDim.opacity(0.15), lineWidth: 1)
        )
    }
}

// MARK: - Optional number slider

struct NumberSliderRow: View {
    let title: String
    let range: ClosedRange<Double>
    let step: Double
    let unit: String
    @Binding var value: Double?
    @State private var enabled: Bool

    init(title: String, range: ClosedRange<Double>, step: Double, unit: String, value: Binding<Double?>) {
        self.title = title
        self.range = range
        self.step = step
        self.unit = unit
        self._value = value
        _enabled = State(initialValue: value.wrappedValue != nil)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Toggle(isOn: $enabled) {
                Text(title)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Theme.cream)
            }
            .tint(Theme.caramel)
            .onChange(of: enabled) { _, newValue in
                value = newValue ? ((range.lowerBound + range.upperBound) / 2) : nil
            }

            if enabled {
                let binding = Binding<Double>(
                    get: { value ?? ((range.lowerBound + range.upperBound) / 2) },
                    set: { value = (step >= 1 ? Double(Int($0)) : $0) }
                )
                HStack {
                    Slider(value: binding, in: range, step: step)
                        .tint(Theme.caramel)
                    Text(displayValue)
                        .font(.subheadline.weight(.semibold).monospacedDigit())
                        .foregroundStyle(Theme.toffee)
                        .frame(minWidth: 48, alignment: .trailing)
                }
            }
        }
    }

    private var displayValue: String {
        guard let value else { return "" }
        if step >= 1 {
            return "\(Int(value))\(unit)"
        }
        return String(format: "%.1f%@", value, unit)
    }
}

// MARK: - Step 2: guided tasting

struct GuidedFlowView: View {
    let beverage: Beverage
    let intro: GuidanceIntro
    let stages: [TastingStage]
    @Binding var answers: [StageAnswer]
    var onFinish: () -> Void

    @State private var index = 0

    var body: some View {
        VStack(spacing: 0) {
            ProgressBar(steps: stages.count, current: index)
            ScrollView {
                VStack(spacing: 20) {
                    if index == 0 {
                        introCard
                    }
                    stageCard
                }
                .padding(16)
                .padding(.bottom, 12)
            }
            controlBar
        }
    }

    private var introCard: some View {
        card {
            VStack(alignment: .leading, spacing: 12) {
                Text(intro.title)
                    .font(.title3.bold())
                    .foregroundStyle(Theme.toffee)
                Text(intro.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(Theme.creamDim)

                if let confidence = intro.confidenceNote {
                    Label(confidence, systemImage: "lightbulb")
                        .font(.caption)
                        .foregroundStyle(Theme.caramelSoft)
                        .padding(10)
                        .background(Theme.caramel.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }

                if !intro.facts.isEmpty {
                    VStack(spacing: 6) {
                        ForEach(intro.facts, id: \.0) { fact in
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
                    }
                    .padding(.top, 2)
                }

                if !intro.tips.isEmpty {
                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(intro.tips, id: \.self) { tip in
                            HStack(alignment: .top, spacing: 8) {
                                Image(systemName: "checkmark.circle")
                                    .font(.caption)
                                    .foregroundStyle(Theme.caramel)
                                Text(tip)
                                    .font(.caption)
                                    .foregroundStyle(Theme.creamDim)
                            }
                        }
                    }
                }
            }
        }
    }

    private var currentStage: TastingStage {
        stages[min(index, stages.count - 1)]
    }

    private var stageCard: some View {
        let answerIndex = answers.firstIndex { $0.stageId == currentStage.id }

        return card {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Step \(index + 1) of \(stages.count)")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Theme.caramel)
                    Text(currentStage.title)
                        .font(.title2.bold())
                        .foregroundStyle(Theme.toffee)
                    Text(currentStage.prompt)
                        .font(.subheadline)
                        .foregroundStyle(Theme.cream)
                }

                if let expectation = currentStage.expectation {
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "eye")
                            .font(.caption)
                            .foregroundStyle(Theme.caramel)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("What to expect")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(Theme.caramelSoft)
                            Text(expectation)
                                .font(.footnote)
                                .foregroundStyle(Theme.cream)
                        }
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Theme.caramel.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .strokeBorder(Theme.caramel.opacity(0.35), lineWidth: 1)
                    )
                }

                Text(currentStage.guidance)
                    .font(.footnote)
                    .foregroundStyle(Theme.creamDim)
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Theme.espresso.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                if !currentStage.suggestions.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("What do you perceive? Tap all that apply.")
                            .font(.caption)
                            .foregroundStyle(Theme.creamDim)
                        TagPicker(
                            options: currentStage.suggestions,
                            selection: Binding(
                                get: { answerIndex.map { answers[$0].selected } ?? [] },
                                set: { newValue in
                                    if let i = answers.firstIndex(where: { $0.stageId == currentStage.id }) {
                                        answers[i].selected = newValue
                                    }
                                }
                            )
                        )
                    }
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Rate: \(currentStage.ratingLabel)")
                        .font(.caption)
                        .foregroundStyle(Theme.creamDim)
                    RatingBar(
                        rating: Binding(
                            get: { answerIndex.flatMap { answers[$0].rating } },
                            set: { newValue in
                                if let i = answers.firstIndex(where: { $0.stageId == currentStage.id }) {
                                    answers[i].rating = newValue
                                }
                            }
                        )
                    )
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Notes (optional)")
                        .font(.caption)
                        .foregroundStyle(Theme.creamDim)
                    ThemedField(title: "What stood out?", text: Binding(
                        get: { answerIndex.map { answers[$0].notes } ?? "" },
                        set: { newValue in
                            if let i = answers.firstIndex(where: { $0.stageId == currentStage.id }) {
                                answers[i].notes = newValue
                            }
                        }
                    ))
                }
            }
        }
    }

    private var controlBar: some View {
        HStack(spacing: 12) {
            if index > 0 {
                Button {
                    withAnimation { index -= 1 }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Theme.toffee)
                        .background(Theme.walnut.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
            }

            if index < stages.count - 1 {
                PrimaryButton(title: "Next", systemImage: "chevron.right") {
                    withAnimation { index += 1 }
                }
            } else {
                PrimaryButton(title: "To summary", systemImage: "list.clipboard") {
                    onFinish()
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Theme.espressoDeep.opacity(0.9))
    }
}

struct ProgressBar: View {
    let steps: Int
    let current: Int

    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<steps, id: \.self) { step in
                Capsule()
                    .fill(step <= current ? Theme.caramel : Theme.creamDim.opacity(0.2))
                    .frame(height: 4)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Theme.espressoDeep.opacity(0.9))
    }
}

// MARK: - Step 3: summary

struct SummaryStepView: View {
    let beverage: Beverage
    let intro: GuidanceIntro
    let answers: [StageAnswer]
    @Binding var overallRating: Int?
    @Binding var summaryText: String
    var onSave: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                card {
                    VStack(alignment: .leading, spacing: 14) {
                        Text(intro.title)
                            .font(.title3.bold())
                            .foregroundStyle(Theme.toffee)
                        Text(intro.subtitle)
                            .font(.subheadline)
                            .foregroundStyle(Theme.creamDim)

                        VStack(spacing: 8) {
                            Text("Overall rating")
                                .font(.caption)
                                .foregroundStyle(Theme.creamDim)
                            RatingBar(rating: $overallRating)
                                .frame(maxWidth: .infinity)
                        }
                        .padding(12)
                        .background(Theme.caramel.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                        ThemedField(title: "Final thoughts (optional)", text: $summaryText)
                    }
                }

                card {
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Your tasting notes")
                            .font(.headline)
                            .foregroundStyle(Theme.toffee)

                        ForEach(answers) { answer in
                            VStack(alignment: .leading, spacing: 6) {
                                HStack {
                                    Text(answer.title)
                                        .font(.subheadline.weight(.semibold))
                                        .foregroundStyle(Theme.cream)
                                    Spacer()
                                    StaticRating(rating: answer.rating)
                                }
                                if !answer.selected.isEmpty {
                                    Text(answer.selected.joined(separator: " · "))
                                        .font(.caption)
                                        .foregroundStyle(Theme.caramelSoft)
                                }
                                if !answer.notes.isEmpty {
                                    Text(answer.notes)
                                        .font(.caption)
                                        .foregroundStyle(Theme.creamDim)
                                }
                            }
                            .padding(.bottom, 10)
                        }
                    }
                }

                PrimaryButton(title: "Save tasting", systemImage: "square.and.arrow.down") {
                    onSave()
                }
                .padding(.bottom, 12)
            }
            .padding(16)
        }
    }
}

// MARK: - Step 4: saved confirmation

struct SavedStepView: View {
    let beverage: Beverage
    var onDone: () -> Void
    var onAnother: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 64))
                .foregroundStyle(Theme.caramel)
            Text("Tasting saved")
                .font(.title.bold())
                .foregroundStyle(Theme.toffee)
            Text("Stored locally on this device. Find it any time in the History tab.")
                .font(.subheadline)
                .foregroundStyle(Theme.creamDim)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Spacer()

            VStack(spacing: 12) {
                PrimaryButton(title: "Start another tasting", systemImage: "plus") { onAnother() }
                SecondaryButton(title: "Done", systemImage: "checkmark") { onDone() }
            }
            .padding(16)
        }
    }
}
