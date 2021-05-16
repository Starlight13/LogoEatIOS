//
//  CustomTableViewCell.swift
//  LogoEat
//
//  Created by dsadas asdasd on 16.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var restaurantImage: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var cuisineLabel: UILabel!
    @IBOutlet var mapMarkerImage: UIImageView!
    @IBOutlet var locationLabel: UILabel!
}
