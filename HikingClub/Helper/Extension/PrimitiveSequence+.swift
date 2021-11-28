//
//  PrimitiveSequence+.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/28.
//

import Foundation
import Moya
import RxMoya
import RxSwift

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func NDmap<T: Decodable>(_ type: T.Type) -> Single<T> {
        return flatMap { response in
            do {
                guard
                    let dictionary = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any]
                else {
                    throw NetworkError.jsonSerialization
                }
                try tokenProcess(dictionary)
                
                try httpStatusProcess(response)
                
                return .just(try response.map(T.self))
            } catch NetworkError.jsonSerialization {
                return .error(NetworkError.jsonSerialization)
            } catch NetworkError.invalidToken {
                return .error(NetworkError.invalidToken)
            } catch NetworkError.httpStatus(let status) {
                return .error(NetworkError.httpStatus(status))
            } catch MoyaError.objectMapping(let error, let response) {
                let message = "\(error)\n response: \n \(String(decoding: response.data, as: UTF8.self))"
                return .error(NetworkError.objectMapping(message))
            }
        }
    }
    
    private func httpStatusProcess(_ response: Response) throws {
        guard 200...299 ~= response.statusCode else {
            throw NetworkError.httpStatus(NetworkError.HttpStatus.get(from: response.statusCode))
        }
    }
    
    private func tokenProcess(_ response: [String: Any]) throws {
        guard let responseCode = response["resCode"] as? String else {
            throw NetworkError.jsonSerialization
        }
        if responseCode == "FAILED_AUTHORIZATION" {
            UserInformationManager.shared.singOut()
            NotificationCenter.default.post(name: Notification.Name.invalidToken, object: nil, userInfo: nil)
            throw NetworkError.invalidToken
        }
    }
}

