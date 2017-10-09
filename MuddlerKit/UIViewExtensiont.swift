//
//  UIViewExtensiont.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2016/12/29.
//  Copyright © 2016年 Kosuke Matsuda. All rights reserved.
//

import UIKit

extension Extension where Base: UIView {
    // http://stackoverflow.com/a/36406508/226791
    public var firstResponder: UIResponder? {
        if base.isFirstResponder { return base }
        for subview in base.subviews {
            if let responder = subview.mk.firstResponder {
                return responder
            }
        }
        return nil
    }
}

extension Extension where Base: UIView {
    public func detectView<T: UIView>(_ type: T.Type) -> T? {
        var target: T?
        var view: UIView? = base
        while let parent = view?.superview {
            if let c = parent as? T {
                target = c
                break
            }
            view = parent
        }
        return target
    }

    public func detectTableViewCell() -> UITableViewCell? {
        return detectView(UITableViewCell.self)
    }
}
