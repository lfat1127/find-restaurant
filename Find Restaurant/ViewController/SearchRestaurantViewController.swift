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
    /// Search controller to help us with filtering.
    private var searchController: UISearchController!
    /// Secondary search results table view.
    private var resultsTableController: ResultsTableController!
    let restaurantViewModel = RestaurantViewModel.shared
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isTranslucent = false
        initialUI()
        setupRx()
        bindData()
    }
    
    func initialUI(){
        resultsTableController = ResultsTableController()
        searchController = UISearchController(searchResultsController: resultsTableController)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        // Search controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
    }
    
    func setupRx(){
        // Main tableview
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
        
        // Cell selected
        Observable.zip(resultsTableController.tableView.rx.itemSelected, resultsTableController.tableView.rx.modelSelected(Restaurant.self)).bind{ (arg0) in
            let (indexPath, restaurant) = arg0
            self.resultsTableController.tableView.deselectRow(at: indexPath, animated: true)
            let restaurantDetailVC = RestaurantDetailViewController()
            restaurantDetailVC.restaurant = restaurant
            self.navigationController?.pushViewController(restaurantDetailVC, animated: true)
            }.disposed(by: disposeBag)
    }
    
    func bindData(){
        restaurantViewModel.reloadData()
    }
}

// MARK: - UISearchResultsUpdating

extension SearchRestaurantViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text{
            restaurantViewModel.findMatch(searchString: searchString)
        }
    }
}
