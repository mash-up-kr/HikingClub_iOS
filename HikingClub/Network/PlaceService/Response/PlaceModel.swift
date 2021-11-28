//
//  PlaceModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/24.
//

struct PlaceModel: Decodable {
    let code: String
    let fullAddress: String
    let coords: [Double]
    
    var addressDong: String {
        fullAddress.components(separatedBy: .whitespaces).last ?? ""
    }
}
