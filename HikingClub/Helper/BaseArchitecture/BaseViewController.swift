//
//  BaseViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/05.
//

import UIKit
import RxCocoa
import RxSwift

class BaseViewController<T: BaseViewModel>: UIViewController, CodeBasedProtocol {
    var viewModel: T
    let disposeBag = DisposeBag()
    
    /// 코드를 통해 ViewController를 생성할 때 사용하는 initializer
    /// - Parameter viewModel: 주입할 ViewModel
    init(_ viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    /// StoryBoard를 통해서 ViewController를 생성할 때 사용하는 initializer
    init?(_ coder: NSCoder, _ viewModel: T) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        bind()
    }
    
    func attribute() {
        view.backgroundColor = .systemBackground
    }
    
    func layout() { }
    
    func bind() {
        baseBinding()
    }
    
    private func baseBinding() {
        toastMessageBinding()
    }
    
    private func toastMessageBinding() {
        viewModel.toastMessage
            .bind(to: NDToastView.shared.rx.showText)
            .disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
