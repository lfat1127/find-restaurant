//
//  RestaurantViewModel.swift
//  Find Restaurant
//
//  Created by Ray Chow on 24/7/2019.
//  Copyright © 2019 RayChow. All rights reserved.
//

import Foundation
import RxSwift

class RestaurantViewModel{
    let isLoading = BehaviorSubject<Bool>(value: false)
    let restaurants:PublishSubject<[Restaurant]> = PublishSubject()
    
    func reloadData(){
        generateRestaurantData()
    }
    
    private func generateRestaurantData(){
        restaurants.onNext([Restaurant(title: "Aascaacskacsacsmkackcascascacscascasacsaac", district: "FANLING", address: "sacaassaascca", ""),
                            Restaurant(title: "B", district: "SHATIN", address: "asc12212e", ""),
                            Restaurant(title: "C", district: "YEUN LONG", address: "wrbverv", "")])
    }
}
