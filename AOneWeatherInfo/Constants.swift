//
//  Constants.swift
//  RainyShinyCloud
//
//  Created by Asit Kumar Mohanty on 15/07/17.
//  Copyright © 2017 AONE LLC. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "d1deca8b01c6424c86f071d7de141780"

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=6&appid=d1deca8b01c6424c86f071d7de141780"
