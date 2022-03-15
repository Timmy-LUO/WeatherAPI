//
//  WeatherModel.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/8.
//

import Foundation

struct selectCityModel {
    var selectCity: [WeatherData] = []
}

struct WeatherData: Codable {
    var name: String
    var id: Int
    var dt: Int
    var coord: Coord
    var weather: [Weather]
    var main: Main
    var sys: Sys
    var wind: Wind
}

struct Coord: Codable {
    var lon: Double
    var lat: Double
}

struct Weather: Codable {
    var main: String
    var description: String
    var icon: String
}

struct Main: Codable {
    var temp: Double
    var temp_min: Double
    var temp_max: Double
    var humidity: Int
    var feels_like: Double
}

struct Sys: Codable {
    var country: String
    var sunrise: Int
    var sunset: Int
    var id: Int
    var type: Int
}

struct Wind: Codable {
    var speed: Double
}
