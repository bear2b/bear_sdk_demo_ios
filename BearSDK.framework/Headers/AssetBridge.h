//
//  AssetBridge.h
//  BearGL
//
//  Copyright © 2017 BEAR SAS. All rights reserved.
//

#ifndef AssetBridge_h
#define AssetBridge_h

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface AssetBridge: NSObject
    
-(AssetBridge*)initWithType:(NSInteger) type;
-(AssetBridge*)setId:(NSInteger) _id;
-(AssetBridge*)setX:(CGFloat) x;
-(AssetBridge*)setY:(CGFloat) y;
-(AssetBridge*)setZ:(CGFloat) z;
-(AssetBridge*)setAlpha:(CGFloat) alpha;
-(AssetBridge*)setTheta:(CGFloat) theta;
-(AssetBridge*)setPsi:(CGFloat) psi;
-(AssetBridge*)setWidth:(CGFloat) width;
-(AssetBridge*)setHeight:(CGFloat) height;
-(AssetBridge*)setTransparent:(BOOL) transparent;
-(AssetBridge*)setContent:(NSString*) content;
-(AssetBridge*)setCustomImage:(NSString*) customImage;
-(AssetBridge*)setAction:(NSString*) action;
-(AssetBridge*)setShareTitle:(NSString*) title;
-(AssetBridge*)setShareDesc:(NSString*) desc;
-(AssetBridge*)setShareUrl:(NSString*) url;
-(AssetBridge*)setScale:(CGFloat) scale;
-(AssetBridge*)setActionType:(NSInteger) actionType;
-(AssetBridge*)setKeyColor:(NSInteger)keyColor;
-(AssetBridge*)setAutoplayOnTexture:(BOOL)autoplayOnTexture;
-(AssetBridge*)setZorder:(NSInteger)zorder;
-(AssetBridge*)setIs3dContext:(BOOL)is3dContext;
-(AssetBridge*)setAutoplayVideoInLoop:(BOOL)autoplayVideoInLoop;
    
@end

#endif /* AssetBridge_h */
