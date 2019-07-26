//
//  Restaurant.swift
//  Find Restaurant
//
//  Created by Ray Chow on 23/7/2019.
//  Copyright © 2019 RayChow. All rights reserved.
//

import Foundation

class Restaurant: NSObject, NSCoding, Codable{
    
    // MARK: - Types
    
    private enum CoderKeys: String {
        case name
        case district
        case address
        case reason
    }
    
    // MARK: - Properties
    
    /** These properties need @objc to make them key value compliant when filtering using NSPredicate,
     and so they are accessible and usable in Objective-C to interact with other frameworks.
     */
    @objc let name: String
    @objc let district: String
    @objc let address: String
    @objc let reason: String
    
    // MARK: - Initializers
    
    init(name: String, district: String, address: String, _ reason:String = "") {
        self.name = name
        self.district = district
        self.address = address
        self.reason = reason
    }
    
    // MARK: - NSCoding
    
    /// This is called for UIStateRestoration
    required init?(coder aDecoder: NSCoder) {
        guard let decodedTitle = aDecoder.decodeObject(forKey: CoderKeys.name.rawValue) as? String else {
            fatalError("A title did not exist. In your app, handle this gracefully.")
        }
        name = decodedTitle
        district = aDecoder.decodeObject(forKey: CoderKeys.district.rawValue) as? String ?? ""
        address = aDecoder.decodeObject(forKey: CoderKeys.address.rawValue) as? String ?? ""
        reason = aDecoder.decodeObject(forKey: CoderKeys.reason.rawValue) as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: CoderKeys.name.rawValue)
        aCoder.encode(district, forKey: CoderKeys.district.rawValue)
        aCoder.encode(address, forKey: CoderKeys.address.rawValue)
        aCoder.encode(reason, forKey: CoderKeys.reason.rawValue)
    }
    
}
