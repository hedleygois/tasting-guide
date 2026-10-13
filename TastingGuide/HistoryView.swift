import SwiftUI

struct HistoryView: View {
    @ObservedObject private var store = TastingStore.shared
    @State private var filter: Beverage?

    private var filtered: [TastingRecord] {
        guard let filter else { return store.tastings }
        return store.tastings.filter { $0.beverage == filter }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 14) {
                    filterBar
                    if filtered.isEmpty {
                        emptyState
                    } else {
                        ForEach(filtered) { record in
                            NavigationLink(value: record.id) {
                                TastingRow(record: record)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(16)
                .padding(.bottom, 24)
            }
            .background(Theme.appBackground.ignoresSafeArea())
            .navigationTitle("History")
            .navigationDestination(for: UUID.self) { id in
                if let record = store.tastings.first(where: { $0.id == id }) {
                    TastingDetailView(record: record)
                }
            }
        }
        .preferredColorScheme(.dark)
    }

    private var filterBar: some View {
        HStack(spacing: 8) {
            filterChip(label: "All", key: nil)
            filterChip(label: "Beer", key: .beer)
            filterChip(label: "Coffee", key: .coffee)
            Spacer()
            Text("\(filtered.count) saved")
                .font(.caption)
                .foregroundStyle(Theme.creamDim.opacity(0.8))
        }
    }

    private func filterChip(label: String, key: Beverage?) -> some View {
        Chip(label: label, isSelected: filter == key) {
            withAnimation(.easeInOut(duration: 0.15)) { filter = key }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "tray")
                .font(.system(size: 42))
                .foregroundStyle(Theme.creamDim.opacity(0.4))
            Text("No tastings saved yet")
                .font(.headline)
                .foregroundStyle(Theme.toffee)
            Text("Start a beer or coffee tasting from the Tasting tab and your notes will be saved here.")
                .font(.subheadline)
                .foregroundStyle(Theme.creamDim)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 64)
        .frame(maxWidth: .infinity)
    }
}
