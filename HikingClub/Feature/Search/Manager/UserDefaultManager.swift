//
//  UserDefaultManager.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/08.
//

import Foundation

protocol UserDefaultManager {
    associatedtype T
    
    var value: T? { get }
    var isEmpty: Bool { get }
    func save<T>(_ value: T)
    func removeAll()
}
