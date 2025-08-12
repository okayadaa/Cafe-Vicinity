//
//  CafeDataLoader.swift
//  Cafe-Vicinity
//
//  Created by Ada Muniz on 8/5/25.
//

import Foundation

class CafeDataLoader {
    static func loadCafeSummariesFromJSON(named fileName: String) -> [CafeSummary] {
        // 1) List any json files we can see
                let allJSON = Bundle.main.paths(forResourcesOfType: "json", inDirectory: nil)
                print("JSON files in bundle:", allJSON)

                // 2) Try to locate the file
                guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
                    print("❌ Could not find \(fileName).json in bundle")
                    return []
        }
        // 3) Try to read it
                do {
                    let data = try Data(contentsOf: url)
                    // 4) Try to decode it
                    let cafes = try JSONDecoder().decode([CafeSummary].self, from: data)
                    print("✅ Decoded \(cafes.count) cafes")
                    return cafes
                } catch {
                    print("❌ Failed to load/decode \(fileName).json:", error)
                    return []
                }
    }


    // Load favorite cafe IDs
        static func loadFavoriteIDs() -> [Int] {
            return UserDefaults.standard.array(forKey: "favoriteIDs") as? [Int] ?? []
        }

        // Save favorite cafe IDs
        static func saveFavoriteIDs(_ ids: [Int]) {
            UserDefaults.standard.set(ids, forKey: "favoriteIDs")
        }

        // Add a favorite
        static func addFavorite(id: Int) {
            var ids = loadFavoriteIDs()
            if !ids.contains(id) {
                ids.append(id)
                saveFavoriteIDs(ids)
            }
        }

        // Remove a favorite
        static func removeFavorite(id: Int) {
            var ids = loadFavoriteIDs()
            ids.removeAll { $0 == id }
            saveFavoriteIDs(ids)
        }
}
extension CafeDataLoader {
    static func loadFavoriteCafes(from allCafes: [CafeSummary]) -> [CafeSummary] {
        let ids = Set(loadFavoriteIDs())
        return allCafes.filter { ids.contains($0.id) }
    }
}
