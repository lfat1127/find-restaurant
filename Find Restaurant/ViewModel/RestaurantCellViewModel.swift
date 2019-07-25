//
//  RestaurantCellViewModel.swift
//  Find Restaurant
//
//  Created by Ray Chow on 24/7/2019.
//  Copyright © 2019 RayChow. All rights reserved.
//

import Foundation
import RxSwift

class RestaurantCellViewModel {
    let name:String
    let district:String
    let address:String
    let reason:String
    
    init(name:String, district:String, address:String, reason:String) {
        self.name = name
        self.district = district
        self.address = address
        self.reason = reason
    }
}
