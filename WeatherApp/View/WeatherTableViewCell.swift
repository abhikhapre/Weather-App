//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Abhishek Khapare on 12/7/18.
//  Copyright © 2018 Abhishek Khapare. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
