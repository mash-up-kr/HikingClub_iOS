//
//  WebViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/06.
//

import WebKit

final class WebViewModel: BaseViewModel {
    var localTestWebPageURL: URL {
        URL(string: "http://192.168.200.109:3000/detail/1234")!
    }
}
