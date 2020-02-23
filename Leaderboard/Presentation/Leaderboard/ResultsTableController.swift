//
//  ResultsTableController.swift
//  Leaderboard
//
//  Created by David Krög on 23.02.20.
//  Copyright © 2020 David Krög. All rights reserved.
//

import UIKit

class ResultsTableController: UITableViewController {

    enum Section {
        case main
    }
    
    @IBOutlet weak var labelResults: UILabel!
    
    var dataSource: UITableViewDiffableDataSource<Section, Player>!
    var filteredPlayers = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "ResultCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: ResultCell.reuseIdentifier)
        configureDataSource()
    }

}

// MARK: - UITableViewDataSource
extension ResultsTableController {
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Player>(tableView: tableView, cellProvider: { (tableView: UITableView, indexPath: IndexPath, player: Player) -> UITableViewCell? in
            guard let resultCell = tableView.dequeueReusableCell(withIdentifier: ResultCell.reuseIdentifier, for: indexPath) as? ResultCell else {
                fatalError("Cannot create cell!")
            }
            resultCell.name = player.name
            resultCell.ranking = String(player.rank)
            return resultCell
        })
    }
    
}
