//
//  HitThemeTableHeaderView.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/02.
//

import UIKit
import RxSwift
import RxCocoa

final class HitThemeTableHeaderView: UIView {
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    /// 카테고리
    fileprivate let categoryWords: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
    var categories: [CategoryModel] { categoryWords.value }
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        setCollectionView()
        bind()
    }
    
    func configureUI() {
        iconImageView.setImage(.logo_gray)
    }
    
    func setCollectionView() {
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.register(HitThemeHeaderCollectionViewCell.self)
    }
    
    func bind() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        categoryWords
            .bind(to: collectionView.rx.items(cellIdentifier: "HitThemeHeaderCollectionViewCell",
                                              cellType: HitThemeHeaderCollectionViewCell.self)) { item, cellModel, cell in
                print("🚨 \(cellModel)")
                cell.configure(cellModel)
            }.disposed(by: disposeBag)
    }
}


extension HitThemeTableHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 144, height: 104)
    }
}

extension Reactive where Base: HitThemeTableHeaderView {
    var itemSelected: ControlEvent<IndexPath> {
        base.collectionView.rx.itemSelected
    }
    
    var categories: Binder<[CategoryModel]> {
        Binder(base) {
            base.categoryWords.accept($1)
        }
    }
}
