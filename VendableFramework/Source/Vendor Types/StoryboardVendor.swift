//
//  StoryboardVendor.swift
//  Self-Vending ViewController Framework
//
//  Created by Chris Spradling on 7/23/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

// to be shared, all modules can implement their own enumerated storyboards
// but should all offer the below functionality for them
public protocol StoryboardVendor: ViewVendor {}

extension StoryboardVendor {
    
    var storyboard: UIStoryboard {
        
        return UIStoryboard(name: rawValue, bundle: bundle)
        
    }
    
    func initial<T: UIViewController>(_ type: T.Type) -> T? {
        
        return storyboard.instantiateInitialViewController() as? T
        
    }
    
    func viewController<T: UIViewController>(_ type: T.Type, id: ViewSourceIdentifier? = nil) -> T? {
        
        switch id {
            
        case .initial?:
            return storyboard.instantiateInitialViewController() as? T
            
        case .id(let identifier)?:
            return storyboard.instantiateViewController(withIdentifier: identifier) as? T
            
        case .nameOfSelf?:
            return storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as? T
        default:
            return nil
            
        }
        
    }
    
}
