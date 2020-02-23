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
    
    func getLeaderboard(completion: @escaping () -> Void) {
        apiClient.fetchLeaderboard { (leaderboard) in
            DispatchQueue.main.async {
                self.leaderboard = leaderboard
                self.players = leaderboard?.players
                completion()
            }
        }
    }
    
    func numberOfItemsToDisplay(in section: Int) -> Int {
        return leaderboard?.players.count ?? 0
    }
    
    func playerNameToDisplay(for indexPath: IndexPath) -> String {
        return leaderboard?.players[indexPath.row].name ?? ""
    }
    
    func playerRankingToDisplay(for indexPath: IndexPath) -> String {
        return String(leaderboard?.players[indexPath.row].rank ?? 0)
    }
}
