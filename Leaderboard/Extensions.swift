//
//  Extensions.swift
//  Leaderboard
//
//  Created by David Krög on 18.05.20.
//  Copyright © 2020 David Krög. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func registerCell(ofType cellType: UICollectionViewCell.Type) {
        let name = String(describing: cellType.self)
        register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
    }
    
    func dequeueTypedCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self),for: indexPath) as! T
    }
    
}
