//
//  NetworkManager.swift
//  SeSAC-AutoLayout
//
//  Created by 김정호 on 1/15/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    // MARK: - properties
    static let shared = NetworkManager()
    private init() {}
    
    // base
    private let baseUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    
    // key
    private let apiKey = Bundle.main.infoDictionary?["APIKey"] as! String
    
    // MARK: - methods
    func fetchMovieList(date: String, completion: @escaping ((Result<Movie, Error>) -> Void)) {
        let parameters: Parameters = ["targetDt": date]
        
        AF.request(baseUrl + "?key=\(apiKey)", parameters: parameters).responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success(let Movie):
                completion(.success(Movie))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
