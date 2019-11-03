//
//  MainVC-DidSelect.swift
//  Self-Vending ViewControllers
//
//  Created by Christopher Spradling on 2/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit
import VendableFramework

extension MainViewController {
    
    // This is all it takes to spin up an arbitrary view controller now
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: UIViewController?
        
        switch indexPath.row {
        case 0:
            vc = MainStoryboardSecondViewController.viewController() {
                $0.label?.text = "This label has been set programmatically"
            }
        case 1:
            vc = AnotherStoryboardFirstViewController.viewController()
        case 2:
            vc = AnotherStoryboardSecondViewController.viewController()
        case 3:
            vc = ViewControllerWithNibView.viewController()
        case 4:
            vc = ViewControllerWithNibView.viewController() {
                $0.view.backgroundColor = .white
            }
        case 5:
            vc = FirstView.viewController()
        case 6:
            vc = SecondView.viewController()
        case 7:
            vc = SecondView.viewController() {
                $0.label?.textColor = .black
                $0.backgroundColor = .white
            }
        case 8:
            vc = TableViewController.viewController()
            (vc as? TableViewController)?.register(TestCell.self)
        default:
            return
        }
        
        guard let viewController = vc else { return }
        
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}
