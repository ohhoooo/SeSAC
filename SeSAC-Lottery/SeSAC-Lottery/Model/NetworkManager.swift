//
//  NetworkManager.swift
//  SeSAC-Lottery
//
//  Created by 김정호 on 1/14/25.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

final class NetworkManager {
    
    // MARK: - properties
    static let shared = NetworkManager()
    private init() {}
    
    // base
    private let baseUrl = "https://www.dhlottery.co.kr/common.do"
    
    // MARK: - methods
    func fetchObservableLottery(drwNo: String) -> Observable<Lottery> {
        return Observable<Lottery>.create { value in
            let parameters: Parameters = ["method": "getLottoNumber", "drwNo": drwNo]
            
            AF.request(self.baseUrl, parameters: parameters).responseDecodable(of: Lottery.self) { response in
                switch response.result {
                case .success(let lottery):
                    value.onNext(lottery)
                    value.onCompleted()
                case .failure(let error):
                    value.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    func fetchSingleLottery(drwNo: String) -> Single<Lottery> {
        return Single<Lottery>.create { value in
            let parameters: Parameters = ["method": "getLottoNumber", "drwNo": drwNo]
            
            AF.request(self.baseUrl, parameters: parameters).responseDecodable(of: Lottery.self) { response in
                switch response.result {
                case .success(let lottery):
                    value(.success(lottery))
                case .failure(let error):
                    value(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
