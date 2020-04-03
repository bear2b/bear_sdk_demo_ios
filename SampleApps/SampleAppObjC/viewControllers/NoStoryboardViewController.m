//
//  NoStoryboardViewController.m
//  SampleAppObjC
//
//  Copyright © 2017-2020 BEAR SAS. All rights reserved.
//

#import "NoStoryboardViewController.h"
#import "Cache.h"

@interface NoStoryboardViewController ()

@end

@implementation NoStoryboardViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.scanlineColor = [UIColor greenColor];
    self.recognitionTimeout = 8;
    
    UIButton* close = [UIButton buttonWithType:UIButtonTypeCustom];
    [close setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    [close setTitle:@"dismiss" forState:UIControlStateNormal];
    [close sizeToFit];
    [close addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:close];
    
    close.translatesAutoresizingMaskIntoConstraints = NO;
    
    UILayoutGuide *safeArea = self.view.safeAreaLayoutGuide;
    CGFloat buttonOffset = 20;
    
    [NSLayoutConstraint activateConstraints:@[[close.topAnchor constraintEqualToAnchor:safeArea.topAnchor constant:buttonOffset],
                                              [close.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor constant:buttonOffset]]];
}

-(void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)scanTriggered {
    [self.handler startScanning];
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
    NSLog(@"viewStateChanged, state - %li", (long)state);
}

- (void)didFailWithError:(BearError * _Nonnull)error {
    NSLog(@"didFailWithError %@", error);
    UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:error.shortDescription
                                                                     message:error.reason preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
