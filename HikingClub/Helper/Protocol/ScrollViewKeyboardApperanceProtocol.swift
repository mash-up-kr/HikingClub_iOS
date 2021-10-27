//
//  ScrollViewKeyboardApperanceProtocol.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/17.
//

import UIKit

protocol ScrollViewKeyboardApperanceProtocol {
    /// 적용할 ScrollView
    var scrollView: UIScrollView { get }
    
    /// keyboard 노출 시 함께 올라가야 할 View
    var bottomAreaView: UIView { get }
    
    /// keyboard 노출/미노출에 따른 동작 실행
    func initKeyboardApperance()
}

extension ScrollViewKeyboardApperanceProtocol where Self: UIViewController {
    func initKeyboardApperance() {
        scrollView.keyboardDismissMode = .onDrag
        NotificationCenter.default.addObserver(forName: UIWindow.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
            self?.handleScrollView(notification, true)
        }
        NotificationCenter.default.addObserver(forName: UIWindow.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] notification in
            self?.handleScrollView(notification, false)
        }
    }
    
    private func handleScrollView(_ notification: Foundation.Notification, _ isShow: Bool) {
        guard
            let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
        else { return }
        
        let insetValue = isShow ? keyboardFrame.cgRectValue.height - view.safeAreaInsets.bottom + 20: 0
        let contentInsetValue: CGFloat = isShow ? 20 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: contentInsetValue, right: 0)
        
        bottomAreaView.snp.updateConstraints {
            $0.bottom.equalTo(view).inset(insetValue)
        }
        
        UIView.animate(withDuration: keyboardAnimationDuration.doubleValue) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}
