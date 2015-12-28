//
//  UINavigationControllerExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit

extension UINavigationController {
    public override func peelViewController() {
        self.popToRootViewControllerAnimated(false)
        self.visibleViewController?.peelViewController()
    }

    public override func setExclusiveTouchToBarButtonItems() {
        self.navigationBar.subviews.forEach {
            if $0 is UIButton {
                $0.exclusiveTouch = true
            }
        }
    }
}
