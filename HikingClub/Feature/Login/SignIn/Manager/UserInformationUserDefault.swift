//
//  UserInformationUserDefault.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/16.
//
import Foundation

struct UserInformationUserDefault: UserDefaultManager {
    typealias T = String
    
    private let key: String
    
    init(key: UserDefaults.User) {
        self.key = key.rawValue
    }
    
    var value: String? {
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
