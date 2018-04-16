//
//  BearViewControllerObjc.h
//  BearSDK
//
//  Copyright © 2017-2018 BEAR SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BearHandlerProtocol;
@protocol BearDelegate;

/**
 The BearViewControllerObjc provides a infrastructure for your application to manage BearScanner.
 You are able to create instances of BearViewControllerObjc subclasses and use those objects to provide
 the specific behaviors and visual appearances that you need.
 - Warning: You are able to create multiple instances of BearViewControllerObjc or it subclasses,
 but you are not able to show them simultaneously. And keep in mind that every instance of BearViewControllerObjc
 or it subclass uses the same view for render. Be careful with view states.
 */
@interface BearViewControllerObjc : UIViewController


/**
 The time after that scanner will be paused in seconds.
 
 - Note: The default value of this property is 10 seconds.
 */
@property (nonatomic, assign) IBInspectable NSInteger timeToPause;

/**
 Customize scanning line color.
 
 - Note: The default value of this property is purple color.
 */
@property (nonatomic, nonnull, strong) IBInspectable UIColor* scannerColor;

/**
 Disables automatic camera handling.
 
 If you want to manage pausing and resuming camera by yourself you should switch this property to true.
 - Note: The default value of this property is false. Camera will be enabled automatically on `viewDidAppear`
 and disabled on `viewDidDisappear`. If camera was enabled when user goes to background, BearSDK will pause it
 and resume when user will return back regardless of the value of this property.
 */
@property (nonatomic, assign) BOOL disableCameraAutoHandling;

/**
 Object to control Bear scanner features
 
 - Returns: The object conforms to BearHandlerProtocol
 */
@property (nonatomic, nonnull, readonly) id<BearHandlerProtocol> handler;

/**
 Delegate used to receive scanning callbacks
 */
@property (nonatomic, weak, nullable) IBOutlet id<BearDelegate> delegate;

@end
