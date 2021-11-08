//
//  UserDefaultManager.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/08.
//

import Foundation

struct UserDefaultManager {
    func save<T>(_ value: T, key: UserDefaults.Name) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func value<T>(key: UserDefaults.Name) -> T? {
        return UserDefaults.standard.value(forKey: key.rawValue) as? T
    }
    
    func isEmpty(key: UserDefaults.Name) -> Bool {
        return UserDefaults.standard.value(forKey: key.rawValue) == nil
    }
}
