//
//  BaseViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/05.
//

import UIKit

class BaseViewController<T>: UIViewController where T: BaseViewModel {
    let viewModel: T = T()
}
