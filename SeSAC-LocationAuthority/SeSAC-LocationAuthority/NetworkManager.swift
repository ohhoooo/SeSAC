//
//  NetworkManager.swift
//  SeSAC-LocationAuthority
//
//  Created by 김정호 on 2/3/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    // MARK: - properties
    static let shared = NetworkManager()
    private init() {}
    
    // MARK: - methods
    func fetchWeather(lat: Double,
                      lon: Double,
                      completion: @escaping ((Result<WeatherResponse, Error>) -> Void)) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather")!
        let parameters: Parameters = ["lat": lat, "lon": lon, "appid": "2cf06b70fe1b48a50926f8e1b2b44e9d", "units": "metric", "lang": "kr"]
        
        AF.request(url, parameters: parameters).responseDecodable(of: WeatherResponse.self) { response in
            switch response.result {
            case .success(let weatherResponse):
                completion(.success(weatherResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
