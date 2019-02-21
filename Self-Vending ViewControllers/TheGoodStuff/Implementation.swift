//
//  Implementation.swift
//  Self-Vending ViewControllers
//
//  Created by Christopher Spradling on 2/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit


//
// MARK: - Module-level Implementation
//
enum MyModuleStoryboard: String, StoryboardVendor {
    
    case main = "Main"
    case alt = "AnotherStoryboard"
    
    var bundle: Bundle? {
        return Bundle(for: MainViewController.self)
    }
    
}

enum MyModuleNibs: String, NibVendor {
    
    case forVC = "AViewControllersNib"
    case standalone = "StandaloneNibs"
    
    var bundle: Bundle? {
        return Bundle(for: MainViewController.self)
    }
    
}

// Credit to Ted Rothrock for pointing out that you can fulfill associatedType requirements with a where clause in a subprotocol
protocol MyModuleViewControllerProtocol: SelfVendingViewController where StoryboardType == MyModuleStoryboard, NibType == MyModuleNibs {}
protocol MyModuleViewProtocol: SelfVendingView where NibType == MyModuleNibs {}

typealias MyModuleViewController = UIViewController & MyModuleViewControllerProtocol
typealias MyModuleView = UIView & SelfVendingView


//
// MARK: - Individual ViewControllers Being Implemented
//
final class MainStoryboardSecondViewController: MyModuleViewController {
    class var viewSource: Source? { return .storyboard(.main) }
    
}

final class AnotherStoryboardFirstViewController: MyModuleViewController {
    class var viewSource: Source? { return .storyboardWhereInitial(.alt) }
    
}

final class AnotherStoryboardSecondViewController: MyModuleViewController {
     class var viewSource: Source? { return .storyboard(.alt) }
    
}

final class ViewControllerWithNibView: MyModuleViewController {
    class var viewSource: Source? { return Source.nib(.forVC) }
    
}

// Views
class FirstView: MyModuleView {
    class var nibName: MyModuleNibs? { return .standalone }
    
}

class SecondView: MyModuleView {
    class var nibName: MyModuleNibs? { return .standalone }
    
}
