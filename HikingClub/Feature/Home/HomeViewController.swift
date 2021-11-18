//
//  HomeViewController.swift
//  HikingClub
//
//  Created by 이문정 on 2021/10/02.
//

import UIKit
import RxCocoa
import RxSwift

final class HomeViewController: BaseViewController<HomeViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    private lazy var locationTabbar: CategoryTabCollectionView = {
        let tabbar = CategoryTabCollectionView()
        tabbar.backgroundColor = .gray100
        tabbar.contentInset = .init(top: 0, left: 16, bottom: 0, right: 70)
        tabbar.rx.setDelegate(self).disposed(by: disposeBag)
        return tabbar
    }()
    private lazy var locationMoreButtonContainerView: UIView = {
        let view = UIView(frame: .init(x: 0, y: 0, width: 68, height: 57))
        let leftColor = UIColor.gray100.withAlphaComponent(0).cgColor
        let rightColor = UIColor.gray100.cgColor
        view.addGradientXColor(colors: [leftColor, rightColor])
        return view
    }()
    private lazy var locationMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .gray900
        button.setImage(.icon_plus_gray900_24)
        return button
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // 초기선택설정
        locationTabbar.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
        
        viewModel.requestRoads()
    }
    
    override func attribute() {
        super.attribute()
        
        setTableView()
    }
    
    override func bind() {
        super.bind()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        // 길 리스트
        viewModel.roadDatas
            .bind(to: tableView.rx.items(cellIdentifier: "RoadTableViewCell",
                                         cellType: RoadTableViewCell.self)) { row, cellModel, cell in
                cell.configure(model: cellModel)
            }
                                         .disposed(by: disposeBag)
        
        // 상단 탭바
        viewModel.locations
            .bind(to: locationTabbar.rx.items(cellIdentifier: CategoryTabCollectionView.cellIdentifier,
                                      cellType: CategoryTabCollectionViewCell.self)) { item, cellModel, cell in
                cell.configure(with: cellModel, subTitle: item == 0 ? "현위치" : nil)
            }.disposed(by: disposeBag)
        
        // TODO: - 선택시 통신
        locationTabbar.rx.itemSelected
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        locationMoreButton.rx.tap
            .subscribe(onNext: {
                print("more 클릭")
            })
            .disposed(by: disposeBag)
        
        // FIXME: - 목데이터 삭제
        viewModel.mockData()
    }
    
    func setTableView() {
        tableView.register(RoadTableViewCell.self)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        guard let headerView = Bundle.main.loadNibNamed("HitThemeTableHeaderView", owner: nil, options: nil)?.first as? UIView else {
            return nil
        }
        
        containerView.addSubViews(headerView, locationTabbar, locationMoreButtonContainerView)
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(174)
        }
        
        locationTabbar.snp.remakeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(57)
            $0.bottom.equalToSuperview()
        }
        
        locationMoreButtonContainerView.snp.remakeConstraints {
            $0.trailing.equalTo(locationTabbar)
            $0.height.equalTo(locationTabbar)
            $0.width.equalTo(68)
            $0.centerY.equalTo(locationTabbar)
        }
        
        locationMoreButtonContainerView.addSubview(locationMoreButton)
        locationMoreButton.snp.remakeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        return containerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 231
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let word = viewModel.locations.value[indexPath.item]
        return locationTabbar.cellSize(title: word, subTitle: indexPath.item == 0 ? "현위치" : nil)
    }
}
