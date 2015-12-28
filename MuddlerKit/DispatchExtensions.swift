//
//  DispatchExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import Foundation

/// MARK: GCD shorthand

public func dispatch_async_main_safely(block: () -> Void) {
    if NSThread.isMainThread() {
        block()
    } else {
        dispatch_async(dispatch_get_main_queue(), block)
    }
}

public func dispatch_async_main_after_time(time: Double, block: () -> Void) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))),
        dispatch_get_main_queue(), block)
}
