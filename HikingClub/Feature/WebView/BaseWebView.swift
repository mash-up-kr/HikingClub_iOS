//
//  BaseWebView.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/03.
//

import WebKit

// WkWebView가 동일한 contentController를 사용하기 위한 BaseWebView
final class BaseWebView: WKWebView {
    // js에서 보내준 message를 구별하기 위한 key
    enum WebMessageFunction: String {
        case close
        case share
    }
    // js에서 messsage를 호출하기 위해 필요한 키워드
    static var contentHandlerName: String {
        "handler"
    }
        
    static func contentControllerfiguration(_ handler: WKScriptMessageHandler) -> WKWebViewConfiguration {
        let preference = WKPreferences()
        preference.javaScriptEnabled = true
        preference.javaScriptCanOpenWindowsAutomatically = true

        let script = WKUserScript(source: "", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let contentController = WKUserContentController()
        contentController.addUserScript(script)
        contentController.add(handler, name: contentHandlerName)

        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController
        configuration.preferences = preference
        configuration.websiteDataStore = WKWebsiteDataStore.default()
        
        return configuration
    }
    
    func setUserTokenAtCookie() {
        guard
            let token = UserInformationUserDefault.init(key: .token).value,
            let cookie = makeUserTokenCookie(token)
        else { return }
        configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
    }
    
    private func makeUserTokenCookie(_ token: String) -> HTTPCookie? {
        let monthInterval = 60 * 60 * 60 * 24 * 30
        return HTTPCookie(properties: [
            .domain: "nadeulgil.com",
            .path: "/",
            .name: "USER_TOKEN",
            .value: token,
            .secure: "TRUE",
            .expires: NSDate(timeIntervalSinceNow: TimeInterval(monthInterval))
        ])
    }
}
