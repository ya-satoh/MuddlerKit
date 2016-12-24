//
//  UITabBarControllerExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit

public extension UITabBarController {
    override func peelViewController() {
        if let cs = self.viewControllers {
            for c in cs {
                if c == self.selectedViewController {
                    continue
                }
                c.peelViewController()
            }
        }
        self.selectedViewController?.peelViewController()
        super.peelViewController()
    }
}
