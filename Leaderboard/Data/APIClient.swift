//
//  APIClient.swift
//  NetworkingSetup
//
//  Created by David Krög on 22.02.20.
//  Copyright © 2020 David Krög. All rights reserved.
//

import Foundation

let apiUrl = "http://www.dota2.com/webapi/ILeaderboard/GetDivisionLeaderboard/v0001?division=europe&leaderboard=2"

class APIClient: NSObject {
  
  let decoder = JSONDecoder()
  
  override init() {
    super.init()
    
    decoder.keyDecodingStrategy = .convertFromSnakeCase
  }
  
  //FIXME: - cant get players like this. Need to decode from leaderboard key
  func fetchPlayers(completion: @escaping ([Player]?) -> Void) {
    //fetch json and decode and update some array property
    guard let url = URL(string: apiUrl) else {
      print("Error unwraping url.")
      return

    }
    URLSession.shared.dataTask(with: url) { (data, resp, err) in
      
      guard let unwrappedData = data else  {
        print("Error getting data")
        return
      }
      
      do {
        let players: [Player] = try self.decoder.decode([Player].self, from: unwrappedData)
        completion(players)
      } catch {
        completion(nil)
        print("Error getting API data: \(error.localizedDescription)")
      }
      
        
    }.resume()
  }
  
  func fetchLeaderboard(completion: @escaping (Leaderboard?) -> Void) {
    //fetch json and decode and update some array property
    guard let url = URL(string: apiUrl) else {
      print("Error unwraping url.")
      return
      
    }
    URLSession.shared.dataTask(with: url) { (data, resp, err) in
      
      guard let unwrappedData = data else  {
        print("Error getting data")
        return
      }
      

      
//      // Convert to a string and print
//      if let JSONString = String(data: unwrappedData, encoding: String.Encoding.utf8) {
//        print(JSONString)
//      }
      
      do {
        let leaderboard: Leaderboard = try self.decoder.decode(Leaderboard.self, from: unwrappedData)
        completion(leaderboard)
      } catch {
        completion(nil)
        print("Error getting API data: \(error)")
      }
      
      
    }.resume()
  }
  
}
