//
//  NoStoryboardViewController.m
//  SampleAppObjC
//
//  Copyright © 2017 BEAR SAS. All rights reserved.
//

#import "NoStoryboardViewController.h"
#import "Cache.h"

@interface NoStoryboardViewController ()

@end

@implementation NoStoryboardViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton* close = [UIButton buttonWithType:UIButtonTypeCustom];
    [close setTitle:@"dismiss" forState:UIControlStateNormal];
    close.frame = CGRectMake(20, [UIApplication sharedApplication].statusBarFrame.size.height, 0, 0);
    [close sizeToFit];
    [close addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:close];
}

-(void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)scanTriggered {
    [self.handler startScanning];
}

// MARK: BearDelegate
- (void)markerNotRecognized {
    NSLog(@"markerNotRecognized");
}

- (void)recognizedMarkerWithId:(NSInteger)markerId assetIds:(NSArray<NSNumber *> * _Nonnull)assetIds {
    NSLog(@"recognizedMarkerWithId");
    [Cache cacheRecognizedMarkerId:markerId];
}

- (void)assetClickedWith:(NSInteger)assetId {
    NSLog(@"assetClickedWith");
}

- (void)scannerStateChanged:(enum BearScannerState)state {
    NSLog(@"scanStateChanged");
}

-(void)reachabilityStatusChanged:(BOOL)reachable {
    NSLog(@"reachabilityStatusChanged");
}

- (void)didFailWithError:(BearError * _Nonnull)error {
    NSLog(@"didFailWithError %@", error);
    UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:error.shortDescription
                                                                     message:error.reason preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
