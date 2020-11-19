//
//  PlayerCell.swift
//  Leaderboard
//
//  Created by David Krög on 19.11.20.
//  Copyright © 2020 David Krög. All rights reserved.
//

import UIKit

// This list cell subclass is an abstract class with a property that holds the player the cell is displaying,
// which is added to the cell's configuration state for subclasses to use when updating their configuration.
class PlayerListCell: UICollectionViewListCell {
    private var player: Player? = nil
    
    func updateWithPlayer(_ newPlayer: Player) {
        guard player != newPlayer else { return }
        player = newPlayer
        setNeedsUpdateConfiguration()
    }
    
    override var configurationState: UICellConfigurationState {
        var state = super.configurationState
        state.player = self.player
        return state
    }
    
}

// Declare a custom key for a custom `player` property.
fileprivate extension UIConfigurationStateCustomKey {
    static let player = UIConfigurationStateCustomKey("at.kroeg.PlayerListCell.player")
}

// Declare an extension on the cell state struct to provide a typed property for this custom state.
private extension UICellConfigurationState {
    var player: Player? {
        set { self[.player] = newValue }
        get { return self[.player] as? Player}
    }
}

class PlayerCell: PlayerListCell {

    private func defaultListContentConfiguration() -> UIListContentConfiguration {
        return .subtitleCell()
    }
    private lazy var listContentView = UIListContentView(configuration: defaultListContentConfiguration())
    
    private let rankLabel = UILabel()
    private let countryLabel = UILabel()
    private var customViewConstraints: (rankLabelLeading: NSLayoutConstraint,
                                        rankLabelTrailing: NSLayoutConstraint,
                                        countryLabelLeading: NSLayoutConstraint,
                                        countryLabelTrailing: NSLayoutConstraint)?
    
    private func setupViewsIfNeeded() {
        // We only need to do anything if we haven't already setup the views and created constraints.
        guard customViewConstraints == nil else  { return }
        
        contentView.addSubview(listContentView)
        contentView.addSubview(rankLabel)
        contentView.addSubview(countryLabel)
        listContentView.translatesAutoresizingMaskIntoConstraints = false
        let defaultHorizontalCompressionResistance = listContentView.contentCompressionResistancePriority(for: .horizontal)
        listContentView.setContentCompressionResistancePriority(defaultHorizontalCompressionResistance - 1, for: .horizontal)
        
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = (
            rankLabelLeading: rankLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rankLabelTrailing: rankLabel.trailingAnchor.constraint(equalTo: listContentView.leadingAnchor),
            countryLabelLeading: listContentView.trailingAnchor.constraint(greaterThanOrEqualTo: countryLabel.leadingAnchor, constant: 20.0),
            countryLabelTrailing: contentView.trailingAnchor.constraint(equalTo: countryLabel.trailingAnchor, constant: 30)
        )
        
        NSLayoutConstraint.activate([
            listContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            listContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            rankLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            constraints.rankLabelLeading,
            constraints.rankLabelTrailing,
            constraints.countryLabelLeading,
            constraints.countryLabelTrailing
        ])
        customViewConstraints = constraints
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        setupViewsIfNeeded()
        
        var content = defaultListContentConfiguration().updated(for: state)
        content.text = state.player?.name
        content.secondaryText = state.player?.teamTag
        listContentView.configuration = content
        
//        let valueConfiguration = UIListContentConfiguration.valueCell().updated(for: state)
        if let rank = state.player?.rank {
            rankLabel.text = "\(rank)."
        }
        if let countryCode = state.player?.country {
            countryLabel.text = self.flag(country: countryCode)
        } else {
            countryLabel.text = nil
        }

        customViewConstraints?.rankLabelLeading.constant = content.directionalLayoutMargins.leading
    }
    
    func flag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.uppercased().unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return s
    }

}
