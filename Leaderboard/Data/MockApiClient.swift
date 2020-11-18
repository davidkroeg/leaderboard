//
//  MockClient.swift
//  Leaderboard
//
//  Created by David Krög on 11.11.20.
//  Copyright © 2020 David Krög. All rights reserved.
//

import Foundation

final class MockApiClient: LeaderboardApi {
    
    private static let delay = 0 // mock delay for request
    private static var requestCount = 1 // set this to 0 to mock data is nil at first attempt
    
    func availableRegions() -> [LeaderboardRegion] {
        return [.europe, .america, .china, .seAsia]
    }
    
    func fetchLeaderboard(for region: LeaderboardRegion, completion: @escaping (Result<Leaderboard, NetworkError>) -> Void) {
        switch MockApiClient.requestCount {
        case 0:
            completion(.failure(.dataIsNil))
        default:
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(MockApiClient.delay)) {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                MockApiClient.loadJsonDataFromFile(region.mockFilename) { data in
                    if let json = data {
                        do {
                            let leaderboard: Leaderboard = try decoder.decode(Leaderboard.self, from: json)
                            completion(.success(leaderboard))
                        } catch {
                            completion(.failure(.decodingFailed(error.localizedDescription)))
                        }
                    }
                }
            }
            MockApiClient.requestCount += 1
        }
    }
    
    private static func loadJsonDataFromFile(_ path: String, completion: (Data?) -> Void) {
        if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl)
                completion(data as Data)
            } catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
}
