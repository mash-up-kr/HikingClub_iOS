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
    private let safeAreaTopView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    @IBOutlet private weak var naviBar: NaviBar!
    @IBOutlet private weak var tableView: UITableView!
    private let categoryCollectionView: CategoryTabCollectionView = CategoryTabCollectionView()
    private var tableViewHeaderView: UIView?
    private lazy var tableViewHeaderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = self.viewModel.categoryWords.value[viewModel.selectedCategory.value].key.themeImage(scale: .large)
        imageView.clipsToBounds = true
        return imageView
    }()
    private var tableViewHeaderViewTitleView = UIView()
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(.icon_angleBracket_left_gray900_24)
        return button
    }()
    
    private let titleHeaderViewHeight: CGFloat = 152
    private let tabbarHeight: CGFloat = 57
    private lazy var headerViewHeight: CGFloat = titleHeaderViewHeight + tabbarHeight
    private lazy var emptyView: EmptyView = EmptyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 초기선택설정
        categoryCollectionView.selectItem(at: IndexPath(item: viewModel.selectedCategory.value, section: 0), animated: false, scrollPosition: .left)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryCollectionView.scrollToItem(at: IndexPath(item: viewModel.selectedCategory.value, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    private func setTableHeaderView() {
        view.addSubview(safeAreaTopView)
        safeAreaTopView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(naviBar.snp.top)
        }
        
        tableViewHeaderView = UIView(frame: .init(x: 0, y: 0, width: tableView.frame.width, height: headerViewHeight))
        view.addSubview(tableViewHeaderView!)
        view.bringSubviewToFront(naviBar)
        
        tableViewHeaderView?.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.snp.top)
            $0.height.equalTo(headerViewHeight)
        }
        
        tableViewHeaderView?.addSubViews(tableViewHeaderViewTitleView, categoryCollectionView)
        tableViewHeaderViewTitleView.addSubViews(tableViewHeaderImageView, backButton)
        tableViewHeaderViewTitleView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(titleHeaderViewHeight)
        }
        
        tableViewHeaderImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(52)
            $0.leading.equalToSuperview().offset(16)
        }
    
        categoryCollectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(tabbarHeight)
        }
    }

    override func attribute() {
        super.attribute()
        naviBar.setBackItemImage()
        naviBar.isHidden = true
        tableView.contentInset = .init(top: headerViewHeight, left: 0, bottom: 0, right: 0)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = .zero
        }
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(RoadTableViewCell.self)
        tableView.separatorStyle = .none
        categoryCollectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 5)
        
        emptyView.isHidden = true
        emptyView.backgroundColor = .clear
    }
    
    override func layout() {
        super.layout()
        setTableHeaderView()
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
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
        
        viewModel.currentCategory
            .map { $0.name }
            .bind(to: naviBar.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.currentCategory
            .map { $0.key }
            .subscribe(onNext: { [weak self] in
                self?.tableViewHeaderImageView.image = $0.themeImage(scale: .large)
            })
            .disposed(by: disposeBag)
        
        // 카테고리 셀
        viewModel.categoryWords
            .bind(to: categoryCollectionView.rx.items(cellIdentifier: CategoryTabCollectionView.cellIdentifier,
                                              cellType: CategoryTabCollectionViewCell.self)) { item, cellModel, cell in
                cell.configure(with: cellModel.name)
            }.disposed(by: disposeBag)
        
        viewModel.roadDatas
            .map { !$0.isEmpty }
            .bind(to: emptyView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.roadDatas
            .map { !$0.isEmpty }
            .bind(to: tableView.rx.isScrollEnabled)
            .disposed(by: disposeBag)
        
        // 카테고리 텝버튼 클릭시
        categoryCollectionView.rx.itemSelected
            .map { $0.item }
            .bind(to: viewModel.selectedCategory)
            .disposed(by: disposeBag)
        
        // 길정보 셀
        viewModel.roadDatas
            .bind(to: tableView.rx.items(cellIdentifier: "RoadTableViewCell",
                                         cellType: RoadTableViewCell.self)) { row, cellModel, cell in
                cell.configure(model: cellModel)
            }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] in
                self?.navigateToRoadWebViewController($0)
                self?.tableView.deselectRow(at: $0, animated: true)
            })
            .disposed(by: disposeBag)
        
        // 헤더뷰 스크롤 효과
        tableView.rx.contentOffset
            .subscribe(onNext: { [weak self] in
                // -(headerViewHeight)부터 스크롤시 +
                guard let self = self else { return }
                let posY = $0.y + self.headerViewHeight
                let naviBarBottomPos: CGFloat = 84
                self.naviBar.isHidden = posY <= naviBarBottomPos
                self.tableViewHeaderViewTitleView.alpha = 1 - posY / naviBarBottomPos
                self.tableViewHeaderView?.transform = .init(translationX: 0, y:  posY <= naviBarBottomPos ? -posY : naviBarBottomPos - self.titleHeaderViewHeight)
                self.tableView.scrollIndicatorInsets = .init(top: self.headerViewHeight - posY, left: 0, bottom: 0, right: 0)
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToRoadWebViewController(_ indexPath: IndexPath) {
        let roadId = viewModel.roadDatas.value[indexPath.row].id
        let webViewController = WebViewController(WebViewModel(for: .detail(roadId: roadId)))
        webViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(webViewController, animated: true)
    }
}

extension SearchCategoryResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let word = viewModel.categoryWords.value[indexPath.item].name
        return categoryCollectionView.cellSize(title: word)
    }
}
