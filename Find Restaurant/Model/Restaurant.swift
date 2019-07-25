//
//  Restaurant.swift
//  Find Restaurant
//
//  Created by Ray Chow on 23/7/2019.
//  Copyright © 2019 RayChow. All rights reserved.
//

import Foundation

class Restaurant: NSObject, NSCoding {
    
    // MARK: - Types
    
    private enum CoderKeys: String {
        case nameKey
        case districtKey
        case addressKey
        case reasonKey
    }
    
    // MARK: - Properties
    
    /** These properties need @objc to make them key value compliant when filtering using NSPredicate,
     and so they are accessible and usable in Objective-C to interact with other frameworks.
     */
    @objc let title: String
    @objc let district: String
    @objc let address: String
    @objc let reason: String
    
    // MARK: - Initializers
    
    init(title: String, district: String, address: String, _ reason:String = "") {
        self.title = title
        self.district = district
        self.address = address
        self.reason = reason
    }
    
    // MARK: - NSCoding
    
    /// This is called for UIStateRestoration
    required init?(coder aDecoder: NSCoder) {
        guard let decodedTitle = aDecoder.decodeObject(forKey: CoderKeys.nameKey.rawValue) as? String else {
            fatalError("A title did not exist. In your app, handle this gracefully.")
        }
        title = decodedTitle
        district = aDecoder.decodeObject(forKey: CoderKeys.districtKey.rawValue) as? String ?? ""
        address = aDecoder.decodeObject(forKey: CoderKeys.addressKey.rawValue) as? String ?? ""
        reason = aDecoder.decodeObject(forKey: CoderKeys.reasonKey.rawValue) as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: CoderKeys.nameKey.rawValue)
        aCoder.encode(district, forKey: CoderKeys.districtKey.rawValue)
        aCoder.encode(address, forKey: CoderKeys.addressKey.rawValue)
        aCoder.encode(reason, forKey: CoderKeys.reasonKey.rawValue)
    }
    
}
