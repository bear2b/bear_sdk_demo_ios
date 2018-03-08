//
//  HistoryViewController.h
//  SampleAppObjC
//
//  Copyright © 2018 BEAR SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) BOOL hidePreloadBtn;

@end
