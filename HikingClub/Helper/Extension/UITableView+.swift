//
//  UITableView+.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/03.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        let nibName = String(describing: T.self)
        if Bundle.main.path(forResource: nibName, ofType: "nib") != nil {
            let nib = UINib(nibName: nibName, bundle: nil)
            register(nib, forCellReuseIdentifier: nibName)
            return
        }
        register(T.self, forCellReuseIdentifier: nibName)
    }
    
    func register<T: UITableViewHeaderFooterView>(headerFooter: T.Type) {
        let nibName = String(describing: T.self)
        if Bundle.main.path(forResource: nibName, ofType: "nib") != nil {
            let nib = UINib(nibName: nibName, bundle: nil)
            register(nib, forHeaderFooterViewReuseIdentifier: nibName)
            return
        }
        register(T.self, forHeaderFooterViewReuseIdentifier: nibName)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(T.self, for: indexPath)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(String(describing: T.self))")
        }
        return cell
    }
}
