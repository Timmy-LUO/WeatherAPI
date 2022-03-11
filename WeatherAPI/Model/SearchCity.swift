//
//  SearchCity.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/10.
//

import Foundation

//MARK: - City API
struct City: Codable {
    let countryName: String

    enum CodingKeys: String, CodingKey {
        case countryName = "country_name"
    }
}

typealias CityAPI = [City]
