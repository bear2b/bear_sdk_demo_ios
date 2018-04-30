//
//  AppDelegate.m
//  SampleAppObjC
//
//  Copyright © 2016-2018 BEAR SAS. All rights reserved.
//

#import "AppDelegate.h"
#import <BearSDK/BearSDK.h>

@interface AppDelegate () {
    NSString* secretKey;
}

@end

@implementation AppDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        secretKey = @"V1lUadG4dYEZgbIDUHURjAXaIvRx+H8/kT5/RE/zaLOptwPNhdAIh2Iid5EnndUn\
        bbjhD14fLsc1RloCgFQ6kDliXPgg8VqBeL2yI+5jPdw/bHC4aWMuhRTEA83rXiQ+\
        CPrQjsxbPdeYXvuJTPHXu8JGPhm7HGmKyzQ0RgBFMQmjxFr+AAWu4MPvOlV1haOM\
        vL0SsbXpGXJthvAnVe4+LL+Gg8AWHixYHyCWwscf/kHu6ItXilVq3wWWgEqzNs+l\
        IAohEy7kgeHHikqTdJqd6P30+f3F8XRHWKFq3VC/GV7LIeZGlmOgbP5/Bor690+b\
        +FPPX/qkGKUxGd6lqrNLOIocwYD56dN4qMBOAbFwjPIIr7xvNZzsBO/Vf+J1gr7a\
        sw0YUseFm43d/u3syxasRi7QrDtFo6aaL7Yn818gjGcHb/MD1GbOTmIYe10sjKas\
        ry2Q4KTXYj0gCNZDSaNB7x2ighKK/o/rYFMn0AoUAfSr4X1o2EMliYZ8ElYno9CW\
        +ryrWyHZYv9Z5gNcZX3Vj/Lrxg2c8vVjMER0sCdNFw6WBnuwZ1l0bwc94mBX4z/3\
        GxthDNsswo9LqOe9LvoOcPQ428pG4yQF5vlDUpxHmo+kKkimLTqryCauZWR6OPwS\
        JUuw8QGLM/+IYZGuOLSV+PzKbVL6+DwJWIH0K1XfJvG0eWWZvGJpZeACP9bnXCkv\
        uZGD1ufhzKLOlKuthifUk/Cr5qGE9s0wE1Gmo0Q1fWDBocULJ73UBY80fWEaO0cV\
        Kf+UPNKoEZxHGBOFrGPWWlzTvGgAbNcPrKiRIk1Y5f+grcVU6ugQFWtVdnOX8BCW\
        MJpbd5gtO6nu1w2uC0QmsSBB/WOboowUk0NscHNdxr0=";
    }
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSError* error = nil;
    [BearSDK setWithSecretKey:secretKey error:&error];
    NSInteger deviceId = [[BearSDK shared] deviceId];
    NSLog(@"Device id = %li", (long)deviceId);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
