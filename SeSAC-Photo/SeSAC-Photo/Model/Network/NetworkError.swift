//
//  NetworkError.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/22/25.
//

import Foundation

enum NetworkError: Int, Error {
    case missingARequiredParameter = 400
    case invalidAccessToken = 401
    case missingPermissionsToPerformRequest = 403
    case requestedResourceDoesNotExist = 404
    case somethingWentWrongOnServerEnd1 = 500
    case somethingWentWrongOnServerEnd2 = 503
    
    var alertMessage: String {
        switch self {
        case .missingARequiredParameter:
            return "필수 매개변수가 누락되었습니다."
        case .invalidAccessToken:
            return "잘못된 액세스 토큰입니다."
        case .missingPermissionsToPerformRequest:
            return "요청을 수행할 권한이 없습니다."
        case .requestedResourceDoesNotExist:
            return "요청한 리소스가 없습니다."
        case .somethingWentWrongOnServerEnd1, .somethingWentWrongOnServerEnd2:
            return "서버에서 문제가 발생하였습니다."
        }
    }
}
