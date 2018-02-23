//
//  NavigationStackSampleVC.m
//  SampleAppObjC
//
//  Copyright © 2017 BEAR SAS. All rights reserved.
//

#import "NavigationStackSampleVC.h"

@interface NavigationStackSampleVC ()

@end

@implementation NavigationStackSampleVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (IBAction)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
