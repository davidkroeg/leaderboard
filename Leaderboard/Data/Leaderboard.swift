//
//  Leaderboard.swift
//  NetworkingSetup
//
//  Created by David Krög on 22.02.20.
//  Copyright © 2020 David Krög. All rights reserved.
//

import Foundation

struct Leaderboard: Codable {
    
  var timePosted: Double
  var nextScheduledPostTime: Double
  var serverTime: Double
  var players: [Player]
  
  enum CodingKeys: String, CodingKey {
    case timePosted,nextScheduledPostTime,serverTime, players = "leaderboard"
  }
    
}
