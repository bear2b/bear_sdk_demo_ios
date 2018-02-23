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
    NotInitialized,
    Initializing,
    Initialized
};

@interface BearGL: NSObject

+(void)setConfigBridge:(ConfigBridge*)configBridge;
+(void)initAR;

+(void)bindMarker:(MarkerBridge*)markerBridge;
+(void)bindMarkerInFreezedMode:(MarkerBridge*)markerBridge;

+(void)setEventsDelegate:(id<BearEventsDelegate>) delegate;
+(void)setErrorHandler:(id<BearGLErrorHandler>) handler;

+(void)setCallback:(void(^)(void))callback;
+(void)executeAllCallbacks;
+(void)playerClosedWithAssetId:(NSInteger)assetId andTimestamp:(int64_t)timestamp;

+(void)destroy;
+(void)pause;
+(void)resume;
+(void)reset;
+(InitState)state;

+(void)stopScan;
+(void)startScan;

+(void)setReachable;
+(void)setUnreachable;

+(bool)enableFlash;
+(bool)disableFlash;
+(bool)isFlashEnabled;

+(void)renderFrame;

+(void)touchesBegan:(NSArray<NSValue*>*)touches;
+(void)touchesMoved:(NSArray<NSValue*>*)touches;
+(void)touchesEnded:(NSArray<NSValue*>*)touches;
+(void)doubleTapInPoint:(CGPoint)point;

@end

