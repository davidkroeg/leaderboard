//
//  LeaderboardViewModel.swift
//  NetworkingSetup
//
//  Created by David Krög on 22.02.20.
//  Copyright © 2020 David Krög. All rights reserved.
//

import Foundation

class LeaderboardViewModel {
    
    var leaderboardApi : LeaderboardApi
    
    var players: [Player]?
    var leaderboard : Leaderboard?
    
    var region: LeaderboardRegion = .europe //FIXME: dont hard code region
    
    init(leaderboardApi: LeaderboardApi) {
        self.leaderboardApi = leaderboardApi
    }
    
    func loadLeaderboard(completion: @escaping () -> Void) {
        leaderboardApi.fetchLeaderboard(for: region) { result in
            switch result {
            case .success(let leaderboard):
                self.leaderboard = leaderboard
                self.players = leaderboard.players
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func filteredPlayers(with filter: String? = nil) -> [Player]? {
        let filtered = players?.filter { $0.contains(filter) }
        return filtered
    }
    

    
}
