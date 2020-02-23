//
//  PlayerCell.swift
//  Leaderboard
//
//  Created by David Krög on 23.02.20.
//  Copyright © 2020 David Krög. All rights reserved.
//

import UIKit

class PlayerCell: UICollectionViewCell {
    
    @IBOutlet weak var labelRanking: UILabel!
    @IBOutlet weak var labelPlayerName: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
    
    static let reuseIdentifier = "player-cell"
    
    var ranking: String = "" {
        didSet {
            labelRanking.text = ranking
        }
    }
    
    var name: String = "" {
        didSet {
            labelPlayerName.text = name
        }
    }
    
    var country: String? = "" {
        didSet {
            labelCountry.text = country ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()    }

}