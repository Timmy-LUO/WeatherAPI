//
//  Protocol.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/10.
//

import Foundation
import UIKit

protocol SearchResult: AnyObject {
    func searchResult(city: String)
}

extension String {
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
}

extension Int {
    func timetransform() -> String {
        let timeInterval = TimeInterval(self)
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let currentTime = dateFormatter.string(from: date)
        return currentTime
    }
}

extension Double {
    var numberTransform: String {
        let newString = String(format: "%.0f", self)
        return newString
    }
}

enum tempTransform {
    case C, F
}

extension UIColor {
    static var stackViewColorC: UIColor = UIColor(red: 102/255, green: 34/255, blue: 0/255, alpha: 1)
    
    static var stackViewColorF: UIColor = UIColor(red: 255/255, green: 176/255, blue: 97/255, alpha: 1)
    
    static var loadingactivityColor: UIColor = UIColor(red: 0/255, green: 89/255, blue: 179/255, alpha: 1)
    
    static var loadingColor: UIColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.5)
    
    static var cellColor: UIColor = UIColor(red: 60/255, green: 119/255, blue: 119/255, alpha: 1)
}

