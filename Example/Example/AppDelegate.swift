//
//  AppDelegate.swift
//  Example
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Log("Log test")
        application.applicationIconBadgeNumberSafely(0)
        applicationWillRegisterForRemoteNotifications(application: application)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        application.applicationIconBadgeNumberSafely(0)
        applicationWillRegisterForRemoteNotifications(application: application)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    func initialSetup() {
        self.window?.rootViewController?.peelViewController()
        self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }
}

/// MARK: - APNs

extension AppDelegate {
    func applicationWillRegisterForRemoteNotifications(application: UIApplication) {
        application.activateUserNotificationSettings()
    }

    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
#if DEBUG
        NSLog("notificationSettings >>> %@", notificationSettings)
#endif
        let types = notificationSettings.types
        if types.rawValue == 0 {
        } else {
            application.registerForRemoteNotifications()
        }
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
#if DEBUG

#if (arch(arm) || arch(arm64)) && os(iOS)
        NSLog("error >>> \(error)")
#endif

        // stored directory with simulator
#if (arch(i386) || arch(x86_64)) && os(iOS)
        let nsError = error as NSError
        if nsError.domain == NSCocoaErrorDomain && nsError.code == 3010 {
            let token = "iostestdummydevicetoken"
            if let deviceToken = token.data(using: String.Encoding.utf8) {
                self.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
            }
        }
#endif

#endif
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
#if DEBUG
        Log("deviceToken [NSData] >>> \(deviceToken)")
#endif
        guard let token = String(deviceToken: deviceToken) else { return }
        Log("deviceToken [String] >>> \(token)")
#if DEBUG
        let queue = DispatchQueue.global()
        queue.async {
            do {
                let dir = NSTemporaryDirectory()
                let path = (dir as NSString).appendingPathComponent("devicetoken.txt")
                try token.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            } catch {}
        }
#endif
    }
}
