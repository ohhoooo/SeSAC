//
//  NetworkRouter.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/21/25.
//

import Foundation
import Alamofire

enum NetworkRouter {
    case fetchPhotos(topic: Topic)
    case fetchPhotoSearch(query: String, page: Int, perPage: Int, orderBy: Order)
    case fetchPhotoStatistic(photoId: String)
}

// MARK: - extensions
extension NetworkRouter: URLRequestConvertible {
    var baseURL: URL {
        return URL(string: "https://api.unsplash.com")!
    }
    
    var headers: HTTPHeaders {
        return [
            "Authorization": Bundle.main.infoDictionary?["APIKey"] as! String
        ]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .fetchPhotos(let topic):
            return "/topics/\(topic.rawValue)/photos"
        case .fetchPhotoSearch(_, _, _, _):
            return "/search/photos"
        case .fetchPhotoStatistic(let photoId):
            return "/photos/\(photoId)/statistics"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .fetchPhotoSearch(let query, let page, let perPage, let orderBy):
            return [
                "query": query,
                "page": page,
                "per_page": perPage,
                "order_by": orderBy.rawValue
            ]
        case .fetchPhotos(_), .fetchPhotoStatistic(_):
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.headers = headers
        request.method = method
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
