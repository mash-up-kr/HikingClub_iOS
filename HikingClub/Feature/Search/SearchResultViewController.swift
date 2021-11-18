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
    private let locationCollectionView: CategoryTabCollectionView = CategoryTabCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 초기선택설정
        locationCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
    }
    
    private func setTableHeaderView() {
        view.addSubview(locationCollectionView)
        locationCollectionView.snp.makeConstraints {
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
        locationCollectionView.register(CategoryTabCollectionViewCell.self)
    }
    
    override func layout() {
        super.layout()
        setTableHeaderView()
    }
    
    override func bind() {
        super.bind()
        locationCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        naviBar.rx.tapLeftItem
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.searchWord
            .bind(to: naviBar.rx.title)
            .disposed(by: disposeBag)
        
        // 길정보 셀
        viewModel.roadDatas
            .bind(to: tableView.rx.items(cellIdentifier: "RoadTableViewCell",
                                         cellType: RoadTableViewCell.self)) { row, cellModel, cell in
                cell.configure(model: cellModel)
            }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] in
                // TODO: 길상세페이지 넘기기
                print($0)
                // TODO: MOCK 데이터 지우기
                let webViewController = WebViewController(WebViewModel(for: .detail(roadId: "198")))
                webViewController.hidesBottomBarWhenPushed = true
                self?.tableView.deselectRow(at: $0, animated: true)
                self?.navigationController?.pushViewController(webViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        // 카테고리 셀
        viewModel.locations
            .bind(to: locationCollectionView.rx.items(cellIdentifier: CategoryTabCollectionView.cellIdentifier,
                                              cellType: CategoryTabCollectionViewCell.self)) { item, cellModel, cell in
                cell.configure(with: cellModel)
            }.disposed(by: disposeBag)
        
        // 카테고리 텝버튼 클릭시
        locationCollectionView.rx.itemSelected
            .map { $0.item }
            .bind(to: viewModel.selectedLocationIndex)
            .disposed(by: disposeBag)
        
    }
}


extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let word = viewModel.locations.value[indexPath.item]
        return locationCollectionView.cellSize(text: word)
    }
}
