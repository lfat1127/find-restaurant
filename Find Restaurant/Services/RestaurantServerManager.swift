//
//  HttpRequestManager.swift
//  Find Restaurant
//
//  Created by Ray Chow on 26/7/2019.
//  Copyright © 2019 RayChow. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class RestaurantServerManager {
    static let shared = RestaurantServerManager()
    let restaurantList:PublishSubject<Data> = PublishSubject()
    
    func requestRestaurantList() {
        Alamofire.request("http://10.10.10.26:4433/api/restaurant").responseJSON { response in
            if response.result.isSuccess{
                if let data = response.data{
                    self.restaurantList.onNext(data)
                }
            }else{
                if let error = response.result.error{
                    self.restaurantList.onError(error)
                }else{
                    let unknownerror = NSError(domain: "requestRestaurantList", code: -999, userInfo: nil)
                 self.restaurantList.onError(unknownerror)
                }
            }
        }
    }
}
