import Foundation
import SQLite3
import SwiftUI

/// Local persistence backed by SQLite (system libsqlite3, no dependencies).
final class TastingStore: ObservableObject {
    static let shared = TastingStore()

    @Published private(set) var tastings: [TastingRecord] = []

    private var db: OpaquePointer?
    private let transient = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

    private init() {
        guard let url = Self.databaseURL() else { return }
        guard sqlite3_open_v2(url.path, &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, nil) == SQLITE_OK else {
            db = nil
            return
        }
        createTableIfNeeded()
        reload()
    }

    deinit {
        if let db { sqlite3_close(db) }
    }

    private static func databaseURL() -> URL? {
        guard let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { return nil }
        let sub = dir.appendingPathComponent("TastingGuide", isDirectory: true)
        try? FileManager.default.createDirectory(at: sub, withIntermediateDirectories: true)
        return sub.appendingPathComponent("tastings.sqlite")
    }

    private func createTableIfNeeded() {
        let sql = """
        CREATE TABLE IF NOT EXISTS tastings (
            id TEXT PRIMARY KEY,
            beverage TEXT NOT NULL,
            created_at REAL NOT NULL,
            display_name TEXT NOT NULL,
            inputs_json TEXT NOT NULL,
            answers_json TEXT NOT NULL,
            overall_rating INTEGER,
            summary TEXT NOT NULL DEFAULT ''
        );
        """
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK else { return }
        defer { sqlite3_finalize(statement) }
        _ = sqlite3_step(statement)
    }

    private func reload() {
        let sql = "SELECT id, beverage, created_at, display_name, inputs_json, answers_json, overall_rating, summary FROM tastings ORDER BY created_at DESC;"
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK else { return }
        defer { sqlite3_finalize(statement) }

        var records: [TastingRecord] = []
        let decoder = JSONDecoder()

        while sqlite3_step(statement) == SQLITE_ROW {
            guard let idCString = sqlite3_column_text(statement, 0),
                  let beverageCString = sqlite3_column_text(statement, 1),
                  let id = UUID(uuidString: String(cString: idCString)),
                  let beverage = Beverage(rawValue: String(cString: beverageCString))
            else { continue }

            let createdAt = Date(timeIntervalSince1970: sqlite3_column_double(statement, 2))
            let displayName = sqlite3_column_text(statement, 3).map { String(cString: $0) } ?? ""
            let inputsJSON = sqlite3_column_text(statement, 4).map { String(cString: $0) } ?? ""
            let answersJSON = sqlite3_column_text(statement, 5).map { String(cString: $0) } ?? ""
            let overallRating = sqlite3_column_type(statement, 6) == SQLITE_NULL ? nil : Int(sqlite3_column_int(statement, 6))
            let summary = sqlite3_column_text(statement, 7).map { String(cString: $0) } ?? ""

            var beerInputs: BeerInputs?
            var coffeeInputs: CoffeeInputs?
            if let data = inputsJSON.data(using: .utf8) {
                switch beverage {
                case .beer: beerInputs = try? decoder.decode(BeerInputs.self, from: data)
                case .coffee: coffeeInputs = try? decoder.decode(CoffeeInputs.self, from: data)
                }
            }

            var answers: [StageAnswer] = []
            if let data = answersJSON.data(using: .utf8) {
                answers = (try? decoder.decode([StageAnswer].self, from: data)) ?? []
            }

            records.append(TastingRecord(
                id: id,
                beverage: beverage,
                createdAt: createdAt,
                displayName: displayName,
                overallRating: overallRating,
                summary: summary,
                beerInputs: beerInputs,
                coffeeInputs: coffeeInputs,
                answers: answers
            ))
        }

        tastings = records
    }

    func insert(_ record: TastingRecord) {
        let encoder = JSONEncoder()
        let inputsData: Data?
        switch record.beverage {
        case .beer: inputsData = try? encoder.encode(record.beerInputs)
        case .coffee: inputsData = try? encoder.encode(record.coffeeInputs)
        }
        let answersData = try? encoder.encode(record.answers)

        let sql = """
        INSERT OR REPLACE INTO tastings
            (id, beverage, created_at, display_name, inputs_json, answers_json, overall_rating, summary)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?);
        """
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK else { return }
        defer { sqlite3_finalize(statement) }

        sqlite3_bind_text(statement, 1, record.id.uuidString, -1, transient)
        sqlite3_bind_text(statement, 2, record.beverage.rawValue, -1, transient)
        sqlite3_bind_double(statement, 3, record.createdAt.timeIntervalSince1970)
        sqlite3_bind_text(statement, 4, record.displayName, -1, transient)
        let inputsJSON = inputsData.flatMap { String(data: $0, encoding: .utf8) } ?? "{}"
        sqlite3_bind_text(statement, 5, inputsJSON, -1, transient)
        let answersJSON = answersData.flatMap { String(data: $0, encoding: .utf8) } ?? "[]"
        sqlite3_bind_text(statement, 6, answersJSON, -1, transient)
        if let rating = record.overallRating {
            sqlite3_bind_int(statement, 7, Int32(rating))
        } else {
            sqlite3_bind_null(statement, 7)
        }
        sqlite3_bind_text(statement, 8, record.summary, -1, transient)

        _ = sqlite3_step(statement)
        reload()
    }

    func delete(_ record: TastingRecord) {
        let sql = "DELETE FROM tastings WHERE id = ?;"
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK else { return }
        defer { sqlite3_finalize(statement) }
        sqlite3_bind_text(statement, 1, record.id.uuidString, -1, transient)
        _ = sqlite3_step(statement)
        reload()
    }
}
