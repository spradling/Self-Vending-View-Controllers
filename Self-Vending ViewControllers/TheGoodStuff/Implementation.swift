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
enum SampleStoryboard: String, StoryboardVendor {
    
    case main = "Main"
    case alt = "AnotherStoryboard"
    
    var bundle: Bundle? {
        return Bundle(for: MainViewController.self)
    }
    
}

enum SampleNibs: String, NibVendor {
    
    case forVC = "AViewControllersNib"
    case standalone = "StandaloneNibs"
    
    var bundle: Bundle? {
        return Bundle(for: MainViewController.self)
    }
    
}

// Credit to Ted Rothrock for pointing out that you can fulfill associatedType requirements with a where clause in a subprotocol
protocol SampleViewControllerProtocol: SelfVendingViewController where StoryboardType == SampleStoryboard, NibType == SampleNibs {}
protocol SampleViewProtocol: SelfVendingView where NibType == SampleNibs {}

typealias SampleViewController = UIViewController & SampleViewControllerProtocol
typealias SampleView = UIView & SelfVendingView


//
// MARK: - Individual ViewControllers Being Implemented
//
class MainStoryboardSecondViewController: SampleViewController {
    class var viewSource: Source? { return .storyboard(.main, id: String(describing: self)) }
    
}

class AnotherStoryboardFirstViewController: SampleViewController {
    class var viewSource: Source? { return .storyboardWhereInitial(.alt) }
    
}

class AnotherStoryboardSecondViewController: SampleViewController {
     class var viewSource: Source? { return .storyboard(.alt, id: String(describing: self)) }
    
}

class ViewControllerWithNibView: SampleViewController {
    class var viewSource: Source? { return Source.nib(.forVC) }
    
}

// Views
class FirstView: SampleView {
    class var nibName: SampleNibs? { return .standalone }
    
}

class SecondView: SampleView {
    class var nibName: SampleNibs? { return .standalone }
    

}
