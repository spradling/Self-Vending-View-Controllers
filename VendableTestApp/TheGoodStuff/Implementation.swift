//
//  Implementation.swift
//  Self-Vending ViewControllers
//
//  Created by Christopher Spradling on 2/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

//
// MARK: - Individual ViewControllers Being Implemented
//
final class MainStoryboardSecondViewController: MyModuleViewController {
    
    @IBOutlet var label: UILabel?
    class var viewSource: Source? { return .storyboard(.main) }
    
}
// TODO: Somehow, between the above VC and the following VCs the implicit typealiasing for StoryboardType and NibType broke. WHY.
final class AnotherStoryboardFirstViewController: MyModuleViewController {
    
    typealias StoryboardType = MyModuleStoryboard
    typealias NibType = MyModuleNibs
    
    class var viewSource: Source? { return .storyboard(.alt, id: .initial) }
    
}

final class AnotherStoryboardSecondViewController: MyModuleViewController {
    
    typealias StoryboardType = MyModuleStoryboard
    typealias NibType = MyModuleNibs
    
    class var viewSource: Source? { return .storyboard(.alt) }
    
}

final class ViewControllerWithNibView: MyModuleViewController {
    
    typealias StoryboardType = MyModuleStoryboard
    typealias NibType = MyModuleNibs
    
    class var viewSource: Source? { return Source.nib(.forVC) }
    
}

//
// MARK: - Individual Views Being Implemented
//
class FirstView: MyModuleView {
    
    class var nibName: MyModuleNibs? { return .standalone }
    
}

class SecondView: MyModuleView {
    
    @IBOutlet var label: UILabel?
    class var nibName: MyModuleNibs? { return .standalone }
    
}

//
// MARK: - Individual Cells Being Implemented
//
class TestCell: MyModuleTableCell {
    
    @IBOutlet var label: UILabel?
    class var nibName: MyModuleCells? { return .testCell }

}
