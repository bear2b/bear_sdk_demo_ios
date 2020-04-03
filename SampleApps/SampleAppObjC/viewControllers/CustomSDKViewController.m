//
//  CustomSDKViewController.m
//  SampleAppObjC
//
//  Copyright © 2017-2020 BEAR SAS. All rights reserved.
//

#import "CustomSDKViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "Cache.h"
#import "HistoryViewController.h"

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface CustomSDKViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startStopBtn;
@property (weak, nonatomic) IBOutlet UIButton *flashBtn;
@property (weak, nonatomic) IBOutlet UIButton *screenshotBtn;
@property (weak, nonatomic) IBOutlet UIView *splashScreen;
@property (weak, nonatomic) IBOutlet UIButton *historyBtn;

@end

@implementation CustomSDKViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initDefault];
    }
    return self;
}

-(void)initDefault {
    _enableHistory = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    [_historyBtn setHidden:!_enableHistory];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController != nil) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_splashScreen setHidden:YES];
}

- (IBAction)dismiss {
    if (self.navigationController != nil) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)startStopTapped {
    switch (self.handler.viewState) {
        case ARViewStateIdle:
            [self.handler startScanning];
            break;
        case ARViewStateScanning:
            [self.handler stopScanning];
            break;
        default:
            break;
    }
}

- (IBAction)enableDisableFlash {
    if (!self.handler.isFlashEnabled) {
        [self.flashBtn setSelected: [self.handler enableFlash]];
    } else {
        [self.handler disableFlash];
        [_flashBtn setSelected:NO];
    }
}

- (IBAction)showARSceneWithoutTracking {
    [self.handler showARSceneWithoutTrackingWithMarkerId:226620];
}

- (IBAction)takeScreenshot {
    UIImage* image = [self.handler takeScreenshot];
    if (image != nil) {
        [self presentShareWithScreenshot:image];
    }
}

- (IBAction)cleanView {
    [self.handler cleanView];
}

- (IBAction)registerNotifications {
    
    [[UNUserNotificationCenter currentNotificationCenter]
     requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound
     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) return;
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        });
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (![[segue destinationViewController] isKindOfClass:[HistoryViewController class]]) return;
    HistoryViewController* vc = (HistoryViewController*)[segue destinationViewController];
    vc.hideUnloadBtn = YES;
}

-(void)presentShareWithScreenshot:(UIImage*)screenshot {
    UIActivityViewController* activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[screenshot] applicationActivities:nil];
    
    activityVC.modalPresentationStyle = UIModalPresentationPopover;
    if (activityVC.popoverPresentationController != nil) {
        activityVC.popoverPresentationController.sourceRect = _screenshotBtn.frame;
        activityVC.popoverPresentationController.sourceView = self.view;
    }
    [self presentViewController:activityVC animated:true completion:nil];
}

// MARK: ARDelegate

- (void)recognizedMarkerWithId:(NSInteger)markerId assetIds:(NSArray<NSNumber *> * _Nonnull)assetIds {
    NSLog(@"recognizedMarkerWithId = %ld, assetIds = %@", (long)markerId, assetIds);
    [Cache cacheRecognizedMarkerId:markerId];
}

- (void)recognitionTimeoutReached {
    NSLog(@"recognitionTimeoutReached");
}

- (void)assetClickedWith:(NSInteger)assetId {
    NSLog(@"assetClickedWith assetId - %li", (long)assetId);
}

- (void)viewStateChanged:(enum ARViewState)state {
    switch (state) {
        case ARViewStateIdle:
            NSLog(@"ARViewStateIdle");
            [_flashBtn setSelected:NO];
            [_startStopBtn setSelected:NO];
            break;
        case ARViewStateScanning:
            NSLog(@"ARViewStateScanning");
            [_startStopBtn setSelected:YES];
            break;
        case ARViewStateProcessing:
            NSLog(@"ARViewStateProcessing");
            [_flashBtn setSelected:NO];
            break;
        case ARViewStateTracking:
            NSLog(@"ARViewStateTracking");
            [_startStopBtn setSelected:NO];
            break;
    }
}

- (void)didFailWithError:(BearError* _Nonnull)error {
    NSLog(@"didFailWithError %@", error);
    UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:error.shortDescription
                                                                     message:error.reason preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
