//
//  NetworkManager.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/18/25.
//

import Foundation
import Alamofire

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
    func fetchPhotoSearch(query: String,
                          page: Int,
                          perPage: Int,
                          orderBy: String,
                          completion: @escaping ((Result<PhotoSearch, Error>) -> Void)) {
        let parameters: Parameters = ["query": query, "page": page, "per_page": perPage, "order_by": orderBy]
        
        AF.request(baseUrl + searchPath, parameters: parameters, headers: headers).responseDecodable(of: PhotoSearch.self) { response in
            switch response.result {
            case .success(let photoSearch):
                completion(.success(photoSearch))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
