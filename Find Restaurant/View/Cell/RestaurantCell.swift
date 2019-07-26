//
//  RestaurantCell.swift
//  Find Restaurant
//
//  Created by Ray Chow on 23/7/2019.
//  Copyright © 2019 RayChow. All rights reserved.
//

import Foundation
import UIKit

class RestaurantCell: UITableViewCell {
    // MARK: - Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Sample text"
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Sample text"
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    
    public var cellRestaurant : Restaurant! {
        didSet {
            self.titleLabel.text = cellRestaurant.name
            self.detailLabel.text = cellRestaurant.district
        }
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .default
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        
        contentView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: detailLabel.leadingAnchor, constant: -8).isActive = true
        detailLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
