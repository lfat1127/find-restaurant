//
//  BaseTableViewController.swift
//  Find Restaurant
//
//  Created by Ray Chow on 23/7/2019.
//  Copyright © 2019 RayChow. All rights reserved.
//

import Foundation
import UIKit

class BaseTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var filteredProducts = [Restaurant]()
    private var numberFormatter = NumberFormatter()
    
    // MARK: - Constants
    
    static let tableViewCellIdentifier = "cellID"
    private static let nibName = "TableCell"
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44
        numberFormatter.numberStyle = .currency
        numberFormatter.formatterBehavior = .default
        
        // Required if our subclasses are to use `dequeueReusableCellWithIdentifier(_:forIndexPath:)`.
        tableView.register(RestaurantCell.self, forCellReuseIdentifier: BaseTableViewController.tableViewCellIdentifier)
    }
    
    // MARK: - Configuration
    
    func configureCell(_ cell: RestaurantCell, forProduct restaurant: Restaurant) {
        
        cell.titleLabel.text = restaurant.title
        
        /** Build the price and year string.
         Use NSNumberFormatter to get the currency format out of this NSNumber (product.introPrice).
         */
        cell.detailLabel.text = restaurant.district
    }
}
