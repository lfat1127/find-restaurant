//
//  SearchRestaurantViewController.swift
//  Find Restaurant
//
//  Created by Ray Chow on 23/7/2019.
//  Copyright © 2019 RayChow. All rights reserved.
//

import Foundation

import UIKit
import RxSwift
import RxCocoa

class SearchRestaurantViewController: BaseTableViewController {

    let restaurantViewModel = RestaurantViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isTranslucent = false
        setupRx()
        bindData()
    }
    
    func setupRx(){
        self.tableView.dataSource = nil
        self.tableView.delegate = nil
        restaurantViewModel.restaurants.bind(to: tableView.rx.items(cellIdentifier: BaseTableViewController.tableViewCellIdentifier, cellType: RestaurantCell.self)){ (row, restaurant, cell) in
            cell.cellRestaurant = restaurant
        }.disposed(by: disposeBag)
        
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Restaurant.self)).bind { (arg0) in
            let (indexPath, restaurant) = arg0
            self.tableView.deselectRow(at: indexPath, animated: true)
            let restaurantDetailVC = RestaurantDetailViewController()
            restaurantDetailVC.restaurant = restaurant
            self.navigationController?.pushViewController(restaurantDetailVC, animated: true)
        }.disposed(by: disposeBag)
    }
    
    func bindData(){
        restaurantViewModel.reloadData()
    }
}
