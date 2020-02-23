//
//  PlayerCell.swift
//  Leaderboard
//
//  Created by David Krög on 23.02.20.
//  Copyright © 2020 David Krög. All rights reserved.
//

import UIKit

class PlayerCell: UICollectionViewCell {
    
    static let reuseIdentifier = "player-cell"
    
    @IBOutlet weak var labelRanking: UILabel!
    @IBOutlet weak var labelPlayerName: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
    
    let seperatorView = UIView()
    
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
            var text = ""
            if let country = country {
                text = flag(country: country)
            }
            labelCountry.text = text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
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

extension PlayerCell {
    
    private func configure() {
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        seperatorView.backgroundColor = .lightGray
        contentView.addSubview(seperatorView)
        
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            seperatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            seperatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            seperatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
}
