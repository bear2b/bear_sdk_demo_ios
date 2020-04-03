//
//  NoStoryboardSampleVC.m
//  SampleAppObjC
//
//  Copyright © 2017-2020 BEAR SAS. All rights reserved.
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
    [vc setScanlineColor:[UIColor blackColor]];
    [vc setRecognitionTimeout:5];
    
    [self showViewController:vc sender:self];
}

- (IBAction)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
