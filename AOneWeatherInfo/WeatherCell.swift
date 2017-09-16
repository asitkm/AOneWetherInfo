//
//  WeatherCell.swift
//  RainyShinyCloud
//
//  Created by Asit Kumar Mohanty on 24/07/17.
//  Copyright © 2017 AONE LLC. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherTypeImgView: UIImageView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(forecast:Forecast)
    {
        minTempLbl.text = "\(forecast.lowTemp)°"
        maxTempLbl.text = "\(forecast.highTemp)°"
        weatherTypeLbl.text = forecast.weatherType
        dayLbl.text = forecast.date
        
        if UIImage(named: forecast.weatherType) == nil
        {
            weatherTypeImgView.image = UIImage(named: "Clouds")
        }
        else
        {
            weatherTypeImgView.image = UIImage(named: forecast.weatherType)
        }
    }
    
}
