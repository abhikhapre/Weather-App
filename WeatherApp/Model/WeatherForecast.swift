//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Abhishek Khapare on 12/6/18.
//  Copyright © 2018 Abhishek Khapare. All rights reserved.
//

import Foundation

struct WeatherForecast : Decodable {
    let list : [Forecast]
    let city : City    
}

struct Forecast: Decodable {
    let main: Main
    let weather: [Weather]
    let clouds : Cloud
}

struct Cloud : Decodable {
    let all : Int
}

struct Weather: Decodable {
    let main: String
    let description: String
}

struct Main: Decodable {
    let temp: Double
}

struct City: Decodable {
    let name: String
}
