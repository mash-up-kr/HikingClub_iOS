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
    private let toastButton = UIButton()
    private let searchTextField = NDSearchTextField()
    private let tabButton = NDTabButton()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setScrollView()
        stackView.addArrangedSubviews(ndTextFieldView,
                                      alertButton,
                                      ctaButton)
        testTextField()
        testAlert()
        testCTAButton()
        testToast()
        testSearchTextField()
        testTabButton()
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
        ndTextFieldView.setTitle("히히", description: "설명", theme: .normal)
        ndTextFieldView.setTitle("워닝히히", description: "워닝설명", theme: .warning)
        ndTextFieldView.setTheme(.normal)
        
        Observable<Int>.timer(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.ndTextFieldView.rx.theme.onNext(.warning)
            })
            .disposed(by: disposeBag)
        
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
        stackView.addArrangedSubview(toastButton)
        toastButton.setTitle("토스트띄우기", for: .normal)
        toastButton.setTitleColor(.black, for: .normal)
        toastButton.rx.tap
            .map { .green(text: "테스트 토스트!") }
            .bind(to: NDToastView.shared.rx.showText)
            .disposed(by: disposeBag)
        
        toastButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
    }
    
    func testSearchTextField() {
        searchTextField.setPlaceholder("검색어를 입력하세요")
        stackView.addArrangedSubview(searchTextField)
        searchTextField.snp.makeConstraints {
            $0.height.equalTo(48)
        }

        Observable<Int>.timer(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.searchTextField.setCancelButtonHidden(false)
            })
            .disposed(by: disposeBag)
        
        searchTextField.rx.tapCancel
            .subscribe(onNext: {
                self.searchTextField.setCancelButtonHidden(true)
            })
            .disposed(by: disposeBag)
    }
    
    func testTabButton() {
        let containerView = UIStackView()
        containerView.axis = .horizontal
        containerView.spacing = 8
        containerView.backgroundColor = .lightGray
        stackView.addArrangedSubview(containerView)
        containerView.snp.makeConstraints {
            $0.height.equalTo(33)
        }
        containerView.addArrangedSubview(tabButton)
        tabButton.setTitle("자연")
        tabButton.tapHandler = {
            print($0)
            print("자연클릭")
        }
        
        let tabButton2 = NDTabButton()
        tabButton2.setTitle(subTitle: "현위치")
        containerView.addArrangedSubview(tabButton2)
        
        let tabButton3 = NDTabButton()
        tabButton3.setTitle("가락동", subTitle: "현위치")
        containerView.addArrangedSubview(tabButton3)
        
        let spacing = UIView()
        containerView.addArrangedSubview(spacing)
    }
}
#endif
