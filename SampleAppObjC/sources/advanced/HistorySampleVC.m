//
//  HistorySampleVC.m
//  SampleAppObjC
//
//  Copyright © 2018 BEAR SAS. All rights reserved.
//

#import "HistorySampleVC.h"
#import "CustomSDKViewController.h"

@interface HistorySampleVC ()

@end

@implementation HistorySampleVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController != nil) {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
}

-(IBAction)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual: @"history"]) {
        CustomSDKViewController* vc = (CustomSDKViewController*)[segue destinationViewController];
        vc.enableHistory = YES;
    }
}

@end
