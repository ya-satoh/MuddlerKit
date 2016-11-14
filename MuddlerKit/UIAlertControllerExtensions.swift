//
//  UIAlertControllerExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit

extension UIAlertController {
    public class func alertController(title: String? = nil, message: String?) -> Self {
        return self.init(title: title ?? "", message: message, preferredStyle: .alert)
    }
}

private var UIAlertControllerWindowKey: UInt8 = 0

//
// http://stackoverflow.com/a/30941356
//
extension UIAlertController {
    fileprivate var alertWindow: UIWindow? {
        get {
            return objc_getAssociatedObject(self, &UIAlertControllerWindowKey) as? UIWindow
        }
        set {
            objc_setAssociatedObject(self, &UIAlertControllerWindowKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.alertWindow?.isHidden = true
        self.alertWindow = nil
    }

    public func show(_ animated: Bool = true, completion: (() -> Void)? = nil) {
        let controller = UIViewController()
        controller.view.backgroundColor = UIColor.clear

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = controller
        window.backgroundColor = UIColor.clear
        window.windowLevel = UIWindowLevelAlert + 1
        window.makeKeyAndVisible()
        self.alertWindow = window

        controller.present(self, animated: animated, completion: completion)
    }
}
