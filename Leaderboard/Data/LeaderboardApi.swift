//
//  LeaderboardApi.swift
//  Leaderboard
//
//  Created by David Krög on 11.11.20.
//  Copyright © 2020 David Krög. All rights reserved.
//

import Foundation

protocol LeaderboardApi {
    func fetchLeaderboard(for region: LeaderboardRegion, completion: @escaping (Result<Leaderboard, NetworkError>) -> Void)
}

enum NetworkError: Error {
    case badUrl
    case decodingFailed(String)
    case dataIsNil
    case errorWithText(reason: String)
}
