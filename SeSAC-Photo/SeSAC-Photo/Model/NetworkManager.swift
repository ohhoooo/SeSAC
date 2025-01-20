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
    
    // header key
    private let apiKey = Bundle.main.infoDictionary?["APIKey"] as! String
    
    // header
    private lazy var headers: HTTPHeaders = ["Authorization": apiKey]
    
    // base
    private let baseUrl = "https://api.unsplash.com"
    
    // path
    private let searchPath = "/search/photos"
    
    // MARK: - methods
    func fetchPhotoTopic(topic: Topic,
                         completion: @escaping ((Result<[Photo], Error>) -> Void)) {
        let path = "/topics/\(topic.rawValue)/photos"
        
        AF.request(baseUrl + path, headers: headers).responseDecodable(of: [Photo].self) { response in
            switch response.result {
            case .success(let photoList):
                completion(.success(photoList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPhotoSearch(query: String,
                          page: Int,
                          perPage: Int,
                          orderBy: Order,
                          completion: @escaping ((Result<PhotoSearch, Error>) -> Void)) {
        let parameters: Parameters = ["query": query, "page": page, "per_page": perPage, "order_by": orderBy.rawValue]
        
        AF.request(baseUrl + searchPath, parameters: parameters, headers: headers).responseDecodable(of: PhotoSearch.self) { response in
            switch response.result {
            case .success(let photoSearch):
                completion(.success(photoSearch))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPhotoStatistic(photoId: String,
                             completion: @escaping ((Result<PhotoStatistic, Error>) -> Void)) {
        let path = "/photos/\(photoId)/statistics"
        
        AF.request(baseUrl + path, headers: headers).responseDecodable(of: PhotoStatistic.self) { response in
            switch response.result {
            case .success(let photoStatistic):
                completion(.success(photoStatistic))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
