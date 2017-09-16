//
//  Location.swift
//  RainyShinyCloud
//
//  Created by Asit Kumar Mohanty on 16/09/17.
//  Copyright © 2017 AONE LLC. All rights reserved.
//

import Foundation
import CoreLocation

class Location
{
    static var sharedInstance = Location()

    private init(){}
    
    var latitude:Double!
    var longitude:Double!
}
