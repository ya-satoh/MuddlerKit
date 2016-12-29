//
//  UITableViewExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit

public extension UITableView {
    func deselectRow() {
        if let indexPath = self.indexPathForSelectedRow {
            self.deselectRow(at: indexPath, animated: true)
        }
    }

    func sizeToFitHeaderView() {
        guard let view = tableHeaderView else {
            return
        }
        sizeToSystemLayoutFitView(view)
    }

    func sizeToFitFooterView() {
        guard let view = tableFooterView else {
            return
        }
        sizeToSystemLayoutFitView(view)
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
