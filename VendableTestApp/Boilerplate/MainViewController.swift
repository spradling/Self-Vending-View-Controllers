//
//  ViewController.swift
//  Self-Vending ViewControllers
//
//  Created by Christopher Spradling on 2/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit
import VendableFramework

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewControllerTypes = [
        "A second view controller from the same storyboard as this table view",
        "The initial view controller of another storyboard",
        "A second view controller from a different storyboard",
        "A view controller whose view lives in a xib",
        "The same view controller as before, whose background has been turned white via a configuration block",
        "A view (without an intrinsic vc) from a xib",
        "A second view (without an intrinsic vc) from the same xib",
        "The same view as before, whose background has been turned white via a configuration block",
        "A table view, let's see what happens"

    ]

    @IBOutlet var tableView: UITableView!
    
    func register() {
        TestCell.register(to: tableView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        register()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllerTypes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return TestCell.cell(for: tableView, indexPath: indexPath) { [weak self] in
            $0.label?.text = self?.viewControllerTypes[indexPath.row]
            $0.label?.numberOfLines = 3
        }
        
    }
    
    
}
