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
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    private let spacingView: UIView = UIView()
    private let categoryTitleLabel: UILabel = UILabel()
    private let categoryCollectionView = CategoryCollectionView()
    
    @IBOutlet private weak var containerView: UIView!
    
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
        searchTextField.setReturnKeyType(.go)
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
        viewModel.categoryWords
            .bind(to: categoryCollectionView.rx.items(cellIdentifier: CategoryCollectionView.cellIdentifier, cellType: CategoryCollectionViewCell.self)) { indexPath, cellModel, cell in
                cell.configure(with: cellModel)
            }
            .disposed(by: disposeBag)
        
        categoryCollectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let item = indexPath.item
                let nextViewController = self?.storyboard?.instantiate("SearchCategoryResultViewController") { [weak self] coder -> SearchCategoryResultViewController? in
                    return .init(coder, SearchCategoryResultViewModel(selectedIndex: item, categories: self?.viewModel.categoryWords.value ?? []))
                }
                guard let nextViewController = nextViewController else { return }
                self?.navigationController?.pushViewController(nextViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    override func bind() {
        super.bind()
        
        categoryCollectionView.updateCollectionViewHeight()
        
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
        
        searchTextField.rx.setDelegate(self).disposed(by: disposeBag)
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

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.hasText,
              let title = textField.text else { return false }
        viewModel.saveRecentWords(title)
        view.endEditing(true)
        let nextViewController = storyboard?.instantiate("SearchResultViewController") { coder -> SearchResultViewController? in
            return .init(coder, SearchResultViewModel(searchWord: title))
        }
        guard let nextViewController = nextViewController else { return true }
        navigationController?.pushViewController(nextViewController, animated: true)
        return true
    }
    
    // 글자수제한 20
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let curString = textField.text else { return false }
               guard let stringRange = Range(range, in: curString) else { return false }
               
               let updateText = curString.replacingCharacters(in: stringRange, with: string)
               return updateText.count < 20
    }
}
