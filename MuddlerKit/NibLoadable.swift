//
//  NibLoadable.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2016/11/28.
//  Copyright © 2016年 Kosuke Matsuda. All rights reserved.
//

import UIKit

public protocol NibLoadable: AnyObject {
    func nibName() -> String
    func bundle() -> Bundle
    func loadFromNib()
}

public extension NibLoadable {
    func nibName() -> String {
        return String(describing: type(of: self))
    }

    func bundle() -> Bundle {
        return Bundle(for: type(of: self))
    }

    func loadFromNib() {
        let nib = UINib(nibName: nibName(), bundle: bundle())
        nib.instantiate(withOwner: self, options: nil)
    }
}


///
/// 1. File's Owner connect this view class
/// 2. root view outlet contentView property
/// 3. call loadContentViewFromNib()
///    generally will be called in init(frame:), init?(coder:)
///
public protocol NibLoadableView: NibLoadable {
    var contentView: UIView! { get }
    func loadContentViewFromNib()
}

public extension NibLoadableView where Self: UIView {
    func loadContentViewFromNib() {
        loadFromNib()

        contentView.backgroundColor = UIColor.clear
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[view]|",
            options: [],
            metrics: nil,
            views: ["view": contentView])
        )
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[view]|",
            options: [],
            metrics: nil,
            views: ["view": contentView])
        )
    }
}
