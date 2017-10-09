//
//  NSHTTPCookieStorageExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import Foundation

//
// MARK: - archive & unarchive
//
extension Extension where Base: HTTPCookieStorage {
    public func archivedData() -> Data? {
        guard let cookies = base.cookies else { return nil }
        return NSKeyedArchiver.archivedData(withRootObject: cookies)
    }

    public func unarchive(data: Data) {
        guard let cookies = NSKeyedUnarchiver.unarchiveObject(with: data) as? [HTTPCookie] else {
            return
        }
        cookies.forEach { base.setCookie($0) }
    }
}

//
// MARK: - clear
//
extension Extension where Base: HTTPCookieStorage {
    public func clearAll() {
        guard let cookies = base.cookies else { return }
        for cookie in cookies {
            base.mk.clearCookie(cookie)
        }
    }

    public func clear(forURL url: URL) {
        guard let cookies = base.cookies(for: url) else { return }
        for cookie in cookies {
            base.mk.clearCookie(cookie)
        }
    }

    ///
    /// http://mmasashi.hatenablog.com/entry/20101202/1292763345
    ///
    public func clearCookie(_ cookie: HTTPCookie) {
        guard var property = cookie.properties else {
            base.deleteCookie(cookie)
            return
        }
        base.deleteCookie(cookie)
        property[HTTPCookiePropertyKey.expires] = Date(timeIntervalSinceNow: -3600)
        if let newCookie = HTTPCookie(properties: property) {
            base.setCookie(newCookie)
        }
    }
}
