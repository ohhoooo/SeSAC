//
//  NetworkManager.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/18/25.
//

import Foundation
import Alamofire

enum Topic: String {
    case goldenHour = "golden-hour"
    case businessWork = "business-work"
    case architectureInterior = "architecture-interior"
}

enum Order: String {
    case relevant = "relevant"
    case latest = "latest"
    
    var toKorean: String {
        switch self {
        case .relevant:
            return "관련순"
        case .latest:
            return "최신순"
        }
    }
}

final class NetworkManager {
    
    // MARK: - properties
    static let shared = NetworkManager()
    private init() {}
    
    // MARK: - methods
    func request<T: Decodable>(_ object: T.Type,
                               router: NetworkRouter,
                               completion: @escaping ((Result<T, Error>) -> Void)) {
        AF.request(router).validate(statusCode: 200..<300).responseDecodable(of: object) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                switch response.response?.statusCode {
                case 400:
                    completion(.failure(NetworkError.missingARequiredParameter))
                case 401:
                    completion(.failure(NetworkError.invalidAccessToken))
                case 403:
                    completion(.failure(NetworkError.missingPermissionsToPerformRequest))
                case 404:
                    completion(.failure(NetworkError.requestedResourceDoesNotExist))
                case 500:
                    completion(.failure(NetworkError.somethingWentWrongOnServerEnd1))
                case 503:
                    completion(.failure(NetworkError.somethingWentWrongOnServerEnd2))
                case .some(_):
                    completion(.failure(error))
                case .none:
                    completion(.failure(error))
                }
            }
        }
    }
}
