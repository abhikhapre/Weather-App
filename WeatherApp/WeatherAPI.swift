//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Abhishek Khapare on 12/7/18.
//  Copyright © 2018 Abhishek Khapare. All rights reserved.
//

import Foundation

enum WeatherAPI {
    case firstPart
    case secondPart
    
    var APIUrl : String {
        switch self {
        case .firstPart : return "https://api.openweathermap.org/data/2.5/forecast?zip="
        case .secondPart : return ",us&cnt=5&units=imperial&APPID=840ab7c7c2826db13aef6cfe23ba6bc6"
        }
    }
}
