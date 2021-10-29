//
//  NetworkLogging.swift
//  HikingClub
//
//  Created by 남수김 on 2021/09/25.
//

import Foundation
import Moya
import os

struct NetworkLogging: PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        #if DEBUG
        guard let urlRequest = request.request else { return }
        os_log("🏔 HTTP Request 🏔🏔🏔🏔🏔", log: .network, type: .debug)
        os_log("   URL         : %{public}@", log: .network, type: .debug, urlRequest.url?.absoluteString ?? "")
        os_log("   Method      : %{public}@", log: .network, type: .debug, urlRequest.httpMethod ?? "")
        os_log("   Header      : %{public}@", log: .network, type: .debug, urlRequest.allHTTPHeaderFields ?? [:])
        os_log("   Body        : %{public}@", log: .network, type: .debug,
               String(data: urlRequest.httpBody ?? Data(), encoding: .utf8) ?? "")
        #endif
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        #if DEBUG
        switch result {
        case let .success(response):
            guard let urlResponse = response.response else { return }
            
            os_log("💌 HTTP Response 💌💌💌💌💌", log: .network, type: .debug)
            os_log("   URL          : %{public}@", log: .network, type: .debug, urlResponse.url?.absoluteString ?? "")
            os_log("   StatusCode   : %{public}d", log: .network, type: .debug, urlResponse.statusCode)
            os_log("   Header       : %{public}@", log: .network, type: .debug, urlResponse.allHeaderFields)
            os_log("   Body         : %{public}@", log: .network, type: .debug,
                   String(data: response.data, encoding: .utf8) ?? "")
        case let .failure(error):
            os_log("⛔️ HTTP Response ⛔️⛔️⛔️⛔️⛔️", log: .network, type: .debug)
            os_log("   Error Code   : %{public}d", log: .network, type: .debug, error.errorCode)
            os_log("   Error Message: %{public}@", log: .network, type: .debug, error.errorDescription ?? "")
            os_log("   URL          : %{public}@", log: .network, type: .debug, error.response?.response?.url?.absoluteString ?? "")
            os_log("   StatusCode   : %{public}d", log: .network, type: .debug, error.response?.statusCode ?? -1)
            os_log("   Header       : %{public}@", log: .network, type: .debug, error.response?.response?.allHeaderFields ?? [:])
            os_log("   Body         : %{public}@", log: .network, type: .debug,
                   String(data: error.response?.data ?? Data(), encoding: .utf8) ?? "")
        }
        #endif
    }
}

extension OSLog {
    static let network = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "hiking", category: "Network")
}
