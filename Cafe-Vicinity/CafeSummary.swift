//
//  Cafes.swift
//  Cafe-Vicinity
//
//  Created by Ada Muniz on 8/4/25.
//

import Foundation

struct CafeSummary: Codable, Equatable {
    //ID property to save movie
    let id: Int
    let name: String
    let imageNames: [String]
    
    //Additional properties
    let rating: Double
    let priceRange: String
    let transportation: String
    let website: String
    
    var isFavorite: Bool = false
    
    private enum CodingKeys: String, CodingKey {
            case id, name, imageNames, rating, priceRange, transportation, website
            // 👆 intentionally omit `isFavorite`
        }
}

