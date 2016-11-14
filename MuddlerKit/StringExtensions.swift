//
//  StringExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import Foundation

extension String {
    // http://stackoverflow.com/a/24979960
    public init?(deviceToken: NSData) {
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        (0..<deviceToken.length).indices.forEach { (i) in
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        self = tokenString
    }

    /*
    // http://stackoverflow.com/a/30017241
    public init?(deviceToken: NSData) {
        let characterSet = NSCharacterSet(charactersInString: "<>")
        self = (deviceToken.description as NSString)
            .stringByTrimmingCharactersInSet(characterSet)
            .stringByReplacingOccurrencesOfString(" ", withString: "") as String
    }
    */
}
