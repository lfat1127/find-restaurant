//
//  RestaurantDetailViewController.swift
//  Find Restaurant
//
//  Created by Ray Chow on 24/7/2019.
//  Copyright © 2019 RayChow. All rights reserved.
//

import Foundation
import UIKit

class RestaurantDetailViewController: UIViewController {
    let districtLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    let addressLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    let reasonLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    var restaurant:Restaurant!{
        didSet{
            self.title = restaurant.name
            districtLabel.text = restaurant.district
            addressLabel.text = restaurant.address
            reasonLabel.text = restaurant.reason
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        initialUI()
    }
    
    func initialUI(){
        self.view.backgroundColor = .white
        
        view.addSubview(districtLabel)
        districtLabel.translatesAutoresizingMaskIntoConstraints = false
        districtLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        districtLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        districtLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
        view.addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.topAnchor.constraint(equalTo: districtLabel.bottomAnchor, constant: 8).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
        view.addSubview(reasonLabel)
        reasonLabel.translatesAutoresizingMaskIntoConstraints = false
        reasonLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8).isActive = true
        reasonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        reasonLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
}
