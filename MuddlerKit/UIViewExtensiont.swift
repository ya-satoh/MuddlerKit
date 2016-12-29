//
//  UIViewExtensiont.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2016/12/29.
//  Copyright © 2016年 Kosuke Matsuda. All rights reserved.
//

import UIKit

public extension UIView {
    // http://stackoverflow.com/a/36406508/226791
    var firstResponder: UIResponder? {
        if isFirstResponder { return self }
        for subview in subviews {
            if let responder = subview.firstResponder {
                return responder
            }
        }
        return nil
    }
}

public extension UIView {
    func detectView<T: UIView>(_ type: T.Type) -> T? {
        var target: T?
        var view: UIView? = self
        while let parent = view?.superview {
            if let c = parent as? T {
                target = c
                break
            }
            view = parent
        }
        return target
    }

    func detectTableViewCell() -> UITableViewCell? {
        return detectView(UITableViewCell.self)
    }
}
