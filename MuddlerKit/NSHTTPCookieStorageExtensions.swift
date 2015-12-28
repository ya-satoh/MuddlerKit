//
//  NSHTTPCookieStorageExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import Foundation

extension NSHTTPCookieStorage {
    public func archivedData() -> NSData? {
        guard let cookies = self.cookies else { return nil }
        return NSKeyedArchiver.archivedDataWithRootObject(cookies)
    }

    public func unarchiveWithData(data: NSData?) {
        guard let d = data else { return }
        guard let cookies = NSKeyedUnarchiver.unarchiveObjectWithData(d) as? [NSHTTPCookie] else {
            return
        }
        cookies.forEach { setCookie($0) }
    }

    public func clearAll() {
        guard let cookies = self.cookies else { return }
        clear(cookies)
    }

    func clearForURL(url: NSURL) {
        guard let cookies = self.cookiesForURL(url) else { return }
        clear(cookies)
    }

    public func clear(cookies: [NSHTTPCookie]) {
        for cookie in cookies {
            clean(cookie)
        }
    }

    /*
     * http://mmasashi.hatenablog.com/entry/20101202/1292763345
     */
    public func clean(cookie: NSHTTPCookie) {
        guard var property = cookie.properties else {
            deleteCookie(cookie)
            return
        }
        deleteCookie(cookie)
        property[NSHTTPCookieExpires] = NSDate(timeIntervalSinceNow: -3600)
        if let newCookie = NSHTTPCookie(properties: property) {
            setCookie(newCookie)
        }
    }

    public class func archivedData() -> NSData? {
        return sharedHTTPCookieStorage().archivedData()
    }

    public class func unarchiveWithData(data: NSData?) {
        sharedHTTPCookieStorage().unarchiveWithData(data)
    }

    public class func clearAll() {
        sharedHTTPCookieStorage().clearAll()
    }

    public class func clearForURL(url: NSURL) {
        sharedHTTPCookieStorage().clearForURL(url)
    }

    public class func clear(cookies: [NSHTTPCookie]) {
        sharedHTTPCookieStorage().clear(cookies)
    }

    public class func clean(cookie: NSHTTPCookie) {
        sharedHTTPCookieStorage().clean(cookie)
    }
}

//
// MARK: - NSUserDefaults
//
extension NSHTTPCookieStorage {
    public func saveToUserDefaultsForKey(key: String) -> Bool {
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(archivedData(), forKey: key)
        return ud.synchronize()
    }

    public func loadFromUserDefaultsForKey(key: String) {
        let ud = NSUserDefaults.standardUserDefaults()
        guard let data = ud.dataForKey(key) else { return }
        unarchiveWithData(data)
    }

    public class func saveToUserDefaultsForKey(key: String) -> Bool {
        return sharedHTTPCookieStorage().saveToUserDefaultsForKey(key)
    }

    public class func loadFromUserDefaultsForKey(key: String) {
        sharedHTTPCookieStorage().loadFromUserDefaultsForKey(key)
    }
}
