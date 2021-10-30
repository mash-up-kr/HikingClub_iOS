//
//  KeyboardAccessoryToolbar.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/30.
//

import UIKit

final class KeyboardAccessoryToolbar: UIToolbar {
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        self.barStyle = .default
        isTranslucent = true
        
        let closeButton = UIButton(type : .custom)
        closeButton.setFont(.medium14)
        closeButton.setTitleColor(.gray700, for: .normal)
        closeButton.setTitle("닫기", for: .normal)
        closeButton.frame = CGRect(x: .zero, y: .zero, width: 20, height : 20)
        closeButton.addTarget(self, action: #selector(self.done), for: UIControl.Event.touchUpInside)

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let closeButtonItem = UIBarButtonItem(customView: closeButton)
        self.items = [flexSpace, closeButtonItem]
        self.sizeToFit()
    }
    
    @objc func done() {
        // Tell the current first responder (the current text input) to resign.
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    @objc func cancel() {
        // Call "cancel" method on first object in the responder chain that implements it.
        UIApplication.shared.sendAction(#selector(cancel), to: nil, from: nil, for: nil)
    }
}
