//
//  Forecast.swift
//  RainyShinyCloud
//
//  Created by Asit Kumar Mohanty on 15/07/17.
//  Copyright © 2017 AONE LLC. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        
        return _lowTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>)
    {
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject>
        {
            if let min = temp["min"] as? Double
            {
                let tempCelciusVal = min - 273.15
                self._lowTemp = "\(tempCelciusVal)"
            }
            
            if let max = temp["max"] as? Double
            {
                let tempCelciusVal = max - 273.15
                self._highTemp = "\(tempCelciusVal)"
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>]
        {
            if let wType = weather[0]["main"] as? String
            {
                self._weatherType = wType
            }
        }
        
        if let dt = weatherDict["dt"] as? Double
        {
            let unixConvertedDate = Date(timeIntervalSince1970: dt)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
        
}
}
