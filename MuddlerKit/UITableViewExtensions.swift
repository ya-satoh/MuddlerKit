//
//  UITableViewExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit

extension Extension where Base: UITableView {
    public func deselectRow() {
        if let indexPath = base.indexPathForSelectedRow {
            base.deselectRow(at: indexPath, animated: true)
        }
    }

    public func sizeToFitHeaderView() {
        guard let view = base.tableHeaderView else {
            return
        }
        base.mk.sizeToSystemLayoutFitView(view)
        base.tableHeaderView = view
    }

    public func sizeToFitFooterView() {
        guard let view = base.tableFooterView else {
            return
        }
        base.mk.sizeToSystemLayoutFitView(view)
        base.tableFooterView = view
    }

    private func sizeToSystemLayoutFitView(_ view: UIView) {
        view.setNeedsLayout()
        view.layoutIfNeeded()
        let size = view.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        var frame = view.frame
        frame.size.height = size.height
        view.frame = frame
    }
}
