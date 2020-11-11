//
//  APIClient.swift
//  NetworkingSetup
//
//  Created by David Krög on 22.02.20.
//  Copyright © 2020 David Krög. All rights reserved.
//

import Foundation

final class ApiClient: LeaderboardApi {
    
    func fetchLeaderboard(for region: LeaderboardRegion, completion: @escaping (Result<Leaderboard, NetworkError>) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let parameters = [
            URLConstants.urlRegionString: region.requestString,
            URLConstants.urlLeaderboardString: "0" //adapt this number is support/core mmr becomes a thing again
        ]
        
        var leaderboardURLComponents = URLComponents(string: URLConstants.baseUrlString)!
        leaderboardURLComponents.queryItems = parameters.map({ (key, value) -> URLQueryItem in
            URLQueryItem(name: key, value: value)
        })
        
        guard let url = leaderboardURLComponents.url else {
            completion(.failure(.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //TODO: handle error
            guard let unwrappedData = data else  {
                completion(.failure(.dataIsNil))
                return
            }
            
            do {
                let leaderboard: Leaderboard = try decoder.decode(Leaderboard.self, from: unwrappedData)
                completion(.success(leaderboard))
            } catch {
                completion(.failure(.decodingFailed(error.localizedDescription)))
            }
        }.resume()
    }

}
