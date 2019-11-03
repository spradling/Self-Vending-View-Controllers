//
//  TableViewProtocolling.swift
//  VendableTestApp
//
//  Created by Chris Spradling on 7/23/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit
import VendableFramework

class TableViewController: UITableViewController, SelfVendingViewController {
    
    typealias StoryboardType = MyModuleStoryboard
    typealias NibType = MyModuleNibs
    
    static var viewSource: Source? { return .storyboard(.table, id: .initial) }
    
    
    func register<C: UITableViewCell & SelfVendingCell>(_ cell: C.Type) {
        
        cell.register(to: tableView)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return TestCell.cell(for: tableView, indexPath: indexPath) {
            $0.label?.text = "HIIIIII"
        }
    }
    
    
}
