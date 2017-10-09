//
//  UIViewControllerExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit

extension UIViewController {
    @objc public func peelAllPresentedViewControllers() {
        var presented = self.presentedViewController
        while presented?.presentedViewController != nil {
            presented = presented?.presentedViewController
        }
        presented?.peelViewController()
    }

    @objc public func peelViewController() {
        let presenting = self.presentingViewController
        self.dismiss(animated: false) {
            presenting?.peelViewController()
        }
    }

    @objc public func setExclusiveTouchToBarButtonItems() {
        var c: UIViewController? = self
        while c != nil && !(c is UINavigationController) {
            c = c?.parent
        }
        c?.setExclusiveTouchToBarButtonItems()
    }
}


// MARK: -

extension UIViewController {
    /// Manually adjust its scroll view insets.
    /// reference to `automaticallyAdjustsScrollViewInsets`.
    /// `automaticallyAdjustsScrollViewInsets` is only invoked when the scrollView is first child view.
    /// So for example, in case that the scrollVie is not first child view or
    /// the view controller has two scrollView.
    ///
    /// - paramter scrollView: The ScrollView to adjust
    @objc public func manuallyAdjustsScrollViewInsetsAndOffset(_ scrollView: UIScrollView) {
        guard automaticallyAdjustsScrollViewInsets else {
            return
        }
        let currentInsets = scrollView.contentInset
        var insets = currentInsets
        /*
        var parent: UIViewController? = self.parent
        while (parent != nil) {
            parent = parent?.parent
        }
        if let parent = parent {
            insets.top = parent.topLayoutGuide.length
            insets.bottom = parent.bottomLayoutGuide.length
        } else {
            insets.top = topLayoutGuide.length
            insets.bottom = bottomLayoutGuide.length
        }
        */
        insets.top = topLayoutGuide.length
        insets.bottom = bottomLayoutGuide.length
        if (!UIEdgeInsetsEqualToEdgeInsets(currentInsets, insets)) {
            scrollView.contentInset = insets
            scrollView.scrollIndicatorInsets = insets

            // iOS8でcontentOffsetが調整されないのを対処
            if UIDevice.current.systemVersion.compare("8.0", options: .numeric) != .orderedAscending {
                scrollView.setContentOffset(CGPoint(x: 0, y: -insets.top), animated: false)
            }
        }
    }
}
