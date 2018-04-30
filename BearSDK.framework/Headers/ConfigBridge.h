//
//  ConfigBridge.h
//  BearGL
//
//  Copyright © 2017 BEAR SAS. All rights reserved.
//

#ifndef ConfigBridge_h
#define ConfigBridge_h

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface ConfigBridge: NSObject
    
-(ConfigBridge*)setLicenceKey:(NSString*)licenceKey;
-(ConfigBridge*)setAccessKey:(NSString*)accesKey;
-(ConfigBridge*)setSecretKey:(NSString*)secretKey;
-(ConfigBridge*)setTimeToPause:(NSInteger) time;
-(ConfigBridge*)setWidth:(NSInteger) width;
-(ConfigBridge*)setHeight:(NSInteger) height;
-(ConfigBridge*)setScale:(CGFloat) scale;
-(ConfigBridge*)setCustomColor:(CGColorRef) color;
-(ConfigBridge*)setContentUrl:(NSString*)contentUrl;
-(ConfigBridge*)setCacheDir:(NSString*)cacheDir;
-(ConfigBridge*)setImagesDir:(NSString*)imagesDir;
-(ConfigBridge*)setEnableFreezeAssets:(BOOL)enable;
-(ConfigBridge*)setDeviceId:(NSInteger)deviceId;
-(ConfigBridge*)setDev:(BOOL)dev;
-(ConfigBridge*)setLogEnabled:(BOOL)logEnabled;
    
@end

#endif /* ConfigBridge_h */
