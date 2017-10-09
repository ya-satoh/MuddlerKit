//
//  UIWebViewExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit

extension Extension where Base: UIWebView {
    public func userAgent() -> String {
        return base.stringByEvaluatingJavaScript(from: "navigator.userAgent")!
    }
}
