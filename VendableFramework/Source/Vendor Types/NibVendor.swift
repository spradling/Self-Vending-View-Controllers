//
//  NibVendor.swift
//  Self-Vending ViewController Framework
//
//  Created by Chris Spradling on 7/23/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

public protocol NibVendor: ViewVendor {}

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

