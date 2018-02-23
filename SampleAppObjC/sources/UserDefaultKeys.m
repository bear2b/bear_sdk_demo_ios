//
//  UserDefaultKeys.m
//  SampleAppObjC
//
//  Copyright © 2018 BEAR SAS. All rights reserved.
//

#import "UserDefaultKeys.h"

@implementation UserDefaultKeys

static NSString* _recognizedMarkers = @"recognizedMarkers";

+(NSString*)recognizedMarkers {
    return _recognizedMarkers;
}

@end
