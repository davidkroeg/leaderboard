//
//  LeaderboardViewModel.swift
//  NetworkingSetup
//
//  Created by David Krög on 22.02.20.
//  Copyright © 2020 David Krög. All rights reserved.
//

import Foundation

class LeaderboardViewModel: NSObject {
    
    var leaderboardApi : LeaderboardApi
    
    var players: [Player]?
    var leaderboard : Leaderboard?
    
    override init() {
        #if TEST
        self.leaderboardApi = MockApiClient()
        #else
        self.leaderboardApi = ApiClient()
        #endif
    }
    
    func loadLeaderboard(for region: LeaderboardRegion, completion: @escaping () -> Void) {
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
