//
//  SearchCategoryResultViewController.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/02.
//

import UIKit
import RxCocoa
import RxSwift

final class SearchCategoryResultViewController: BaseViewController<SearchCategoryResultViewModel> {
    @IBOutlet private weak var naviBar: NaviBar!
    @IBOutlet private weak var tableView: UITableView!
    private let categoryCollectionView: CategoryTabCollectionView = CategoryTabCollectionView()
    private var tableViewHeaderView: UIView?
    private var tableViewHeaderViewTitleView = UIView()
    private let tableViewHeaderViewTitleLabel: UILabel = {
        let label = UILabel()
        label.setFont(.semiBold24)
        label.textColor = .gray900
        return label
    }()
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(.icon_angleBracket_left_gray900_24)
        return button
    }()
    
    private let headerHeight: CGFloat = 108 + 57
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 초기선택설정
        categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
    }
    
    private func setTableHeaderView() {
        tableViewHeaderView = UIView(frame: .init(x: 0, y: 0, width: tableView.frame.width, height: headerHeight))
        view.addSubview(tableViewHeaderView!)
        view.bringSubviewToFront(naviBar)
        tableViewHeaderView?.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(headerHeight)
        }
        
        tableViewHeaderView?.addSubViews(tableViewHeaderViewTitleView, categoryCollectionView)
        tableViewHeaderViewTitleView.addSubViews(backButton, tableViewHeaderViewTitleLabel)
        tableViewHeaderViewTitleView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(108)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        tableViewHeaderViewTitleLabel.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(38)
            $0.leading.equalToSuperview().offset(20)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(57)
        }
    }

    override func attribute() {
        super.attribute()
        naviBar.setBackItemImage()
        naviBar.isHidden = true
        tableView.contentInset = .init(top: headerHeight, left: 0, bottom: 0, right: 0)
        tableView.register(RoadTableViewCell.self)
        tableView.separatorStyle = .none
    }
    
    override func layout() {
        super.layout()
        setTableHeaderView()
    }

    override func bind() {
        super.bind()
        categoryCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        naviBar.rx.tapLeftItem
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.categoryName
            .bind(to: naviBar.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.categoryName
            .bind(to: tableViewHeaderViewTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        // 카테고리 셀
        viewModel.categoryWords
            .bind(to: categoryCollectionView.rx.items(cellIdentifier: CategoryTabCollectionView.cellIdentifier,
                                              cellType: CategoryTabCollectionViewCell.self)) { item, cellModel, cell in
                cell.configure(with: cellModel)
            }.disposed(by: disposeBag)
        
        // 카테고리 텝버튼 클릭시
        categoryCollectionView.rx.itemSelected
            .map { $0.item }
            .bind(to: viewModel.selectedCategory)
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
        
        // 헤더뷰 스크롤 효과
        tableView.rx.contentOffset
            .subscribe(onNext: { [weak self] in
                // -165(headerHeight)부터 스크롤시 +
                guard let self = self else { return }
                let posY = $0.y + self.headerHeight
                self.naviBar.isHidden = posY <= 70
                self.tableViewHeaderViewTitleView.alpha = 1 - posY / 70
                self.tableViewHeaderView?.transform = .init(translationX: 0, y:  posY <= 70 ? -posY : 40 - 108)
                self.tableView.scrollIndicatorInsets = .init(top: self.headerHeight - posY, left: 0, bottom: 0, right: 0)
            })
            .disposed(by: disposeBag)
    }
}

extension SearchCategoryResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let word = viewModel.categoryWords.value[indexPath.item]
        return categoryCollectionView.cellSize(text: word)
    }
}
