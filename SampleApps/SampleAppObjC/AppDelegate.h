//
//  AppDelegate.h
//  SampleAppObjC
//
//  Copyright © 2016-2020 BEAR SAS. All rights reserved.
//

@import UIKit;
// required only if you want to use Push Notifications
// ******************************************
//@import Firebase;
// ******************************************

@interface AppDelegate : UIResponder <UIApplicationDelegate> //, FIRMessagingDelegate> // required only if you want to use Push Notifications

@property (strong, nonatomic) UIWindow* window;

@end

