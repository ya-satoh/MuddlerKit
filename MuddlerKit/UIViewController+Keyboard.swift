//
//  UIViewController+Keyboard.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2016/12/29.
//  Copyright © 2016年 Kosuke Matsuda. All rights reserved.
//

import UIKit

// MARK: - AssociatedKeys

private struct AssociatedKeys {
    static var keyboardObservableScrollViewContentInset: UInt8 = 0
}


// MARK: - UIViewController

public extension UIViewController {
    private var keyboardObservableScrollViewContentInset: UIEdgeInsets {
        if let value = objc_getAssociatedObject(self, &AssociatedKeys.keyboardObservableScrollViewContentInset) as? NSValue {
            return value.uiEdgeInsetsValue
        } else {
            let value = keyboardObservableScrollView.contentInset
            objc_setAssociatedObject(
                self, &AssociatedKeys.keyboardObservableScrollViewContentInset,
                NSValue(uiEdgeInsets: value), objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC
            )
            return value
        }
    }

    var keyboardObservableScrollView: UIScrollView {
        fatalError("Should override \(#function)")
    }

    func addObserverForKeyboardNotifications() {
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                       name: Notification.Name.UIKeyboardWillShow, object: nil)
        nc.addObserver(self, selector: #selector(keyboardDidShow(notification:)),
                       name: Notification.Name.UIKeyboardDidShow, object: nil)
        nc.addObserver(self, selector: #selector(keyboardWillHide(notification:)),
                       name: Notification.Name.UIKeyboardWillHide, object: nil)
        nc.addObserver(self, selector: #selector(keyboardDidHide(notification:)),
                       name: Notification.Name.UIKeyboardDidHide, object: nil)
        nc.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)),
                       name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        nc.addObserver(self, selector: #selector(keyboardDidChangeFrame(notification:)),
                       name: Notification.Name.UIKeyboardDidChangeFrame, object: nil)
    }

    func removeObserverForKeyboardNotifications() {
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: nil)
        nc.removeObserver(self, name: Notification.Name.UIKeyboardDidShow, object: nil)
        nc.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil)
        nc.removeObserver(self, name: Notification.Name.UIKeyboardDidHide, object: nil)
        nc.removeObserver(self, name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        nc.removeObserver(self, name: Notification.Name.UIKeyboardDidChangeFrame, object: nil)
    }

    func keyboardWillShow(notification: Notification) {
        if let userInfo = notification.userInfo {
            let window = UIApplication.shared.keyWindow
            let keyboardEndFrameInScreen = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let keyboardEndFrameInWindow = window?.convert(keyboardEndFrameInScreen!, from: nil)
            let keyboardEndFrameInView = view.convert(keyboardEndFrameInWindow!, from: nil)
            let heightCoveredWithKeyboard = keyboardObservableScrollView.frame.maxY - keyboardEndFrameInView.minY

            var insets = keyboardObservableScrollViewContentInset
            insets.bottom = heightCoveredWithKeyboard
            keyboardObservableScrollView.scrollConsideredKeyboard(insets: insets, givenUserInfo: userInfo)

            if let responder = keyboardObservableScrollView.firstResponder as? UIView {
                let responderFrameInScrollView = responder.convert(responder.bounds,
                                                                   to: keyboardObservableScrollView)
                let keyboardEndFrameInScrollView = view.convert(keyboardEndFrameInView, to: keyboardObservableScrollView)
                if responderFrameInScrollView.maxY > keyboardEndFrameInScrollView.minY {
                    keyboardObservableScrollView.scrollRectToVisible(responderFrameInScrollView, animated: true)
                }
            }
        }
    }

    func keyboardDidShow(notification: NSNotification) {
    }

    func keyboardWillHide(notification: NSNotification) {
        let insets = keyboardObservableScrollViewContentInset
        keyboardObservableScrollView.scrollConsideredKeyboard(insets: insets, givenUserInfo: notification.userInfo)
    }

    func keyboardDidHide(notification: NSNotification) {
    }

    func keyboardWillChangeFrame(notification: NSNotification) {
    }

    func keyboardDidChangeFrame(notification: NSNotification) {
    }
}


// MARK: - UIScrollView

private extension UIScrollView {
    func scrollConsideredKeyboard(insets:UIEdgeInsets, givenUserInfo userInfo: [AnyHashable : Any]?) {
        if let userInfo = userInfo {
            let duration: TimeInterval
            if let value = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber {
                duration = value.doubleValue
            } else {
                duration = 0.25
            }
            let animationCurve: Int
            if let value = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber {
                animationCurve = value.intValue
            } else {
                animationCurve = UIViewAnimationCurve.easeInOut.rawValue
            }
            let animationOptions: UIViewAnimationOptions = UIViewAnimationOptions(rawValue: UInt(animationCurve << 16))
            UIView.animate(withDuration: duration, delay: 0, options: animationOptions, animations: {
                self.contentInset = insets
                self.scrollIndicatorInsets = insets
            }, completion: { (finished) in
                // completion
            })
        } else {
            contentInset = insets
            scrollIndicatorInsets = insets
        }
    }
}
