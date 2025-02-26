//
//  NetworkManager.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 1/16/25.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

enum APIError: Error {
    case requestParameterError
    case callLimitExceededError
    case serverError
    case unknownResponse
}

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
    func fetchShopping(query: String, sort: Sort) -> Observable<Shopping> {
        return Observable<Shopping>.create { value in
            let parameters: Parameters = ["query": query, "start": "1", "sort": sort.rawValue, "display": "100"]
            
            AF.request(self.baseUrl, parameters: parameters, headers: self.headers).responseDecodable(of: Shopping.self) { response in
                switch response.result {
                case .success(let shopping):
                    value.onNext(shopping)
                    value.onCompleted()
                case .failure(_):
                    switch response.response?.statusCode {
                    case 400:
                        value.onError(APIError.requestParameterError)
                    case 429:
                        value.onError(APIError.callLimitExceededError)
                    case 500:
                        value.onError(APIError.serverError)
                    default:
                        value.onError(APIError.unknownResponse)
                    }
                }
            }
            
            return Disposables.create()
        }
    }
}
