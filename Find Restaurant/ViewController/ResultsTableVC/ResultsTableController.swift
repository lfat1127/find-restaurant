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
    let restaurantSelected = PublishSubject<Restaurant>()
    
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
        
        // Cell selected
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Restaurant.self)).bind{ (arg0) in
            let (indexPath, restaurant) = arg0
            self.tableView.deselectRow(at: indexPath, animated: true)
            self.restaurantSelected.onNext(restaurant)
            }.disposed(by: disposeBag)
    }
}
