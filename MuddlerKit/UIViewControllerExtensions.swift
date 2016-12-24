//
//  UIViewControllerExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit

public extension UIViewController {
    func peelAllPresentedViewControllers() {
        var presented = self.presentedViewController
        while presented?.presentedViewController != nil {
            presented = presented?.presentedViewController
        }
        presented?.peelViewController()
    }

    func peelViewController() {
        let presenting = self.presentingViewController
        self.dismiss(animated: false) {
            presenting?.peelViewController()
        }
    }

    func setExclusiveTouchToBarButtonItems() {
        var c: UIViewController? = self
        while c != nil && !(c is UINavigationController) {
            c = c?.parent
        }
        c?.setExclusiveTouchToBarButtonItems()
    }
}
