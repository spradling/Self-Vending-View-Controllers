//
//  SelfVendingProtocol.swift
//  Self-Vending ViewControllers
//
//  Created by Christopher Spradling on 2/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

// to be shared, all modules can implement their own enumerated storyboards
// but should all offer the below functionality for them
protocol StoryboardVendor: RawRepresentable where RawValue == String {
    
    var bundle: Bundle? { get }
    
}

extension StoryboardVendor {
    
    var storyboard: UIStoryboard {
        
        return UIStoryboard(name: rawValue, bundle: bundle)
        
    }
    
    func initial<T: UIViewController>(_ type: T.Type) -> T? {
        
        return storyboard.instantiateInitialViewController() as? T
        
    }
    
    func viewController<T: UIViewController>(_ type: T.Type, id: String? = nil) -> T? {
        
        return storyboard.instantiateViewController(withIdentifier: id ?? String(describing: T.self)) as? T
        
    }
    
}

protocol NibVendor: RawRepresentable where RawValue == String {
    
    var bundle: Bundle? { get }
    
}

extension NibVendor {
    
    func viewController<T: UIViewController>(_ type: T.Type) -> T? {
        
        return T(nibName: rawValue, bundle: bundle)
        
    }
    
    var nib: UINib {
        
        return UINib(nibName: rawValue, bundle: bundle)
        
    }
    
    func views<T: UIView>(withOwner: Any?) -> [T]? {
        
        return nib.instantiate(withOwner: withOwner).filter({ ($0 as? T) != nil }) as? [T]
        
    }
    
    func view<T: UIView>(withOwner: Any?, index: Int? = nil) -> T? {
        
        guard let allViews: [T] = views(withOwner: withOwner) else {
            return nil
        }
        
        let idx = max(min(index ?? 0, allViews.count), 0)
        return allViews[idx]
                
    }
    
}


// This is meant to clear up ambiguity between VCs that
// live in storyboards and those that are loaded from
// nibs. Without an enum, all VCs would have to provide
// both a storyboard ID and a xib ID, one of which
// would be invalid.
//
// This could be improved by adding capability for a
// simpler implementation of SelfVendingViewController,
// for those modules in which ViewControllers will always
// only come from storyboards, or always only xibs.
enum ViewSourceType<S: StoryboardVendor, N: NibVendor> {
    
    case storyboard(S, id: String?)
    case storyboardWhereInitial(S)
    case nib(N)
    
    static func storyboard(_ board: S) -> ViewSourceType {
        return .storyboard(board, id: nil)
    }
    
}

// Enumerated storyboards only gets us so far, and still requires a lot of
// Investigation at implementation time to know where each viewController
// lives in what storyboard. So, we should tie that knowledge to the VC itself
protocol SelfVendingViewController where Self: UIViewController {
    
    associatedtype StoryboardType: StoryboardVendor
    associatedtype NibType: NibVendor
    
    typealias Source = ViewSourceType<StoryboardType, NibType>
    
    static var viewSource: Source? { get }
    
}

// non-overridable methods in protocol extension, keep implementation simple
extension SelfVendingViewController {
    
    static var viewController: Self? {
        
        switch viewSource {
            
        case .nib(let nib)?:
            return nib.viewController(self)
            
        case .storyboardWhereInitial(let board)?:
            return board.initial(self)
            
        case .storyboard(let board, let id)?:
            return board.viewController(self, id: id)
            
        default:
            return nil
            
        }
        
    }
    
    static var viewControllerInNavigationController: UINavigationController? {
        // just a quick convenience method, we do a lot of this on-site
        // currently when instantiating view controllers
        //
        // also most of our storyboard clutter is NavControllers, it's
        // good to reinforce that we often don't really need them there
        guard let vc = viewController else {
            return nil
        }
        
        return UINavigationController(rootViewController: vc)
        
    }
    
}


// same deal as SelfVendingViewController: this
// protocol does the processing of key identifiers
// into a view -- this one is simpler because we
// a UIView is only ever going to come from a nib
// (not a storyboard)
protocol SelfVendingView where Self: UIView {
    
    associatedtype NibType: NibVendor
    
    static var nibName: NibType? { get }
    
}

extension SelfVendingView {
    
    static var view: Self? {
        
        return view(withOwner: nil)
        
    }
    
    static func view(withOwner owner: Any?) -> Self? {
        
        return nibName?.view(withOwner: owner)
        
    }
    
    static func view(_ idx: Int) -> Self? {
        
        return nibName?.view(withOwner: nil, index: idx)
        
    }
    
    static var viewInViewController: UIViewController? {
        
        guard let view = view else {
            return nil
        }
        
        let vc = UIViewController()
        vc.view = view
        return vc
        
    }
    
}

