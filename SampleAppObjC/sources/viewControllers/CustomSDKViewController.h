//
//  CustomSDKViewController.h
//  SampleAppObjC
//
//  Copyright © 2017-2018 BEAR SAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BearSDK/BearSDK.h>

@interface CustomSDKViewController : BearViewControllerObjc<BearDelegate>

@property (nonatomic, assign) BOOL enableHistory;

@end
