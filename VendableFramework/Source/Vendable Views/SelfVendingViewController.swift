//
//  SelfVendingViewController.swift
//  Self-Vending ViewController Framework
//
//  Created by Chris Spradling on 7/23/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

// Enumerated storyboards only gets us so far, and still requires a lot of
// Investigation at implementation time to know where each viewController
// lives in what storyboard. So, we should tie that knowledge to the VC itself
public protocol SelfVendingViewController where Self: UIViewController {
    
    associatedtype StoryboardType: StoryboardVendor
    associatedtype NibType: NibVendor
    
    typealias Source = ViewSourceType<StoryboardType, NibType>
    
    static var viewSource: Source? { get }
    
}

// non-overridable methods in protocol extension, keep implementation simple
public extension SelfVendingViewController {
    
    private static var viewController: Self? {
        
        switch viewSource {
            
        case .nib(let nib, _)?:
            return nib.viewController(self)
            
        case .storyboard(let board, let id)?:
            return board.viewController(self, id: id)
            
        default:
            return nil
            
        }
        
    }
    
    static func viewController(preconfigurationBlock: ((Self) -> Void)? = nil, configurationBlock: ((Self) -> Void)? = nil) -> Self? {
        guard let viewController = viewController else { return nil }
        preconfigurationBlock?(viewController)
        if let configurationBlock = configurationBlock {
            viewController.loadView()
            configurationBlock(viewController)
        }
        return viewController
    }
    
    static var viewControllerInNavigationController: UINavigationController? {
        // just a quick convenience method, we do a lot of this on-site
        // currently when instantiating view controllers
        //
        // also most of our storyboard clutter is NavControllers, it's
        // good to reinforce that we often don't really need them there
        guard let vc = viewController else { return nil }
        
        return UINavigationController(rootViewController: vc)
        
    }
    
}
