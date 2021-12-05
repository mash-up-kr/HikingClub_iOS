//
//  InquiryViewController.swift
//  HikingClub
//
//  Created by 이문정 on 2021/11/14.
//

import UIKit

class InquiryViewController: BaseViewController<inquiryMenuViewModel> {
    private let navigationBar: NaviBar = {
        let view = NaviBar()
        view.setTitle("공지사항")
        view.setBackItemImage()
        
        return view
    }()
    
    private let scrollView = UIScrollView()
    
    private let scrollContentsView = UIView()
    
    private let menuStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
}
