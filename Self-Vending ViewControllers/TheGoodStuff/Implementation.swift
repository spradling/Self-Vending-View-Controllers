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

class SampleViewController: UIViewController, SelfVendingViewController {
    
    class var viewSource: Source? { return nil }
    
    typealias StoryboardType = SampleStoryboard
    typealias NibType = SampleNibs
    
}

class SampleView: UIView, SelfVendingView {
    
    class var nibName: SampleNibs? { return nil }
    
    typealias NibType = SampleNibs
    
}

//
// MARK: - Individual ViewControllers Being Implemented
//
class MainStoryboardSecondViewController: SampleViewController {
    override class var viewSource: Source? { return .storyboard(.main, id: String(describing: self)) }
    
}

class AnotherStoryboardFirstViewController: SampleViewController {
    override class var viewSource: Source? { return .storyboardWhereInitial(.alt) }
    
}

class AnotherStoryboardSecondViewController: SampleViewController {
    override class var viewSource: Source? { return .storyboard(.alt, id: String(describing: self)) }
    
}

class ViewControllerWithNibView: SampleViewController {
    override class var viewSource: Source? { return Source.nib(.forVC) }
    
}

// Views
class FirstView: SampleView {
    override class var nibName: SampleNibs? { return .standalone }
    
}

class SecondView: SampleView {
    override class var nibName: SampleNibs? { return .standalone }
    

}
