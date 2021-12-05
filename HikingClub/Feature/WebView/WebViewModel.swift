//
//  WebViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/06.
//

import WebKit
import RxRelay

final class WebViewModel: BaseViewModel {
    var localTestWebPageURL: URL {
        URL(string: "http://192.168.200.109:3000/detail/1234")!
    }
    var expiredTokenRelay = PublishRelay<Void>()
    
    enum PageType {
        case write
        case detail(roadId: String)
        case update(roadId: String)
    }
    
    private let page: PageType
    
    lazy var webURL: URL = {
        switch page {
        case .write:
            if let currentCoordinate = NDLocationManager.shared.currentCoordinate {
                let lat = currentCoordinate.0
                let long = currentCoordinate.1
                return .init(string: "https://nadeulgil.com/edit.html?roadId=new&lat=\(lat)&long=\(long)")!
            } else {
                return .init(string: "https://nadeulgil.com/edit.html?roadId=new")!
            }
        case .detail(let roadId):
            return .init(string: "https://nadeulgil.com/detail.html?roadId=\(roadId)")!
        case .update(let roadId):
            return .init(string: "https://nadeulgil.com/edit.html?roadID=\(roadId)")!
        }
    }()
    
    let closeAction = PublishRelay<Void>()
    
    init(for type: PageType) {
        page = type
    }
}

extension WebViewModel: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // TODO: REFACTOR
        guard
            let body = message.body as? [String: Any],
            let functionString = body["function"] as? String,
            let function = BaseWebView.WebMessageFunction(rawValue: functionString)
        else { return }
        
        switch function {
        case .close:
            closeAction.accept(Void())
        case .share:
            guard let data = body as? [String: String],
                  let shareURL = data["url"]
            else { return }
            // TODO: REFACTOR
            print("share url\(shareURL)")
        case .expireToken:
            UserInformationManager.shared.signOut()
            expiredTokenRelay.accept(Void())
        }
    }
}
