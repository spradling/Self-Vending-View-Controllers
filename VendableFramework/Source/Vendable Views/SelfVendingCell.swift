//
//  SelfVendingCell.swift
//  Self-Vending ViewControllers
//
//  Created by Christopher Spradling on 2/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

public protocol SelfVendingCell: SelfVendingView {
    
    static var identifier: String { get }
    
}

public extension SelfVendingCell {
    
    static var identifier: String { return String(describing: Self.self) }
    
    internal static func castAndConfigure(cell: UIView, with configurationBlock: ((Self) -> Void)?) -> Self {
        
        guard let typedCell = cell as? Self else {
            fatalError("Failed to dequeue cell of type '\(Self.self)' with identifier '\(identifier)'. Got cell of type '\(cell.self)' instead")
        }
        
        configurationBlock?(typedCell)
        return typedCell

    }
    
}

public extension SelfVendingCell where Self: UICollectionViewCell {
    
    static func cell(for collectionView: UICollectionView, indexPath: IndexPath, _ configurationBlock: ((Self) -> Void)? = nil) -> Self {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        return castAndConfigure(cell: cell, with: configurationBlock)
        
    }

    static func register(to collectionView: UICollectionView) {
        
        collectionView.register(nibName?.nib, forCellWithReuseIdentifier: identifier)
        
    }
    
}

public extension SelfVendingCell where Self: UITableViewCell {
    
    static func cell(for tableView: UITableView, indexPath: IndexPath, _ configurationBlock: ((Self) -> Void)? = nil) -> Self {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        return castAndConfigure(cell: cell, with: configurationBlock)
        
    }
    
    static func register(to tableView: UITableView) {
        
        tableView.register(nibName?.nib, forCellReuseIdentifier: identifier)
        
    }
    
}
