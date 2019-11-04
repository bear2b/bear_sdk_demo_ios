//
//  AppDelegate.swift
//  Sample App
//
//  Copyright © 2016-2018 BEAR SAS. All rights reserved.
//

import UIKit
import BearSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private let secretKey = """
        V1lUadG4dYEZgbIDUHURjAXaIvRx+H8/kT5/RE/zaLOptwPNhdAIh2Iid5EnndUn
        bbjhD14fLsc1RloCgFQ6kDliXPgg8VqBeL2yI+5jPdw/bHC4aWMuhRTEA83rXiQ+
        CPrQjsxbPdeYXvuJTPHXu8JGPhm7HGmKyzQ0RgBFMQmjxFr+AAWu4MPvOlV1haOM
        vL0SsbXpGXJthvAnVe4+LL+Gg8AWHixYHyCWwscf/kHu6ItXilVq3wWWgEqzNs+l
        IAohEy7kgeHHikqTdJqd6P30+f3F8XRHWKFq3VC/GV7LIeZGlmOgbP5/Bor690+b
        +FPPX/qkGKUxGd6lqrNLOIocwYD56dN4qMBOAbFwjPIIr7xvNZzsBO/Vf+J1gr7a
        sw0YUseFm43d/u3syxasRi7QrDtFo6aaL7Yn818gjGcHb/MD1GbOTmIYe10sjKas
        ry2Q4KTXYj0gCNZDSaNB7x2ighKK/o/rYFMn0AoUAfSr4X1o2EMliYZ8ElYno9CW
        +ryrWyHZYv9Z5gNcZX3Vj/Lrxg2c8vVjMER0sCdNFw6WBnuwZ1l0bwc94mBX4z/3
        GxthDNsswo9LqOe9LvoOcPQ428pG4yQF5vlDUpxHmo+kKkimLTqryCauZWR6OPwS
        JUuw8QGLM/+IYZGuOLSV+PzKbVL6+DwJWIH0K1XfJvG0eWWZvGJpZeACP9bnXCkv
        uZGD1ufhzKLOlKuthifUk/Cr5qGE9s0wE1Gmo0Q1fWDBocULJ73UBY80fWEaO0cV
        Kf+UPNKoEZxHGBOFrGPWWlzTvGgAbNcPrKiRIk1Y5f+grcVU6ugQFWtVdnOX8BCW
        MJpbd5gtO6nu1w2uC0QmsSBB/WOboowUk0NscHNdxr0=
    """

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        try! BearSDK.set(secretKey: secretKey)
        debugPrint("device id \(BearSDK.shared.deviceId)")
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
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        BearSDK.shared.registerDevice(withDeviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        application.registerForRemoteNotifications()
    }
}
