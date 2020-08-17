//
//  LeaderboardViewModel.swift
//  NetworkingSetup
//
//  Created by David Krög on 22.02.20.
//  Copyright © 2020 David Krög. All rights reserved.
//

import Foundation

class LeaderboardViewModel: NSObject {
    
    @IBOutlet var apiClient : APIClient!
    
    var players: [Player]?
    var leaderboard : Leaderboard?
    
    func getPlayers(completion: @escaping () -> Void) {
        apiClient.fetchPlayers { (arrayOfPlayers) in
            DispatchQueue.main.async {
                self.players = arrayOfPlayers
                completion()
            }
        }
    }
    
    func filteredPlayers(with filter: String? = nil) -> [Player]? {
        let filtered = players?.filter { $0.contains(filter) }
        return filtered
    }
    
    func getLeaderboard(completion: @escaping () -> Void) {
        apiClient.fetchLeaderboard { (leaderboard) in
            DispatchQueue.main.async {
                self.leaderboard = leaderboard
                self.players = leaderboard?.players
                completion()
            }
        }
    }
    
}
