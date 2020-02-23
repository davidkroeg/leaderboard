//
//  LeaderboardViewController.swift
//  NetworkingSetup
//
//  Created by David Krög on 23.02.20.
//  Copyright © 2020 David Krög. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    @IBOutlet var viewModel: LeaderboardViewModel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Player>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Leaderboard"
        configureHierarchie()
        configureDataSource()
        performQuery(with: nil)
    }
    
    
}

//MARK: - setup view
extension LeaderboardViewController {
    
    private func configureHierarchie() {
        collectionView.collectionViewLayout = createLayout()
        let cellNib = UINib(nibName: "PlayerCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: PlayerCell.reuseIdentifier)
        searchBar.delegate = self
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
}

//MARK: - setup datasource
extension LeaderboardViewController {
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Player>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, player: Player) -> UICollectionViewCell? in
            guard let playerCell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerCell.reuseIdentifier, for: indexPath) as? PlayerCell else {
                fatalError("Cannot create cell!")
            }
            playerCell.ranking = String(player.rank)
            playerCell.name = player.name
            return playerCell
        }
    }
    
    private func performQuery(with filter: String?) {
        viewModel.getLeaderboard {
            if let players = self.viewModel.players {
                var snapshot = NSDiffableDataSourceSnapshot<Section, Player>()
                snapshot.appendSections([.main])
                snapshot.appendItems(players)
                self.dataSource.apply(snapshot, animatingDifferences: true)
            }
        }
        
        
    }
}

//MARK: - UISearchbarDelegate methods
extension LeaderboardViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //TODO: call filter function
    }
}
