//
//  UINavigationControllerExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit

public extension UINavigationController {
    override func peelViewController() {
        self.popToRootViewController(animated: false)
        self.visibleViewController?.peelViewController()
    }

    override func setExclusiveTouchToBarButtonItems() {
        self.navigationBar.subviews.forEach {
            if $0 is UIButton {
                $0.isExclusiveTouch = true
            }
        }
    }
}
