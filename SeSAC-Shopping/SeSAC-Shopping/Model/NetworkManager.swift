//
//  NetworkManager.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 1/16/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    // MARK: - properties
    static let shared = NetworkManager()
    private init() {}
    
    // header key
    private let clientId = Bundle.main.infoDictionary?["ClientId"] as! String
    private let clientSecret = Bundle.main.infoDictionary?["ClientSecret"] as! String
    
    // header
    private lazy var headers: HTTPHeaders = ["X-Naver-Client-Id": clientId, "X-Naver-Client-Secret": clientSecret]
    
    // base
    private let baseUrl = "https://openapi.naver.com/v1/search/shop.json"
    
    // MARK: - methods
    func fetchShopping(query: String, completion: @escaping ((Result<Shopping, Error>) -> Void)) {
        let parameters: Parameters = ["query": query, "display": "100"]
        
        AF.request(baseUrl, parameters: parameters, headers: headers).responseDecodable(of: Shopping.self) { response in
            switch response.result {
            case .success(let shopping):
                completion(.success(shopping))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
