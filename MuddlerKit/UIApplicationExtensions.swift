//
//  UIApplicationExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit

extension Extension where Base: UIApplication {
    public func activateUserNotificationSettings() {
        let types: UIUserNotificationType = [.badge, .alert, .sound]
        let settings = UIUserNotificationSettings(types: types, categories: nil)
        base.registerUserNotificationSettings(settings)
    }

    public func isEnableRemoteNotifications() -> Bool {
        guard base.isRegisteredForRemoteNotifications else { return false }
        guard let settings = base.currentUserNotificationSettings else { return false }
        return settings.types != UIUserNotificationType()
    }

    public func applicationIconBadgeNumberSafely(_ badgeNumber: Int) {
        guard let settings = base.currentUserNotificationSettings else { return }
        if settings.types.contains(.badge) {
            base.applicationIconBadgeNumber = badgeNumber
        }
    }
}
