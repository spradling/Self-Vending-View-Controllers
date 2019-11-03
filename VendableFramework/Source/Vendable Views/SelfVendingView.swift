//
//  SelfVendingView.swift
//  Self-Vending ViewController Framework
//
//  Created by Chris Spradling on 7/23/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

// same deal as SelfVendingViewController: this
// protocol does the processing of key identifiers
// into a view -- this one is simpler because we
// a UIView is only ever going to come from a nib
// (not a storyboard)
public protocol SelfVendingView where Self: UIView {
    
    associatedtype NibType: NibVendor
    
    static var nibName: NibType? { get }
    
}

public extension SelfVendingView {
    
    static func view(_ configurationBlock: ((Self) -> Void)? = nil) -> Self? {
        
        guard let view = view(withOwner: nil) else { return nil }
        
        configurationBlock?(view)
        return view
        
    }
    
    static func view(withOwner owner: Any?) -> Self? {
        
        return nibName?.view(withOwner: owner)
        
    }
    
    static func view(_ idx: Int) -> Self? {
        
        return nibName?.view(withOwner: nil, index: idx)
        
    }
    
    static func viewController(_ configurationBlock: ((Self) -> Void)? = nil) -> UIViewController? {
        
        guard let view = view(configurationBlock) else { return nil }
        
        let vc = UIViewController()
        vc.view = view
        
        return vc
        
    }
    
}

