//
//  ResultsTableController.swift
//  Find Restaurant
//
//  Created by Ray Chow on 25/7/2019.
//  Copyright © 2019 RayChow. All rights reserved.
//

import Foundation
import RxSwift

class ResultsTableController: BaseTableViewController {
    let restaurantViewModel = RestaurantViewModel.shared
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Search controller
        setupRX()
    }
    
    func setupRX(){
        // Results tableview
        tableView.delegate = nil
        tableView.dataSource = nil
        // Binding
        restaurantViewModel.filteredRestaurants.bind(to: tableView.rx.items(cellIdentifier: BaseTableViewController.tableViewCellIdentifier, cellType: RestaurantCell.self)){ (row, restaurant, cell) in
            cell.cellRestaurant = restaurant
        }.disposed(by: disposeBag)
    }
}
