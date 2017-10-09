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
extension HTTPCookieStorage {
    public func archivedData() -> Data? {
        guard let cookies = self.cookies else { return nil }
        return NSKeyedArchiver.archivedData(withRootObject: cookies)
    }

    public func unarchive(data: Data) {
        guard let cookies = NSKeyedUnarchiver.unarchiveObject(with: data) as? [HTTPCookie] else {
            return
        }
        cookies.forEach { setCookie($0) }
    }
}

//
// MARK: - clear
//
extension HTTPCookieStorage {
    public func clearAll() {
        guard let cookies = self.cookies else { return }
        for cookie in cookies {
            clearCookie(cookie)
        }
    }

    public func clear(forURL url: URL) {
        guard let cookies = self.cookies(for: url) else { return }
        for cookie in cookies {
            clearCookie(cookie)
        }
    }

    ///
    /// http://mmasashi.hatenablog.com/entry/20101202/1292763345
    ///
    public func clearCookie(_ cookie: HTTPCookie) {
        guard var property = cookie.properties else {
            deleteCookie(cookie)
            return
        }
        deleteCookie(cookie)
        property[HTTPCookiePropertyKey.expires] = Date(timeIntervalSinceNow: -3600)
        if let newCookie = HTTPCookie(properties: property) {
            setCookie(newCookie)
        }
    }
}

//
// MARK: - unavailable
//
extension HTTPCookieStorage {

    // instance methods

    @nonobjc
    @available(*, unavailable, renamed: "clear(forURL:)")
    public func clearForURL(_ url: URL) {
        fatalError()
    }

    @available(*, unavailable)
    public func clear(_ cookies: [HTTPCookie]) {
        fatalError()
    }

    @available(*, unavailable)
    public func clean(_ cookie: HTTPCookie) {
        fatalError()
    }

    // class methods

    @available(*, unavailable)
    public class func archivedData() -> Data? {
        fatalError()
    }

    @available(*, unavailable)
    public class func unarchiveWithData(_ data: Data?) {
        fatalError()
    }

    @available(*, unavailable)
    public class func clearAll() {
        fatalError()
    }

    @available(*, unavailable)
    public class func clearForURL(_ url: URL) {
        fatalError()
    }

    @available(*, unavailable)
    public class func clear(_ cookies: [HTTPCookie]) {
        fatalError()
    }

    @available(*, unavailable)
    public class func clean(_ cookie: HTTPCookie) {
        fatalError()
    }

    // archive & unarchive

    @nonobjc
    @available(*, unavailable, renamed: "unarchive(data:)")
    public func unarchiveWithData(_ data: Data?) {
        fatalError()
    }

    // UserDefaults

    @available(*, unavailable)
    public func saveToUserDefaultsForKey(_ key: String) -> Bool {
        fatalError()
    }

    @available(*, unavailable)
    public func loadFromUserDefaultsForKey(_ key: String) {
        fatalError()
    }

    @available(*, unavailable)
    public class func saveToUserDefaultsForKey(_ key: String) -> Bool {
        fatalError()
    }

    @available(*, unavailable)
    public class func loadFromUserDefaultsForKey(_ key: String) {
        fatalError()
    }
}
