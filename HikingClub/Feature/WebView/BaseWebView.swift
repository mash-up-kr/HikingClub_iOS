//
//  BaseWebView.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/03.
//

import WebKit

// WkWebView가 동일한 contentController를 사용하기 위한 BaseWebView
class BaseWebView: WKWebView {
    // js에서 messsage를 호출하기 위해 필요한 키워드
    static var contentHandlerName: String {
        "handler"
    }
    
    init(_ handler: WKScriptMessageHandler) {
        super.init(frame: .zero, configuration: BaseWebView.contentControllerfiguration(handler))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
}
