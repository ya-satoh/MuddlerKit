//
//  UIViewControllerExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit

extension UIViewController {
    public func peelAllPresentedViewControllers() {
        var presented = self.presentedViewController
        while presented?.presentedViewController != nil {
            presented = presented?.presentedViewController
        }
        presented?.peelViewController()
    }

    public func peelViewController() {
        let presenting = self.presentingViewController
        self.dismiss(animated: false) {
            presenting?.peelViewController()
        }
    }

    public func setExclusiveTouchToBarButtonItems() {
        var c: UIViewController? = self
        while c != nil && !(c is UINavigationController) {
            c = c?.parent
        }
        c?.setExclusiveTouchToBarButtonItems()
    }
}
