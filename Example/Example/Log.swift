//
//  Log.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import Foundation

public func Log(body: Any? = nil, function: String = #function, file: String = #file, line: Int = #line) {
    Log(body == nil ? "" : body, function: function, file: file, line: line)
}

public func Log(@autoclosure body: () -> Any, function: String = #function, file: String = #file, line: Int = #line) {
#if DEBUG
    print("[\((file as NSString).lastPathComponent):\(line)] <\(function)> \(body())")
#endif
}
