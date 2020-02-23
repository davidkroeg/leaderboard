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

extension Leaderboard {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    timePosted = try container.decode(Double.self, forKey: .timePosted)
    nextScheduledPostTime = try container.decode(Double.self, forKey: .nextScheduledPostTime)
    serverTime = try container.decode(Double.self, forKey: .serverTime)
    var leaderboardContainer = try container.nestedUnkeyedContainer(forKey: .players)
    var leaderboardPlayers = [Player]()
    while !leaderboardContainer.isAtEnd {
      let player = try leaderboardContainer.decode(Player.self)
      leaderboardPlayers.append(player)
    }
    
    players = leaderboardPlayers
  }
}
