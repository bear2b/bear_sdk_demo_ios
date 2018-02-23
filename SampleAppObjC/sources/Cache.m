//
//  Cache.m
//  SampleAppObjC
//
//  Copyright © 2018 BEAR SAS. All rights reserved.
//

#import "Cache.h"
#import "UserDefaultKeys.h"

@implementation Cache

+(void)cacheRecognizedMarkerId:(NSInteger)markerId {
    NSNumber* recognizedId = [NSNumber numberWithInteger:markerId];
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSArray<NSNumber*>* recogArr = [NSArray array];
    NSMutableArray<NSNumber*>* cached = [NSMutableArray<NSNumber*> arrayWithArray:[defaults arrayForKey:UserDefaultKeys.recognizedMarkers]];
    if (cached != nil) {
        if ([cached containsObject:recognizedId]) return;
        [cached addObject:recognizedId];
        recogArr = cached;
    } else {
        recogArr = [NSMutableArray arrayWithObject:recognizedId];
    }
    [defaults setObject:recogArr forKey:UserDefaultKeys.recognizedMarkers];
}

@end
