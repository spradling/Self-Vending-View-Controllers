//
//  ModuleLevelSetup.swift
//  Self-Vending ViewControllers
//
//  Created by Chris Spradling on 7/23/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit
import VendableFramework

typealias MyModuleViewController    = UIViewController  & MyModuleViewControllerProtocol
typealias MyModuleView              = UIView            & MyModuleViewProtocol
typealias MyModuleTableCell         = UITableViewCell   & MyModuleCellProtocol

//
// MARK: - Module-level Implementation
//
enum MyModuleStoryboard: String, StoryboardVendor {
    
    case main = "Main"
    case alt = "AnotherStoryboard"
    case table = "TableViewStoryboard"
    
}

enum MyModuleNibs: String, NibVendor {
    
    case forVC = "AViewControllersNib"
    case standalone = "StandaloneNibs"
    
}

enum MyModuleCells: String, NibVendor {
    
    case testCell = "TestCell"
    
}

// Credit to Ted Rothrock for pointing out that you can fulfill associatedType requirements with a where clause in a subprotocol
protocol MyModuleViewControllerProtocol: SelfVendingViewController where StoryboardType == MyModuleStoryboard, NibType == MyModuleNibs {}
protocol MyModuleViewProtocol: SelfVendingView where NibType == MyModuleNibs {}
protocol MyModuleCellProtocol: SelfVendingCell where NibType == MyModuleCells {}
