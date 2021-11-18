//
//  WorkCalculator.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/18.
//

import Foundation

/// 거리정보 계산
struct WorkCalculator {
    /// 1.04m/s 속도로 걷는다고 가정
    /// 62.5m/m
    let speed: Float = 62.5
    
    /// - Parameters:
    ///     - distance: km 단위
    /// - Returns: 분 단위
    func costTime(distance: Float) -> Int {
        Int((distance * 1000.0 / speed))
    }
    
    /// - Parameters:
    ///     - distance: km 단위
    /// - Returns: 분 단위
    func costTime(distance: Int) -> Int {
        Int((Float(distance) * 1000.0 / speed))
    }
}
