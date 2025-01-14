//
//  NetworkManager.swift
//  SeSAC-Lottery
//
//  Created by 김정호 on 1/14/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    // MARK: - properties
    static let shared = NetworkManager()
    private init() {}
    
    // base
    private let baseUrl = "https://www.dhlottery.co.kr/common.do"
    
    // MARK: - methods
    func fetchLottery(drwNo: String, completion: @escaping ((Result<Lottery, Error>) -> Void)) {
        let parameters: Parameters = ["method": "getLottoNumber", "drwNo": drwNo]
        
        AF.request(baseUrl, parameters: parameters).responseDecodable(of: Lottery.self) { response in
            switch response.result {
            case .success(let lottery):
                completion(.success(lottery))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
