//
//  FirstUserManager.swift
//  HikingClub
//
//  Created by 이문정 on 2021/12/05.
//

import Foundation

struct FirstUserManager: UserDefaultManager {
    typealias T = Bool
    private let key: String
    
    init(key: UserDefaults.Name) {
        self.key = key.rawValue
    }
    
    var value: T? {
        return UserDefaults.standard.value(forKey: key) as? T
    }
    
    var isEmpty: Bool {
        return UserDefaults.standard.value(forKey: key) == nil
    }
    
    func save<T>(_ value: T) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func removeAll() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
