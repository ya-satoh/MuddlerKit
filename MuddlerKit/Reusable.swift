//
//  Reusable.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2016/11/28.
//  Copyright © 2016年 Kosuke Matsuda. All rights reserved.
//

import UIKit

// MARK: - Reusable

public protocol Reusable {
    static var reusableIdentifier: String { get }
}


// MARK: - ReusableView

public protocol ReusableView: Reusable {}

public extension ReusableView {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}


// MARK: - UITableView

public extension UITableView {
    func registerNib<T: UITableViewCell>(_ type: T.Type) where T: ReusableView {
        let identifier = T.reusableIdentifier
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: identifier, bundle: bundle)
        register(nib, forCellReuseIdentifier: identifier)
    }

    func registerClass<T: UITableViewCell>(_ type: T.Type) where T: ReusableView {
        let identifier = T.reusableIdentifier
        register(T.self, forCellReuseIdentifier: identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T where T: ReusableView {
        let identifier = T.reusableIdentifier
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell: \(T.self) with identifier: \(identifier).")
        }
        return cell
    }

    func registerNib<T: UITableViewHeaderFooterView>(_ type: T.Type) where T: ReusableView {
        let identifier = T.reusableIdentifier
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: identifier, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }

    func registerClass<T: UITableViewHeaderFooterView>(_ type: T.Type) where T: ReusableView {
        let identifier = T.reusableIdentifier
        register(T.self, forHeaderFooterViewReuseIdentifier: identifier)
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ type: T.Type) -> T where T: ReusableView {
        let identifier = T.reusableIdentifier
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
            fatalError("Could not dequeue HeaderFooterView: \(T.self) with identifier: \(identifier).")
        }
        return view
    }
}


// MARK: - UICollectionView

public extension UICollectionView {
    func registerNib<T: UICollectionViewCell>(_ type: T.Type) where T: ReusableView {
        let identifier = T.reusableIdentifier
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: identifier, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: identifier)
    }

    func registerClass<T: UICollectionViewCell>(_ type: T.Type) where T: ReusableView {
        let identifier = T.reusableIdentifier
        register(T.self, forCellWithReuseIdentifier: identifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T where T: ReusableView {
        let identifier = T.reusableIdentifier
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell: \(T.self) with identifier: \(identifier).")
        }
        return cell
    }
}


// MARK: - UINib

public extension UINib {
    class func instantiate<T: ReusableView>(_ type: T.Type) -> T {
        let identifier = T.reusableIdentifier
        let bundle: Bundle?
        if let klass = T.self as? AnyClass {
            bundle = Bundle(for: klass)
        } else {
            bundle = nil
        }
        let nib = UINib(nibName: identifier, bundle: bundle)
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? T else {
            fatalError("Could not load view: \(T.self) with identifier: \(identifier).")
        }
        return view
    }
}
