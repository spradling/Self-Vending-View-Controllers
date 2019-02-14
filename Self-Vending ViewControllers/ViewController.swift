//
//  ViewController.swift
//  Self-Vending ViewControllers
//
//  Created by Christopher Spradling on 2/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewControllerTypes = [
        "A second view controller from the same storyboard as this table view",
        "The initial view controller of another storyboard",
        "A second view controller from a different storyboard",
        "A view controller whose view lives in a xib",
        "A view (without an intrinsic vc) from a xib",
        "A second view (without an intrinsic vc) from the same xib"
    ]

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllerTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewControllerTypes[indexPath.row]
        cell.textLabel?.numberOfLines = 2
        return cell
        
    }
    
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
        
        guard let viewController = vc else {
            whoopsie()
            return
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func whoopsie() {
        let alert = UIAlertController(title: "Something broke", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "oh well", style: .default, handler: nil))
        present(alert, animated: true)
    }

}
