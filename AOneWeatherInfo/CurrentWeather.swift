//
//  CurrentWeather.swift
//  RainyShinyCloud
//
//  Created by Asit Kumar Mohanty on 15/07/17.
//  Copyright © 2017 AONE LLC. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather{
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String{
        if _cityName == nil{
            _cityName = ""
        }
        
        return _cityName
    }
    
    var date: String{
        if _date == nil{
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        _date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double{
        if _currentTemp == nil{
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete)
    {
        // Alamofire 
        
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        
        Alamofire.request(currentWeatherURL).responseJSON { response in
            
            let result = response.result
            print(result)
            
            if let responseDict = result.value as? Dictionary<String,AnyObject>
            {
                if let name = responseDict["name"] as? String
                {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                
                if let weather = responseDict["weather"] as? [Dictionary<String,AnyObject>]
                {
                    if let main = weather[0]["main"] as? String
                    {
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                }
                
                if let main = responseDict["main"] as? Dictionary<String, AnyObject>
                {
                    if let curTemp = main["temp"] as? Double
                    {
                        let tempCelciusVal = curTemp - 273.15
                        self._currentTemp = round(tempCelciusVal)
                        print(self._currentTemp)
                    }
                }
            }
            
            completed()
        }
    }
}
