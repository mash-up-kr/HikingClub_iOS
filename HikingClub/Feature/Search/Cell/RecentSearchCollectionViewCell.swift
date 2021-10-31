//
//  RecentSearchCollectionViewCell.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/28.
//

import UIKit
import RxSwift
import RxCocoa

final class RecentSearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var deleteButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    private(set) var disposeBag: DisposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        attribute()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        disposeBag = DisposeBag()
    }

    private func attribute() {
        titleLabel.setFont(.regular13)
        titleLabel.textColor = .gray700
        deleteButton.setImage(.icon_crossX_gray700_16)
        deleteButton.setTitle("", for: .normal)
        backgroundColor = .gray100
        layer.cornerRadius = 4
    }
    
    func configure(with model: String) {
        titleLabel.text = model
    }
}

extension Reactive where Base: RecentSearchCollectionViewCell {
    var tapDelete: ControlEvent<Void> {
        base.deleteButton.rx.tap
    }
}
