//
//  UIApplicationExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit

extension UIApplication {
    public func activateUserNotificationSettings() {
        let types: UIUserNotificationType = [.Badge, .Alert, .Sound]
        let settings = UIUserNotificationSettings(forTypes: types, categories: nil)
        self.registerUserNotificationSettings(settings)
    }

    public func isEnableRemoteNotifications() -> Bool {
        guard self.isRegisteredForRemoteNotifications() else { return false }
        guard let settings = self.currentUserNotificationSettings() else { return false }
        return settings.types != .None
    }

    public func applicationIconBadgeNumberSafely(badgeNumber: Int) {
        guard let settings = currentUserNotificationSettings() else { return }
        if settings.types.contains(.Badge) {
            applicationIconBadgeNumber = badgeNumber
        }
    }
}
