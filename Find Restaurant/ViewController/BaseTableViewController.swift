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
    
    var filteredRestaurants = [Restaurant]()
    
    // MARK: - Constants
    
    static let tableViewCellIdentifier = "cellID"
    private static let nibName = "TableCell"
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44
        
        // Required if our subclasses are to use `dequeueReusableCellWithIdentifier(_:forIndexPath:)`.
        tableView.register(RestaurantCell.self, forCellReuseIdentifier: BaseTableViewController.tableViewCellIdentifier)
    }
    
    // MARK: - Configuration
    
    func configureCell(_ cell: RestaurantCell, forProduct restaurant: Restaurant) {
        cell.titleLabel.text = restaurant.title
        cell.detailLabel.text = restaurant.district
    }
}
