//
//  MarkerBridge.h
//  BearGL
//
//  Copyright © 2017 BEAR SAS. All rights reserved.
//

#ifndef MarkerBridge_h
#define MarkerBridge_h

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface MarkerBridge: NSObject
    
-(MarkerBridge*)setId:(NSInteger) _id;
-(MarkerBridge*)setImageUrl:(NSString*) imageUrl;
-(MarkerBridge*)setWidth:(CGFloat) width;
-(MarkerBridge*)setHeight:(CGFloat) height;
-(MarkerBridge*)setAssetsBridges:(NSArray*) assets;
-(MarkerBridge*)setHasShadows:(BOOL)hasShadows;
-(MarkerBridge*)setCx:(CGFloat) cx;
-(MarkerBridge*)setCy:(CGFloat) cy;
-(MarkerBridge*)setRecoAreaWidth:(CGFloat) areaWidth;
-(MarkerBridge*)setRecoAreaHeight:(CGFloat) areaHeight;
-(MarkerBridge*)setRecoAreaExist:(BOOL)exist;
    
@end

#endif /* MarkerBridge_h */
