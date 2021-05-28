//
//  CustomTableViewCell.swift
//  LogoEat
//
//  Created by dsadas asdasd on 16.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet var restaurantImage: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var cuisineLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        contentView.backgroundColor = .white
    }
    
    func configure(with restaurant: Restaurant) {
        self.restaurantImage.image = UIImage(data: restaurant.image!)
        self.restaurantImage.layer.cornerRadius = 10
        self.restaurantImage.clipsToBounds = true
        
        self.nameLabel.text = restaurant.name
        self.nameLabel.font = UIFont(name: "OpenSans-SemiBold", size: 18)
        
        self.ratingLabel.text = String(restaurant.rating)
        
        switch restaurant.rating {
        case 0..<5:
            self.ratingLabel.backgroundColor = UIColor(red: 0.878, green: 0.478, blue: 0.373, alpha: 1)
        default:
            self.ratingLabel.backgroundColor = UIColor(red: 0.239, green: 0.251, blue: 0.357, alpha: 1)
        }
        self.ratingLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.ratingLabel.layer.cornerRadius = 3
        self.ratingLabel.layer.masksToBounds = true
        
        self.cuisineLabel.text = restaurant.cuisine
        self.locationLabel.text = restaurant.location
    }
}
