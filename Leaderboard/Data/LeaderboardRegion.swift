//
//  LeaderboardRegion.swift
//  Leaderboard
//
//  Created by David Krög on 11.11.20.
//  Copyright © 2020 David Krög. All rights reserved.
//

import Foundation

enum LeaderboardRegion {
    case europe
    case america
    case china
    case seAsia
    
    var requestString: String {
        switch self {
        case .europe:
            return "europe"
        case .america:
            return "americas"
        case .china:
            return "chinas"
        case .seAsia:
            return "se_asia"
        }
    }
    
}
