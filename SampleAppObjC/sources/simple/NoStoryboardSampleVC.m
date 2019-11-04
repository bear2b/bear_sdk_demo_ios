//
//  NoStoryboardSampleVC.m
//  SampleAppObjC
//
//  Copyright © 2017-2018 BEAR SAS. All rights reserved.
//

#import "NoStoryboardSampleVC.h"
#import "NoStoryboardViewController.h"

@interface NoStoryboardSampleVC ()

@end

@implementation NoStoryboardSampleVC

- (IBAction)showBearScanner {
    NoStoryboardViewController* vc = [[NoStoryboardViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc setDelegate:vc];
    [vc setScannerColor:[UIColor blackColor]];
    [vc setTimeToPause:5];
    
    [self showViewController:vc sender:self];
}

- (IBAction)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
