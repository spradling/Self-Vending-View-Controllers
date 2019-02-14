//
//  MainVC-DidSelect.swift
//  Self-Vending ViewControllers
//
//  Created by Christopher Spradling on 2/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

extension MainViewController {
    
    // This is all it takes to spin up an arbitrary view controller now
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: UIViewController?
        
        switch indexPath.row {
        case 0:
            vc = MainStoryboardSecondViewController.viewController
        case 1:
            vc = AnotherStoryboardFirstViewController.viewController
        case 2:
            vc = AnotherStoryboardSecondViewController.viewController
        case 3:
            vc = ViewControllerWithNibView.viewController
        case 4:
            vc = FirstView.viewInViewController
        case 5:
            vc = SecondView.viewInViewController
            
        default:
            return
        }
        
        guard let viewController = vc else { return }
        
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}
