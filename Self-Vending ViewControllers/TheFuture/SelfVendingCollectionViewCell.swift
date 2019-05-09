//
//  SelfVendingCollectionViewCell.swift
//  Self-Vending ViewControllers
//
//  Created by Christopher Spradling on 2/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit


protocol SelfVendingCollectionViewCell: SelfVendingView {
    
    static var identifier: String { get }
    
}

extension SelfVendingCollectionViewCell where Self: UICollectionViewCell {
    
    static var identifier: String { return String(describing: Self.self) }
    
    static func cell(for collectionView: UICollectionView, indexPath: IndexPath) -> Self? {
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Self
        
    }
    
    static func register(to collectionView: UICollectionView) {
        
        collectionView.register(nibName?.nib, forCellWithReuseIdentifier: identifier)
        
    }
    
}


protocol SelfVendingTableViewCell: SelfVendingView {
    
    static var identifier: String { get }
}

extension SelfVendingTableViewCell where Self: UITableViewCell {
    
    static var identifier: String { return String(describing: Self.self) }
    
    static func cell(for tableView: UITableView, indexPath: IndexPath) -> Self? {
        
        return (tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Self) ?? Self()
        
        
        
    }
}
