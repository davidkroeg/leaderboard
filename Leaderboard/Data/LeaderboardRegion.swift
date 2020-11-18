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
    
    var name: String {
        switch self {
        case .europe:
            return "Europe"
        case .america:
            return "America"
        case .china:
            return "Chinas"
        case .seAsia:
            return "SE-Asia"
        }
    }
    
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
    
    var mockFilename: String {
        switch self {
        case .europe:
            return "LeaderboardEurope"
        case .america:
            return "LeaderboardAmerica"
        case .china:
            return "LeaderboardChina"
        case .seAsia:
            return "LeaderboardSeAsia"
        }
    }
    
}
