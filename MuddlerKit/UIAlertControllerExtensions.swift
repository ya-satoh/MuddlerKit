//
//  UIAlertControllerExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit

extension UIAlertController {
    public class func alertController(title title: String? = nil, message: String?) -> Self {
        return self.init(title: title ?? "", message: message, preferredStyle: .Alert)
    }
}

private var UIAlertControllerWindowKey: UInt8 = 0

//
// http://stackoverflow.com/a/30941356
//
extension UIAlertController {
    private var alertWindow: UIWindow? {
        get {
            return objc_getAssociatedObject(self, &UIAlertControllerWindowKey) as? UIWindow
        }
        set {
            objc_setAssociatedObject(self, &UIAlertControllerWindowKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)

        self.alertWindow?.hidden = true
        self.alertWindow = nil
    }

    public func show(animated: Bool = true, completion: (() -> Void)? = nil) {
        let controller = UIViewController()
        controller.view.backgroundColor = UIColor.clearColor()

        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.rootViewController = controller
        window.backgroundColor = UIColor.clearColor()
        window.windowLevel = UIWindowLevelAlert + 1
        window.makeKeyAndVisible()
        self.alertWindow = window

        controller.presentViewController(self, animated: animated, completion: completion)
    }
}
