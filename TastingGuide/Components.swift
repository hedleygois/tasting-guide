import SwiftUI

// MARK: - Cards

struct CardStyle: ViewModifier {
    var padding: CGFloat = 16

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(Theme.bark.opacity(0.85))
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .strokeBorder(Theme.caramel.opacity(0.14), lineWidth: 1)
            )
    }
}

extension View {
    func themedCard(padding: CGFloat = 16) -> some View {
        modifier(CardStyle(padding: padding))
    }
}

/// Free-function version so whole cards can be built from a ViewBuilder.
func card<C: View>(padding: CGFloat = 16, @ViewBuilder content: () -> C) -> some View {
    content()
        .padding(padding)
        .background(Theme.bark.opacity(0.85))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(Theme.caramel.opacity(0.14), lineWidth: 1)
        )
}

// MARK: - Section header

struct SectionHeader: View {
    let title: String
    var subtitle: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
                .foregroundStyle(Theme.toffee)
            if let subtitle {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(Theme.creamDim)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Tag / chip picker (multi-select)

struct TagPicker: View {
    let options: [String]
    @Binding var selection: [String]

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 110), spacing: 8)], spacing: 8) {
            ForEach(options, id: \.self) { option in
                Chip(label: option, isSelected: selection.contains(option)) {
                    if let index = selection.firstIndex(of: option) {
                        selection.remove(at: index)
                    } else {
                        selection.append(option)
                    }
                }
            }
        }
    }
}

struct Chip: View {
    let label: String
    var isSelected: Bool
    var tint: Color = Theme.caramel
    var action: (() -> Void)?

    var body: some View {
        Text(label)
            .font(.subheadline.weight(isSelected ? .semibold : .regular))
            .lineLimit(1)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(background)
            .foregroundStyle(foreground)
            .clipShape(Capsule())
            .overlay(
                Capsule().strokeBorder(border, lineWidth: isSelected ? 0 : 1)
            )
            .onTapGesture { action?() }
    }

    private var background: Color {
        isSelected ? tint.opacity(0.28) : Color.clear
    }

    private var foreground: Color {
        isSelected ? Theme.toffee : Theme.creamDim
    }

    private var border: Color {
        isSelected ? tint : Theme.creamDim.opacity(0.25)
    }
}

// MARK: - Info banner

struct InfoBanner: View {
    let text: String
    var icon: String = "info.circle"

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundStyle(Theme.caramelSoft)
            Text(text)
                .font(.caption)
                .foregroundStyle(Theme.creamDim)
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.caramel.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .strokeBorder(Theme.caramel.opacity(0.25), lineWidth: 1)
        )
    }
}

// MARK: - Dropdown multi-select (select in menu, chips below, tap chip to remove)

struct DropdownMultiSelect: View {
    let label: String
    let options: [String]
    @Binding var selection: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Menu {
                ForEach(options, id: \.self) { option in
                    // Toggles (unlike buttons) keep the menu open for further picks.
                    Toggle(isOn: Binding(
                        get: { selection.contains(option) },
                        set: { _ in toggle(option) }
                    )) {
                        Text(option)
                    }
                }
            } label: {
                HStack {
                    Text(selection.isEmpty ? label : "\(label): \(selection.count) selected")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(selection.isEmpty ? Theme.creamDim : Theme.toffee)
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

            if !selection.isEmpty {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 8)], spacing: 8) {
                    ForEach(selection, id: \.self) { item in
                        selectedChip(item)
                    }
                }
            }
        }
    }

    private func toggle(_ option: String) {
        if let index = selection.firstIndex(of: option) {
            selection.remove(at: index)
        } else {
            selection.append(option)
        }
    }

    private func selectedChip(_ item: String) -> some View {
        Button {
            selection.removeAll { $0 == item }
        } label: {
            HStack(spacing: 6) {
                Text(item)
                    .lineLimit(1)
                Image(systemName: "xmark")
                    .font(.caption2.weight(.bold))
            }
            .font(.subheadline.weight(.semibold))
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Theme.caramel.opacity(0.28))
            .foregroundStyle(Theme.toffee)
            .clipShape(Capsule())
            .overlay(Capsule().strokeBorder(Theme.caramel, lineWidth: 1))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Single-select option list

struct OptionRow: View {
    let title: String
    let detail: String
    var isSelected: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(isSelected ? Theme.toffee : Theme.cream)
            Text(detail)
                .font(.caption)
                .foregroundStyle(Theme.creamDim)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(isSelected ? Theme.caramel.opacity(0.16) : Theme.espresso.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(isSelected ? Theme.caramel : Theme.creamDim.opacity(0.12), lineWidth: 1)
        )
    }
}

// MARK: - Rating

struct RatingBar: View {
    @Binding var rating: Int?
    var max: Int = 5
    var symbol: String = "star.fill"

    var body: some View {
        HStack(spacing: 10) {
            ForEach(1...max, id: \.self) { value in
                Image(systemName: symbol)
                    .font(.system(size: 24))
                    .foregroundStyle(value <= (rating ?? 0) ? Theme.caramel : Theme.creamDim.opacity(0.3))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.12)) {
                            rating = rating == value ? nil : value
                        }
                    }
            }
        }
    }
}

struct StaticRating: View {
    let rating: Int?
    var max: Int = 5

    var body: some View {
        HStack(spacing: 3) {
            ForEach(1...max, id: \.self) { value in
                Image(systemName: value <= (rating ?? 0) ? "star.fill" : "star")
                    .font(.caption2)
                    .foregroundStyle(value <= (rating ?? 0) ? Theme.caramel : Theme.creamDim.opacity(0.4))
            }
        }
    }
}

// MARK: - Buttons

struct PrimaryButton: View {
    let title: String
    var systemImage: String?
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .foregroundStyle(Theme.espressoDeep)
            .background(Theme.caramelButton)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

struct SecondaryButton: View {
    let title: String
    var systemImage: String?
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .foregroundStyle(Theme.toffee)
            .background(Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .strokeBorder(Theme.caramel.opacity(0.5), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Text fields

struct ThemedField: View {
    let title: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundStyle(Theme.creamDim)
            TextField("", text: $text, prompt: Text(title).foregroundStyle(Theme.creamDim.opacity(0.5)))
                .foregroundStyle(Theme.cream)
                .padding(12)
                .background(Theme.espresso.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .strokeBorder(Theme.creamDim.opacity(0.15), lineWidth: 1)
                )
        }
    }
}

// MARK: - Badge

struct BeverageBadge: View {
    let beverage: Beverage

    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: beverage.symbol)
                .font(.caption2)
            Text(beverage.title)
                .font(.caption2.weight(.semibold))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(Theme.caramel.opacity(0.18))
        .foregroundStyle(Theme.caramelSoft)
        .clipShape(Capsule())
    }
}
