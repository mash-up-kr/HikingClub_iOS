//
//  NDNotificationName.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/28.
//

import Foundation

enum NDNotificationName {
    case invalidToken
    
    var name: NSNotification.Name {
        switch self {
        case .invalidToken:
            return NSNotification.Name(rawValue: "NDNotificationName.invalidToken")
        }
    }
}
