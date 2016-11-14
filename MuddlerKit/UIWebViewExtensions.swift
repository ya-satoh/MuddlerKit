//
//  UIWebViewExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit

extension UIWebView {
    public func userAgent() -> String {
        return self.stringByEvaluatingJavaScript(from: "navigator.userAgent")!
    }
}
