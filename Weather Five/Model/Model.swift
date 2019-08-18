//
//  Model.swift
//  Weather Five
//
//  Created by Vova SKR on 08/08/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation


class WeatherModelIcon {
    var conditionOFWeather = 0
    
    func updateIcon (condition: Int) -> String {
        switch condition {
        case 0...300 :
            return "tstorm1"
            
        case 301...500 :
            return "shower3"
            
        case 501...600 :
            return "shower3"
            
        case 601...700 :
            return "snow4"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "tstorm3"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy2"
            
        case 900...903, 905...1000  :
            return "tstorm3"
            
        case 903 :
            return "snow4"
            
        case 904 :
            return "sunny"
            
        default :
            return "Cloud-Refresh"
        }
    }
}

struct WeatherStruct: Codable {
    var name: String
    var main: TemparatureData
    var weather: [WeatherData]
    
}

struct TemparatureData: Codable {
    var temp: Float
}

struct WeatherData: Codable {
    var id: Int
}
