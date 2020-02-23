//
//  ResultCell.swift
//  Leaderboard
//
//  Created by David Krög on 23.02.20.
//  Copyright © 2020 David Krög. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {
    
    static let reuseIdentifier = "resultCell"
    
    var ranking: String = "" {
        didSet {
            self.detailTextLabel?.text = ranking
        }
    }
    
    var name: String = "" {
        didSet {
            self.textLabel?.text = name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
