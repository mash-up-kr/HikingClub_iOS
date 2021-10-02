//
//  NetworkError.swift
//  HikingClub
//
//  Created by 남수김 on 2021/09/25.
//

import Foundation

enum NetworkError: Int, Error {
    case badRequest = 400
    case notFound = 404
    case server = 500
    case unknown
}
