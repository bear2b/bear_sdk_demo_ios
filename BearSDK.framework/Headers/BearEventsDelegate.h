//
//  BearGLActionsDelegate.h
//
//
//  Copyright (c) 2015 BEAR SAS. All rights reserved.
//

#ifndef BearEventsDelegate_h
#define BearEventsDelegate_h

#import <Foundation/Foundation.h>

@protocol BearEventsDelegate

@required

-(void)recognizedQRCode:(nullable NSString*)qrCode;
-(void)recognizedMarker:(nonnull NSString*)markerId;
-(void)recognizedOfflineMarker:(nonnull NSString*)markerId;
-(void)showWebViewWithUrl:(nonnull NSString*)url;
-(void)presentPlayerWithAssetId:(NSInteger)assetId timeStamp:(int64_t)timeStamp;
-(void)showVCard:(nonnull NSString*)vcard;
-(void)presentShareWithImageURL:(nonnull NSString *)imageUrl title:(nonnull NSString *)title
     description:(nonnull NSString *)desc andURL:(nonnull NSString *)url;
-(void)openFacebook:(nonnull NSString*)url deeplink:(nonnull NSString*)deeplink;
-(void)openBrowser:(nonnull NSString*)url;
-(void)assetAction:(NSInteger)assetId;
-(void)reachabilityStatusChanged:(BOOL)reachable;
-(void)cloudRecognitionStopped;
-(void)errorOccuredWithTitle:(nonnull NSString*)title reason:(nonnull NSString*)reason additionalInfo:(nonnull NSString*)additionalInfo;

@end

@protocol BearGLErrorHandler

@required
-(void)presentErrorAlert:(nullable NSString*)title message:(nonnull NSString*)message;

@end


#endif
