//
//  SearchResultViewController.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/06.
//

import UIKit
import RxCocoa
import RxSwift

final class SearchResultViewController: BaseViewController<SearchResultViewModel> {

    @IBOutlet private weak var naviBar: NaviBar!
    @IBOutlet private weak var tableView: UITableView!
    private let categoryCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 6
        flowLayout.sectionInset = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.backgroundColor = .gray100
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 초기선택설정
        categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
    }
    
    private func setTableHeaderView() {
        view.addSubview(categoryCollectionView)
        categoryCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalTo(naviBar)
            $0.top.equalTo(naviBar.snp.bottom)
            $0.height.equalTo(57)
        }
    }
    
    override func attribute() {
        super.attribute()
        naviBar.setBackItemImage()
        tableView.contentInset = .init(top: 57, left: 0, bottom: 0, right: 0)
        tableView.register(RoadTableViewCell.self)
        tableView.separatorStyle = .none
        categoryCollectionView.register(CategoryTabCollectionViewCell.self)
    }
    
    override func layout() {
        super.layout()
        setTableHeaderView()
    }
    
    override func bind() {
        super.bind()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        categoryCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        naviBar.rx.tapLeftItem
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.categoryName
            .bind(to: naviBar.rx.title)
            .disposed(by: disposeBag)
        
        // 길정보 셀
        viewModel.roadDatas
            .bind(to: tableView.rx.items(cellIdentifier: "RoadTableViewCell",
                                         cellType: RoadTableViewCell.self)) { row, cellModel, cell in
                cell.configure(tags: [cellModel])
            }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] in
                // TODO: 길상세페이지 넘기기
                print($0)
                let webViewController = WebViewController(WebViewModel())
                webViewController.hidesBottomBarWhenPushed = true
                self?.tableView.deselectRow(at: $0, animated: true)
                self?.navigationController?.pushViewController(webViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        // 카테고리 셀
        viewModel.categoryWords
            .bind(to: categoryCollectionView.rx.items(cellIdentifier: "CategoryTabCollectionViewCell",
                                              cellType: CategoryTabCollectionViewCell.self)) { item, cellModel, cell in
                cell.configure(with: cellModel)
            }.disposed(by: disposeBag)
        
        // 카테고리 텝버튼 클릭시
        categoryCollectionView.rx.itemSelected
            .map { $0.item }
            .bind(to: viewModel.selectedCategory)
            .disposed(by: disposeBag)
        
    }
}


extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let word = viewModel.categoryWords.value[indexPath.item]
        let tab: NDTabButton = {
            let tab = NDTabButton()
            tab.setTitle(word)
            return tab
        }()
        tab.layoutIfNeeded()
        return CGSize(width: tab.bounds.width, height: 33)
    }
}
