//
//  WeatherResponse.swift
//  SeSAC-LocationAuthority
//
//  Created by 김정호 on 2/3/25.
//

import Foundation

struct WeatherResponse: Decodable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
}

struct Clouds: Decodable {
    let all: Int?
}

struct Coord: Decodable {
    let lon, lat: Double?
}

struct Main: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity, seaLevel, grndLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

struct Sys: Decodable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
}

struct Weather: Decodable {
    let id: Int?
    let main, description, icon: String?
}

struct Wind: Decodable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
