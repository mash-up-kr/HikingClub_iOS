//
//  VersionInfoViewController.swift
//  HikingClub
//
//  Created by 이문정 on 2021/11/06.
//

import UIKit
import RxCocoa
import RxSwift

class VersionInfoViewController: BaseViewController<BaseViewModel> {
    
    @IBOutlet weak var versionCommentLabel: UILabel!
    @IBOutlet weak var presentVersionLable: UILabel!
    @IBOutlet weak var versionUpdateButtonView: NDButton!
    
    private let navigationBar: NaviBar = {
        let view = NaviBar()
        view.setTitle("버전정보")
        view.setBackItemImage()
        return view
    }()
    
    func updateButton() {
        versionUpdateButtonView.setTitle("업데이트 하기", for: .normal)
        versionUpdateButtonView.snp.makeConstraints {
            $0.height.equalTo(54)
        }
        versionUpdateButtonView.isEnabled = false
        versionUpdateButtonView.rx.tap
            .subscribe(onNext: { [weak self] in
                print("버튼 클릭!")
            })
            .disposed(by: disposeBag)
        // 뷰모델에서 업데이트 정보 받아서 버튼 활성화
        Observable.just(true)
            .bind(to: versionUpdateButtonView.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        updateButton()
        versionCommentLabel.textColor = .gray800
        versionCommentLabel.setFont(.semiBold18)
        presentVersionLable.textColor = .gray500
        presentVersionLable.setFont(.medium14)
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        presentVersionLable.text = version
    }
    
    override func layout() {
        super.layout()
        view.addSubViews(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    override func bind() {
        super.bind()
        navigationBar.rx.tapLeftItem
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
