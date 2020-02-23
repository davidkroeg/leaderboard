//
//  LeaderboardViewController.swift
//  NetworkingSetup
//
//  Created by David Krög on 23.02.20.
//  Copyright © 2020 David Krög. All rights reserved.
//

import UIKit

class LeaderboardViewController: UICollectionViewController {
    
    enum Section {
        case main
    }
    
    @IBOutlet var viewModel: LeaderboardViewModel!
    
    var searchController: UISearchController!
    private var resultsTableController: ResultsTableController!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Player>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchie()
        configureDataSource()
        performQuery(with: nil)
    }
    
    
}

//MARK: - Setup view
extension LeaderboardViewController {
    
    private func configureHierarchie() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        resultsTableController =
            self.storyboard?.instantiateViewController(withIdentifier: "ResultsTableController") as? ResultsTableController
        resultsTableController.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        searchController.searchBar.scopeButtonTitles = ["Europe",
                                                        "America",
                                                        "China",
                                                        "SEA"]
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle"), style: .plain, target: self, action: #selector(actionTapped))
        
        collectionView.collectionViewLayout = createLayout()
        let cellNib = UINib(nibName: "PlayerCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: PlayerCell.reuseIdentifier)
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

//MARK: - DataSource
extension LeaderboardViewController {
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Player>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, player: Player) -> UICollectionViewCell? in
            guard let playerCell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerCell.reuseIdentifier, for: indexPath) as? PlayerCell else {
                fatalError("Cannot create cell!")
            }
            playerCell.ranking = String(player.rank)
            playerCell.name = player.name
            playerCell.country = player.country
            return playerCell
        }
    }
    
    private func performQuery(with filter: String?) {
        viewModel.getLeaderboard {
            if let players = self.viewModel.filteredPlayers(with: filter) {
                var snapshot = NSDiffableDataSourceSnapshot<Section, Player>()
                snapshot.appendSections([.main])
                snapshot.appendItems(players)
                self.dataSource.apply(snapshot, animatingDifferences: true)
            }
        }
        
        
    }
}

//MARK: - UITableViewDelegate for ResultTable
extension LeaderboardViewController: UITableViewDelegate {
    
}

//MARK: - UISearchBarDelegate
extension LeaderboardViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        //updateSearchResults(for: searchController)
    }
}

//MARK: - UISearchControllerDelegate
extension LeaderboardViewController: UISearchControllerDelegate {
    
}
