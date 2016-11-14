//
//  NSHTTPCookieStorageExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import Foundation

extension HTTPCookieStorage {
    public func archivedData() -> Data? {
        guard let cookies = self.cookies else { return nil }
        return NSKeyedArchiver.archivedData(withRootObject: cookies)
    }

    public func unarchiveWithData(_ data: Data?) {
        guard let d = data else { return }
        guard let cookies = NSKeyedUnarchiver.unarchiveObject(with: d) as? [HTTPCookie] else {
            return
        }
        cookies.forEach { setCookie($0) }
    }

    public func clearAll() {
        guard let cookies = self.cookies else { return }
        clear(cookies)
    }

    func clearForURL(_ url: URL) {
        guard let cookies = self.cookies(for: url) else { return }
        clear(cookies)
    }

    public func clear(_ cookies: [HTTPCookie]) {
        for cookie in cookies {
            clean(cookie)
        }
    }

    /*
     * http://mmasashi.hatenablog.com/entry/20101202/1292763345
     */
    public func clean(_ cookie: HTTPCookie) {
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

    public class func archivedData() -> Data? {
        return shared.archivedData()
    }

    public class func unarchiveWithData(_ data: Data?) {
        shared.unarchiveWithData(data)
    }

    public class func clearAll() {
        shared.clearAll()
    }

    public class func clearForURL(_ url: URL) {
        shared.clearForURL(url)
    }

    public class func clear(_ cookies: [HTTPCookie]) {
        shared.clear(cookies)
    }

    public class func clean(_ cookie: HTTPCookie) {
        shared.clean(cookie)
    }
}

//
// MARK: - NSUserDefaults
//
extension HTTPCookieStorage {
    public func saveToUserDefaultsForKey(_ key: String) -> Bool {
        let ud = UserDefaults.standard
        ud.set(archivedData(), forKey: key)
        return ud.synchronize()
    }

    public func loadFromUserDefaultsForKey(_ key: String) {
        let ud = UserDefaults.standard
        guard let data = ud.data(forKey: key) else { return }
        unarchiveWithData(data)
    }

    public class func saveToUserDefaultsForKey(_ key: String) -> Bool {
        return shared.saveToUserDefaultsForKey(key)
    }

    public class func loadFromUserDefaultsForKey(_ key: String) {
        shared.loadFromUserDefaultsForKey(key)
    }
}
