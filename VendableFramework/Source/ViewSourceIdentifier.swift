//
//  ViewSourceIdentifier.swift
//  Self-Vending ViewController Framework
//
//  Created by Chris Spradling on 7/23/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

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
public enum ViewSourceIdentifier {
    
    case id(String)
    case initial
    case nameOfSelf
    
}

public enum ViewSourceType<S: StoryboardVendor, N: NibVendor> {
    
    case storyboard(S, id: ViewSourceIdentifier)
    case nib(N, index: Int)
    
    public static func storyboard(_ board: S) -> ViewSourceType {
        
        return .storyboard(board, id: .nameOfSelf)
        
    }
    
    public static func nib(_ name: N) -> ViewSourceType {
        
        return .nib(name, index: 0)
        
    }
    
}


public struct ViewSource<S: ViewVendor> {
    
    let source: S
    let id: ViewSourceIdentifier
    
    public init(_ source: S, _ id: ViewSourceIdentifier) {
        self.source = source
        self.id = id
    }
    
}
