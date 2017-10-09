//
//  UIAlertControllerExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit

//
// MARK: - UIAlertController
//
extension UIAlertController {
    public class func alertController(title: String? = nil, message: String?) -> Self {
        return self.init(title: title ?? "", message: message, preferredStyle: .alert)
    }

    public func addOKAction(handler: ((UIAlertAction) -> Void)? = nil) {
        addAction(UIAlertAction.ok(handler: handler))
    }

    public func addCancelAction(handler: ((UIAlertAction) -> Void)? = nil) {
        addAction(UIAlertAction.cancel(handler: handler))
    }
}



/// present based on the window
/// http://stackoverflow.com/a/30941356
///

private var UIAlertControllerWindowKey: UInt8 = 0

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


//
// MARK: - UIAlertAction
//
extension UIAlertAction {
    class func ok(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .default, handler: handler)
    }

    class func cancel(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: handler)
    }
}
