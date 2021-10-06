//
//  WebViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/02.
//

import UIKit
import SnapKit // TODO: Remove
import WebKit

final class WebViewController: BaseViewController<WebViewModel> {
    private lazy var webView: BaseWebView = BaseWebView(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    private func attribute() {
        view.backgroundColor = .systemBackground
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        webView.load(URLRequest(url: viewModel.localTestWebPageURL))
    }
    
    private func layout() {
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
        print(message) // TODO: Refactor
    }
}
