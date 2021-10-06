//
//  UICollectionView+.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/03.
//


import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) {
        let nibName = String(describing: T.self)
        if Bundle.main.path(forResource: nibName, ofType: "nib") != nil {
            let nib = UINib(nibName: nibName, bundle: nil)
            register(nib, forCellWithReuseIdentifier: nibName)
            return
        }
        register(T.self, forCellWithReuseIdentifier: nibName)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(T.self, for: indexPath)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(String(describing: T.self))")
        }
        return cell
    }
}

