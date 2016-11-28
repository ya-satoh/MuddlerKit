//
//  Reusable.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2016/11/28.
//  Copyright © 2016年 Kosuke Matsuda. All rights reserved.
//

import UIKit

///
/// MARK: - Reusable
///
public protocol Reusable {
    static var reusableIdentifier: String { get }
}


///
/// MARK: - ReusableView
///
public protocol ReusableView: Reusable {
    static var reusableIdentifier: String { get }
}

public extension ReusableView {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}


///
/// MARK: - UITableView
///
public extension UITableView {
    func registerNib<T: UITableViewCell>(_ type: T.Type) where T: ReusableView {
        let identifier = String(describing: T.reusableIdentifier)
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: identifier, bundle: bundle)
        register(nib, forCellReuseIdentifier: identifier)
    }

    func registerClass<T: UITableViewCell>(_ type: T.Type) where T: ReusableView {
        let identifier = String(describing: T.reusableIdentifier)
        register(T.self, forCellReuseIdentifier: identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T where T: ReusableView {
        let identifier = String(describing: type)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell: \(T.self) with identifier: \(T.reusableIdentifier).")
        }
        return cell
    }
}
