//
//  ViewVendor.swift
//  Self-Vending ViewController Framework
//
//  Created by Chris Spradling on 7/23/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

public protocol ViewVendor: RawRepresentable where RawValue == String {
    
    var bundle: Bundle? { get }
    
}

public extension ViewVendor {
    
    var bundle: Bundle? { return nil }
    
}
