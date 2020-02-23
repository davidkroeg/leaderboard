//
//  MainTableViewController.swift
//  NetworkingSetup
//
//  Created by David Krög on 15.02.20.
//  Copyright © 2020 David Krög. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
  
  @IBOutlet var viewModel: LeaderboardViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    viewModel.getLeaderboard {
      self.tableView.reloadData()
    }
  }
  
  private func filterPlayers() {
    //filter players for name
  }
  
}

//MARK: - TableView data source methods
extension MainTableViewController {
  
  private func configureDataSource() {
    
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfItemsToDisplay(in: section)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    cell.textLabel?.text = viewModel.playerRankingToDisplay(for: indexPath)
    cell.detailTextLabel?.text = viewModel.playerNameToDisplay(for: indexPath)
    return cell
  }
}

