//
//  WebViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/02.
//

import UIKit
import WebKit

final class WebViewController: BaseViewController<WebViewModel> {
    private lazy var webView: BaseWebView = BaseWebView(self)
    
    override func attribute() {
        super.attribute()
        view.backgroundColor = .systemBackground
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        webView.load(URLRequest(url: viewModel.webURL))
    }
    
    override func layout() {
        super.layout()
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(view)
        }
    }
}

extension WebViewController: WKUIDelegate, WKNavigationDelegate { }

extension WebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // TODO: REFACTOR
        guard
            let body = message.body as? [String: Any],
            let functionString = body["function"] as? String,
            let function = BaseWebView.WebMessageFunction(rawValue: functionString)
        else { return }
        
        switch function {
        case .close:
            navigationController?.popViewController(animated: true)
        case .share:
            guard let data = body as? [String: String],
                  let shareURL = data["url"]
            else { return }
            // TODO: REFACTOR
            print("share url\(shareURL)")
        }
    }
}
