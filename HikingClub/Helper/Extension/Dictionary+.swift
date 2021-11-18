//
//  Dictionary+.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/18.
//

import Foundation

extension Dictionary {
    var queryString: String {
        var path: String = ""
        for (key, value) in self {
            path.append(contentsOf: path.isEmpty ? "?" : "&")
            path.append(contentsOf: "\(key)=\(value)")
        }
        return path
    }
}
