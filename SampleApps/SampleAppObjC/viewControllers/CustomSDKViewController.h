//
//  CustomSDKViewController.h
//  SampleAppObjC
//
//  Copyright © 2017-2020 BEAR SAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BearSDK/BearSDK.h>

@interface CustomSDKViewController : ARViewControllerObjc<ARDelegate>

@property (nonatomic, assign) BOOL enableHistory;

@end
