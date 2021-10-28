//
//  SearchViewController.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/27.
//

import UIKit
import RxCocoa
import RxSwift

final class SearchViewController: BaseViewController<SearchViewModel> {
    private let searchTextField: NDSearchTextField = NDSearchTextField()
    private let recentSearchLabel: UILabel = UILabel()
    private let recentSearchDeletButton: UIButton = UIButton(type: .system)
    private let recentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    private let spacingView: UIView = UIView()
    private let categoryTitleLabel: UILabel = UILabel()
    private let categoryCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    @IBOutlet private weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func attribute() {
        super.attribute()
        
        recentSearchLabel.setFont(.semiBold16)
        recentSearchLabel.textColor = .gray900
        recentSearchLabel.text = "최근 검색어"
        recentSearchDeletButton.setFont(.medium14)
        recentSearchDeletButton.setTitleColor(.gray400, for: .normal)
        recentSearchDeletButton.setTitle("전체삭제", for: .normal)
        recentSearchDeletButton.addTarget(self,
                                          action: #selector(recentAllDelete),
                                          for: .touchUpInside)
        spacingView.backgroundColor = .gray100
        categoryTitleLabel.setFont(.semiBold16)
        categoryTitleLabel.textColor = .gray900
        categoryTitleLabel.text = "카테고리로 찾아보세요"
        setRecentCollectionView()
        setCategoryCollectionView()
    }
    
    @objc
    private func recentAllDelete() {
        print("전체삭제클릭")
    }
    
    override func layout() {
        super.layout()
        containerView.addSubViews(searchTextField,
                                  recentSearchLabel,
                                  recentSearchDeletButton,
                                  recentCollectionView,
                                  spacingView,
                                  categoryTitleLabel,
                                  categoryCollectionView)
        
        searchTextField.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        recentSearchLabel.snp.makeConstraints {
            $0.leading.equalTo(searchTextField)
            $0.top.equalTo(searchTextField.snp.bottom).offset(26)
        }
        
        recentSearchDeletButton.snp.makeConstraints {
            $0.centerY.equalTo(recentSearchLabel)
            $0.trailing.equalTo(searchTextField)
        }
        
        recentCollectionView.snp.makeConstraints {
            $0.leading.equalTo(recentSearchLabel)
            $0.trailing.equalToSuperview()
            $0.top.equalTo(recentSearchLabel.snp.bottom).offset(15)
            $0.height.equalTo(29)
        }
        
        spacingView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(8)
            $0.top.equalTo(recentCollectionView.snp.bottom).offset(20.5)
        }
        
        categoryTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(recentSearchLabel)
            $0.top.equalTo(spacingView.snp.bottom).offset(31)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoryTitleLabel.snp.bottom).offset(15)
            $0.leading.equalTo(categoryTitleLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(304)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setRecentCollectionView() {
        recentCollectionView.register(RecentSearchCollectionViewCell.self)
        viewModel.recentSearchWords
            .bind(to: recentCollectionView.rx.items(cellIdentifier: "RecentSearchCollectionViewCell", cellType: RecentSearchCollectionViewCell.self)) { indexPath, cellModel, cell in
                cell.configure(with: cellModel)
            }
            .disposed(by: disposeBag)
        
        
    }
    
    private func setCategoryCollectionView() {
        
    }
    
    override func bind() {
        super.bind()
        
        // FIXME: - Mock삭제
        viewModel.recentSearchWords.accept(["최근검색1", "최근검색122", "최근검색검색하자", "헤에에에에"])
    }
}
