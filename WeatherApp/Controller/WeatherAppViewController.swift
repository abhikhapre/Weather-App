//
//  ViewController.swift
//  WeatherApp
//
//  Created by Abhishek Khapare on 12/6/18.
//  Copyright © 2018 Abhishek Khapare. All rights reserved.
//

import UIKit
import CoreLocation

/* App Name : Weather App
 * Description : This a Weather App which shows a current weather and the weather for the next 5 days,
 *               based on user's current location
 *
 */

/* Note: Please try to run on an actual device to get the weather of the current location
 * Simulator : If running on a simulator then please use simulate location to get the location.
 * Device : It work as Expected on a device.
 * Working : On the first launch device will get it's current location and convert into zip Code and
 *           then perform a networkcall.
 */
class WeatherAppViewController: UIViewController, CLLocationManagerDelegate {
   
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshButton: UIButton!
    
    
    var weatherForecast : WeatherForecast?
    let locationManager = CLLocationManager()
    var zipCode : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
        self.title = "Weather App"
        
        
        refreshButton.layer.cornerRadius = 0.5 * refreshButton.bounds.size.width
        refreshButton.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager.startUpdatingLocation()
    }
    
    func fetchWeatherJSONData(urlString : String){
        let weatherForecastModel = WeatherForecastModel()
        weatherForecastModel.fetchWeatherData(urlString : urlString){
            (weatherForecast) in
            self.weatherForecast = weatherForecast
            DispatchQueue.main.async {
                self.cityLabel.text = weatherForecast.city.name
                self.tempLabel.text = String(Int(weatherForecast.list[0].main.temp)) + "°F"
                self.statusLabel.text = weatherForecast.list[0].weather[0].main
                self.tableView.reloadData()
            }
        }
    }
    
    //triggers when location is updated and fetches the current location(zip code)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(locations.last!, completionHandler: {(placemark, error) -> Void in
            if error == nil && placemark!.count > 0{
                self.zipCode = placemark![0].postalCode
            }
        })
        guard let zipCode = self.zipCode else { return }
        let apiUrlString = WeatherAPI.firstPart.APIUrl + "\(zipCode)" + WeatherAPI.secondPart.APIUrl
        fetchWeatherJSONData(urlString : apiUrlString)
    }
    
    @IBAction func refreshButtonClicked(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
    }
}

extension WeatherAppViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherDayCell", for: indexPath) as! WeatherTableViewCell
        guard let weatherForeCast = self.weatherForecast else { return cell }
        cell.dayLabel.text = "Day \(indexPath.row + 1)"
        cell.tempLabel.text = String(Int(weatherForeCast.list[indexPath.row].main.temp)) + "°F"
        cell.statusLabel.text = weatherForeCast.list[indexPath.row].weather[0].main
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherForecast?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 87
    }
}

