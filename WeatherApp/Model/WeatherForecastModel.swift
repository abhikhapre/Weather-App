//
//  WeatherForecastModel.swift
//  WeatherApp
//
//  Created by Abhishek Khapare on 12/6/18.
//  Copyright © 2018 Abhishek Khapare. All rights reserved.
//

import Foundation

class WeatherForecastModel : NSObject {
    var weatherForecast : WeatherForecast?
    func fetchWeatherData(urlString : String, WeatherData:@escaping(WeatherForecast)->Void){
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            do{
                self.weatherForecast = try JSONDecoder().decode(WeatherForecast.self, from: data)
                
            }catch let jsonError{
                print("Error : ", jsonError)
            }
            
            guard let weatherForecast = self.weatherForecast else { return }
            WeatherData(weatherForecast)
            
            }.resume()
    }
}
