//
//  ComponentTestViewController.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/15.
//

import UIKit
import RxSwift
import RxCocoa

#if DEBUG
// TODO: - 호출부분 if debug추가하기
final class ComponentTestViewController: UIViewController, UIScrollViewDelegate {

    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let ndTextFieldView = NDTextFieldView(scale: .small)
    private let alertButton = NDButton(theme: .init(.fillGreen))
    private let alert = NDAlert(buttonStyle: .two,
                                title: "타이틀테스트",
                                description: "설명 두줄을 한번 써봥야징,설명 두줄을 한번 써봥야징,설명 두줄을 한번 써봥야징",
                                okTitle: "오케이!",
                                okHandler: {
        print("오케이")
    },
                                cancelTitle: "취소!") {
        print("취소")
    }
    private let ctaButton = NDCTAButton(buttonStyle: .one)
    private let toastView = NDToastView(theme: .red)
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setScrollView()
        stackView.addArrangedSubviews(ndTextFieldView,
                                      alertButton,
                                      ctaButton,
                                      toastView)
        testTextField()
        testAlert()
        testCTAButton()
        testToast()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func setScrollView() {
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
        }
    }
    
    func testTextField() {
        ndTextFieldView.setPlaceholder("플레이스 홀더")
        ndTextFieldView.setTitle("레이블", description: "설명이 들어갑니다")
        ndTextFieldView.rx.theme.onNext(.selected)
    }

    func testAlert() {
        alertButton.setTitle("알림창 테스트", for: .normal)
        alertButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        alertButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.view.addSubview(self!.alert)
                self?.alert.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func testCTAButton() {
        view.layoutIfNeeded()
        ctaButton.setGradientColor()
        ctaButton.setTitle("오키", buttonType: .ok)
        ctaButton.setTitle("엥", buttonType: .cancel)
        ctaButton.rx.tapOk
            .subscribe(onNext: {
                print("오케이!")
            })
            .disposed(by: disposeBag)
    }
    
    func testToast() {
        toastView.setTitle("토스트 메시지")
        toastView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
    }
}
#endif
