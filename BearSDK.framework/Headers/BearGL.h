//
//  BearGL.h
//  BearGL
//
//  Copyright © 2016 BEAR SAS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BearEventsDelegate.h"
#import "MarkerBridge.h"
#import "AssetBridge.h"
#import "ConfigBridge.h"

typedef NS_ENUM(NSUInteger, InitState) {
    InitStateNotInitialized,
    InitStateInitializing,
    InitStateInitialized
};

@interface BearGL: NSObject

+(void)setConfigBridge:(ConfigBridge*)configBridge;
+(void)initAR:(BOOL)startCamera;
+(InitState)initState;

+(void)updateMarker:(MarkerBridge*)markerBridge;
+(void)bindMarker:(MarkerBridge*)markerBridge;
+(void)bindMarkerInFreezedMode:(MarkerBridge*)markerBridge;

+(void)setEventsDelegate:(id<BearEventsDelegate>) delegate;
+(void)setErrorHandler:(id<BearGLErrorHandler>) handler;

+(void)setCallback:(void(^)(void))callback;
+(void)executeAllCallbacks;
+(void)playerClosedWithAssetId:(NSInteger)assetId andTimestamp:(int64_t)timestamp;

+(void)destroy;
+(void)reset;

+(void)pause;
+(BOOL)resume;

+(void)stopScan;
+(void)startScan;

+(void)setReachable:(BOOL)reachable;

+(bool)enableFlash;
+(bool)disableFlash;
+(bool)isFlashEnabled;

+(void)renderFrame;

+(void)touchesBegan:(NSArray<NSValue*>*)touches;
+(void)touchesMoved:(NSArray<NSValue*>*)touches;
+(void)touchesEnded:(NSArray<NSValue*>*)touches;
+(void)doubleTapInPoint:(CGPoint)point;

+(void)contentReadyWithHash:(NSString*)hash error:(BOOL)error;

@end

