//
//  BaseViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/05.
//

import UIKit
import RxSwift

class BaseViewController<T: BaseViewModel>: UIViewController {
    let viewModel: T = T()
    let disposeBag = DisposeBag()
}
