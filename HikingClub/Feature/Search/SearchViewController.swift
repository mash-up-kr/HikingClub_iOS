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
    @IBOutlet private weak var scrollView: UIScrollView!
    private let searchTextField: NDSearchTextField = NDSearchTextField()
    private let recentSearchLabel: UILabel = UILabel()
    private let recentSearchDeletButton: UIButton = UIButton(type: .system)
    private let recentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    private let spacingView: UIView = UIView()
    private let categoryTitleLabel: UILabel = UILabel()
    private let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let margin: CGFloat = 16
        let width = ((UIScreen.main.bounds.width - margin * 2) - (spacing * 2)) / 3
        let height = 96 * width / 109
        layout.itemSize = .init(width: width, height: height)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    @IBOutlet private weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func attribute() {
        super.attribute()
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 100, right: 0)
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
        
        searchTextField.setPlaceholder("길 이름, #태그로 검색")
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
            $0.bottom.equalToSuperview()
            $0.height.equalTo(304)
        }
    }
    
    private func setRecentCollectionView() {
        recentCollectionView.register(RecentSearchCollectionViewCell.self)
        recentCollectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        viewModel.recentSearchWords
            .bind(to: recentCollectionView.rx.items(cellIdentifier: "RecentSearchCollectionViewCell", cellType: RecentSearchCollectionViewCell.self)) { indexPath, cellModel, cell in
                cell.configure(with: cellModel)
                cell.rx.tapDelete
                    .subscribe(onNext: { [weak self] in
                        self?.viewModel.removeRecentSearchWord(at: indexPath)
                    })
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
    }
    
    private func setCategoryCollectionView() {
        categoryCollectionView.register(CategoryCollectionViewCell.self)
        viewModel.categoryWords
            .bind(to: categoryCollectionView.rx.items(cellIdentifier: "CategoryCollectionViewCell", cellType: CategoryCollectionViewCell.self)) { indexPath, cellModel, cell in
                cell.configure(with: cellModel)
            }
            .disposed(by: disposeBag)
        
        // TODO: 터치시 해당 카테고리로 이동
        categoryCollectionView.rx.itemSelected
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }
    
    /// 카테고리 내용변경시 호출해주세용
    private func updateCategoryCollectionViewHeight() {
        guard let layout = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        let row: CGFloat = CGFloat((viewModel.categoryWords.value.count + 2) / 3)
        let spacing = layout.minimumInteritemSpacing
        let itemHeight = layout.itemSize.height
        let height = itemHeight * row + spacing * (row - 1)
        categoryCollectionView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
    }
    
    override func bind() {
        super.bind()
        
        // FIXME: - Mock삭제
        viewModel.recentSearchWords.accept(["최근검색1", "최근검색122", "최근검색검색하자", "헤에에에에"])
        viewModel.categoryWords.accept(["자연", "야경","벚꽃","연인","자전거","산악회","먹거리","호수","네글자는","한줄더"])
        updateCategoryCollectionViewHeight()
        
        recentSearchDeletButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.removeAllRecentSearchWords()
            })
            .disposed(by: disposeBag)
        
        searchTextField.rx.text
            .distinctUntilChanged()
            .skip(1)
            .map { $0.isEmpty }
            .bind(to: searchTextField.rx.isCancelHidden)
            .disposed(by: disposeBag)
        
        searchTextField.rx.tapCancel
            .subscribe(onNext: { [weak self] in
                self?.searchTextField.text = ""
                self?.searchTextField.setCancelButtonHidden(true)
            })
            .disposed(by: disposeBag)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let word = viewModel.recentSearchWords.value[indexPath.item]
        let label: UILabel = {
            let label = UILabel()
            label.text = word
            label.setFont(.regular13)
            label.sizeToFit()
            return label
        }()
        let buttonWidth: CGFloat = 16
        let buttonMargin: CGFloat = 2 + 6
        let labelMargin: CGFloat = 8
        let width = label.bounds.width + buttonWidth + buttonMargin + labelMargin
        return CGSize(width:  width, height: 29)
    }
}
