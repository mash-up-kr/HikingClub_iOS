//
//  RxTextFieldDelegateProxy.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/02.
//

import UIKit
import RxCocoa
import RxSwift

final class RxTextFieldDelegateProxy: DelegateProxy<UITextField, UITextFieldDelegate>, DelegateProxyType, UITextFieldDelegate {
    static func registerKnownImplementations() {
        self.register { textField -> RxTextFieldDelegateProxy in
            RxTextFieldDelegateProxy(parentObject: textField, delegateProxy: self)
        }
    }
    
    static func currentDelegate(for object: UITextField) -> UITextFieldDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: UITextFieldDelegate?, to object: UITextField) {
        object.delegate = delegate
    }
}
