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
    
    let refreshSubject = PublishSubject<Void>()
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialUI()
        setupRx()
        bindData()
    }
    
    func initialUI(){
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = .white
        self.view.backgroundColor = .white
        resultsTableController = ResultsTableController()
        searchController = UISearchController(searchResultsController: resultsTableController)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        // Search controller
//        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        self.extendedLayoutIncludesOpaqueBars = true
        
        
        self.tableView.refreshControl = refresh
//        refresh.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
        
    }
    
    func setupRx(){
        // Main tableview
        self.tableView.dataSource = nil
        self.tableView.delegate = nil
        restaurantViewModel.restaurants.bind(to: tableView.rx.items(cellIdentifier: BaseTableViewController.tableViewCellIdentifier, cellType: RestaurantCell.self)){ (row, restaurant, cell) in
            cell.cellRestaurant = restaurant
        }.disposed(by: disposeBag)
        
        refresh.rx.controlEvent(.valueChanged)
            .map{_ in !self.refresh.isRefreshing}
            .subscribe(onNext: { [unowned self] _ in
                self.refreshRestaurantList()
            }).disposed(by: disposeBag)
        
        refresh.rx.controlEvent(.valueChanged)
            .map{_ in self.refresh.isRefreshing}
            .subscribe(onNext: { [unowned self] _ in
                self.refresh.endRefreshing()
            }).disposed(by: disposeBag)
        
        //tableview cell selected
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Restaurant.self)).bind { (arg0) in
            let (indexPath, restaurant) = arg0
            self.tableView.deselectRow(at: indexPath, animated: true)
            let restaurantDetailVC = RestaurantDetailViewController()
            restaurantDetailVC.restaurant = restaurant
            self.navigationController?.pushViewController(restaurantDetailVC, animated: true)
        }.disposed(by: disposeBag)
        
        //Search result table cell selected
        _ = resultsTableController.restaurantSelected.subscribe(onNext: { (restaurant) in
            let restaurantDetailVC = RestaurantDetailViewController()
            restaurantDetailVC.restaurant = restaurant
            self.navigationController?.pushViewController(restaurantDetailVC, animated: true)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        //Searchbar text on change
        let searchBar:UISearchBar = searchController.searchBar
        searchBar.rx.text.orEmpty.subscribe(onNext: { (searchString) in
            self.restaurantViewModel.findMatch(searchString: searchString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    func bindData(){
        refreshRestaurantList()
    }
    
    func refreshRestaurantList(){
        restaurantViewModel.reloadData()
    }
    
    @objc func pulledToRefresh(){
        refreshRestaurantList()
    }
}
