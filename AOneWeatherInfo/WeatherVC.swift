//
//  WeatherVC.swift
//  RainyShinyCloud
//
//  Created by Asit Kumar Mohanty on 09/07/17.
//  Copyright © 2017 AONE LLC. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var currentWeatherImgView: UIImageView!
    @IBOutlet weak var currentWeatherTypeLbl: UILabel!
    @IBOutlet weak var weatherListTableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation:CLLocation!
    
    var currentWeather = CurrentWeather()
    var forecast = Forecast(weatherDict: Dictionary<String, AnyObject>())
    
    var forecastsArr = [Forecast]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
        
        currentWeather.downloadWeatherDetails {
            self.downloadForecastData {
                print("Done Fetching info")
                self.updateTopMainUI()
            }
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete)
    {
        let forecastURL = URL(string: FORECAST_URL)!
        
        Alamofire.request(forecastURL).responseJSON { response in
            
            let result = response.result
            
            if let responseDict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = responseDict["list"] as? [Dictionary<String, AnyObject>]
                {
                    for forecastObj in list {
                        let forecast = Forecast(weatherDict: forecastObj)
                        self.forecastsArr.append(forecast)
                    }
                    
                    self.forecastsArr.remove(at: 0)
                    self.weatherListTableView.reloadData()
                }
            }
            
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherDescCell", for: indexPath) as? WeatherCell
        {
            let forecast = forecastsArr[indexPath.row]
            cell.configureCell(forecast: forecast)
            
            return cell
        }
        else
        {
            return WeatherCell()
        }
    }
    
    func updateTopMainUI()
    {
        dateLbl.text = currentWeather.date
        currentTempLbl.text = "35.0°"//"\(currentWeather.currentTemp)°"
        cityLbl.text = currentWeather.cityName
        currentWeatherTypeLbl.text = currentWeather.weatherType
        
        if UIImage(named: currentWeather.weatherType) == nil
        {
            currentWeatherImgView.image = UIImage(named: "Clouds")
        }
        else
        {
            currentWeatherImgView.image = UIImage(named: currentWeather.weatherType)
        }
    }
    
    func locationAuthStatus()
    {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse
        {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
        }
        else
        {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
}

