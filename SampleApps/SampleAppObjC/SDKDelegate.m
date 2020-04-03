//
//  SDKDelegate.m
//  SampleAppObjC
//
//  Copyright © 2017-2020 BEAR SAS. All rights reserved.
//

#import "SDKDelegate.h"
#import "Cache.h"

@implementation SDKDelegate

- (void)recognizedMarkerWithId:(NSInteger)markerId assetIds:(NSArray<NSNumber *> * _Nonnull)assetIds {
    NSLog(@"recognizedMarkerWithId = %ld, assetIds = %@", (long)markerId, assetIds);
    [Cache cacheRecognizedMarkerId:markerId];
}

- (void)recognitionTimeoutReached {
    NSLog(@"recognitionTimeoutReached");
}

- (void)assetClickedWith:(NSInteger)assetId {
    NSLog(@"assetClickedWith = %li", (long)assetId);
}

- (void)viewStateChanged:(enum ARViewState)state {
    switch (state) {
        case ARViewStateIdle:
            NSLog(@"ARViewStateIdle");
            break;
        case ARViewStateScanning:
            NSLog(@"ARViewStateScanning");
            break;
        case ARViewStateProcessing:
            NSLog(@"ARViewStateProcessing");
            break;
        case ARViewStateTracking:
            NSLog(@"ARViewStateTracking");
            break;
    }
}

- (void)didFailWithError:(NSError * _Nonnull)error {
    NSLog(@"didFailWithError %@", error.localizedDescription);
}

@end
