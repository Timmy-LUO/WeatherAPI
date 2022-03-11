//
//  Protocol.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/10.
//

import Foundation
import UIKit

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
    static var stackViewColorF: UIColor = UIColor(red: 0/255, green: 173/255, blue: 173/255, alpha: 1)
    
    static var stackViewColorC: UIColor = UIColor(red: 128/255, green: 255/255, blue: 255/255, alpha: 1)
}