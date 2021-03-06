//
//  SelectTownViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/06.
//

import UIKit
import RxSwift

final class SelectTownViewController: BaseViewController<SelectTownViewModel> {
    private let navigationBar: NaviBar = {
        let view = NaviBar()
        view.setTitle("동네설정")
        view.setBackItemImage()
        return view
    }()
    private lazy var searchTextfield: NDSearchTextField = {
        let view = NDSearchTextField()
        view.setPlaceholder("동면(읍,면)으로 검색")
        view.setReturnKeyType(.done)
        view.rx.setDelegate(self).disposed(by: disposeBag)
        return view
    }()
    private let searchCurrnetLocationButton: NDButton = {
        let button = NDButton(theme: .init(.fillGreen))
        button.setTitle("현재위치로 찾기", for: .normal)
        return button
    }()
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        let label = UILabel()
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(20)
        }
        label.text = "근처동네"
        label.setFont(.regular13)
        label.textColor = .green700
        return view
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SelectTownTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 46
        tableView.separatorInset = .zero
        
        return tableView
    }()
    
    // MARK: - Layout
    
    override func layout() {
        super.layout()
        view.addSubViews(navigationBar, searchTextfield, searchCurrnetLocationButton, headerView, tableView)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        searchTextfield.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            
            $0.height.equalTo(48)
        }
        searchCurrnetLocationButton.snp.makeConstraints {
            $0.top.equalTo(searchTextfield.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            
            $0.height.equalTo(44)
        }
        headerView.snp.makeConstraints {
            $0.top.equalTo(searchCurrnetLocationButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view)
        }
    }
    
    override func bind() {
        super.bind()
        navigationBar.rx.tapLeftItem
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        searchTextfield.rx.text
            .distinctUntilChanged()
            .skip(1)
            .do(onNext: { [weak self] in
                self?.searchTextfield.rx.isCancelHidden.onNext($0.isEmpty)
            })
            .debounce(.milliseconds(350), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.searchTown($0)
                
            })
            .disposed(by: disposeBag)
        
        searchCurrnetLocationButton.rx.tap
            .filter {
                if NDLocationManager.shared.locationAuthStatus == .authorizedWhenInUse ||
                    NDLocationManager.shared.locationAuthStatus == .authorizedAlways {
                    return true
                } else {
                    NDLocationManager.shared.requestLocationAuth { [weak self] in
                        self?.viewModel.searchTownWithCurrentLocation()
                    }
                    return false
                }
            }
            .subscribe(onNext: { [weak self] in
                self?.viewModel.searchTownWithCurrentLocation()
            })
            .disposed(by: disposeBag)
                
        // MARK: - ViewModel Binding
        
        viewModel.searchedTownListRelay
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
                
        viewModel.selectedTownRelay
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension SelectTownViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension SelectTownViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectTown(indexPath)
    }
}

extension SelectTownViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchedTownListRelay.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(SelectTownTableViewCell.self, for: indexPath)
        let townAddress = viewModel.searchedTownListRelay.value[indexPath.row].fullAddress
        cell.setTownName(townAddress)
        return cell
    }
}
