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
    var rank: Int
    var name: String
    var teamId: Int?
    var teamTag: String?
    var country: String?
    var sponsor: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}
