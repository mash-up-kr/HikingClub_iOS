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
    
    enum PageType {
        case write
        case detail(roadId: String)
        case update(roadId: String)
    }
    
    private let page: PageType
    
    lazy var webURL: URL = {
        switch page {
        case .write:
            return .init(string: "https://nadeulgil.com/edit.html?roadId=new")!
        case .detail(let roadId):
            return .init(string: "https://nadeulgil.com/detail.html?roadId=\(roadId)")!
        case .update(let roadId):
            return .init(string: "https://nadeulgil.com/edit.html?roadID=\(roadId)")!
        }
    }()
    
    init(for type: PageType) {
        page = type
    }
}
