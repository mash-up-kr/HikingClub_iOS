//
//  RecentSearchUserDefault.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/08.
//

import Foundation

struct RecentSearchUserDefault: UserDefaultManager {
    typealias T = [String]
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
