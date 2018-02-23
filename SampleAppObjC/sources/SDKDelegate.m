//
//  SDKDelegate.m
//  SampleAppObjC
//
//  Copyright © 2017 BEAR SAS. All rights reserved.
//

#import "SDKDelegate.h"
#import "Cache.h"

@implementation SDKDelegate

- (void)assetClickedWith:(NSInteger)assetId {
    NSLog(@"assetTappedWithAssetId = %li", (long)assetId);
}

- (void)markerNotRecognized {
    NSLog(@"markerNotRecognized");
}

- (void)recognizedMarkerWithId:(NSInteger)markerId assetIds:(NSArray<NSNumber *> * _Nonnull)assetIds {
    NSLog(@"recognizedMarkerWithId = %ld, assetIds = %@", (long)markerId, assetIds);
    [Cache cacheRecognizedMarkerId:markerId];
}

- (void)scannerStateChanged:(enum BearScannerState)state {
    switch (state) {
        case BearScannerStateIdle:
            NSLog(@"BearScannerStateIdle");
            break;
        case BearScannerStateScanning:
            NSLog(@"BearScanStateScanning");
            break;
        case BearScannerStateProcessing:
            NSLog(@"BearScanStateProcessing");
            break;
        case BearScannerStateRendering:
            NSLog(@"BearScannerStateRendering");
            break;
    }
}

-(void)reachabilityStatusChanged:(BOOL)reachable {
    NSLog(@"reachabilityStatusChanged: reachable = %d", reachable);
}

- (void)didFailWithError:(NSError * _Nonnull)error {
    NSLog(@"didFailWithError %@", error.localizedDescription);
}

@end
