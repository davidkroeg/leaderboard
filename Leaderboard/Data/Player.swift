//
//  Player.swift
//  NetworkingSetup
//
//  Created by David Krög on 22.02.20.
//  Copyright © 2020 David Krög. All rights reserved.
//

import Foundation

struct Player: Hashable, Codable, Identifiable {
    
    let id = UUID()
    let rank: Int
    let name: String
    let teamId: Int?
    let teamTag: String?
    let country: String?
    let sponsor: String?
    
    enum CodingKeys: String, CodingKey {
        case rank, name, teamId, teamTag, country, sponsor
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(_ filter: String?) -> Bool {
        guard let filterText = filter else {
            return true
        }
        if filterText.isEmpty {
            return true
        }
        let lowercaseFilter = filterText.lowercased()
        return name.lowercased().contains(lowercaseFilter)
    }
    
    func isFrom(_ countryFilter: String?) -> Bool {
        guard let country = country else {
            return true
        }
        
        guard let countryText = countryFilter else {
            return true
        }
        if countryText.isEmpty {
            return true
        }
        
        let lowercasedCountry = countryText.lowercased()
        return country.lowercased().contains(lowercasedCountry)
    }
    
}
