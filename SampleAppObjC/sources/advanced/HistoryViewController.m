//
//  HistoryViewController.m
//  SampleAppObjC
//
//  Copyright © 2018 BEAR SAS. All rights reserved.
//

#import "HistoryViewController.h"
#import "NoStoryboardViewController.h"
#import "UserDefaultKeys.h"
#import <BearSDK/BearSDK.h>

@interface HistoryViewController () {
    NSString* preloadTitle;
    NSString* destroyTitle;
}

@property (nonatomic, nonnull, strong, readonly) NSArray<NSNumber*>* recognizedMarkers;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *preloadAndDestroy;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *dismissBtn;

@end

@implementation HistoryViewController

static NSString* reuseIdentifier = @"historyReuseId";

- (void)viewDidLoad {
    [super viewDidLoad];
    preloadTitle = @"preload";
    destroyTitle = @"destroy";
    
    _recognizedMarkers = [[NSUserDefaults standardUserDefaults] arrayForKey:UserDefaultKeys.recognizedMarkers];
    
    if (_recognizedMarkers.count == 0) {
        UILabel* lbl = [[UILabel alloc] init];
        lbl.text = @"Scanned markers will appear here.\nYou can scan using any of samples";
        lbl.numberOfLines = 2;
        [lbl sizeToFit];
        [self.view addSubview:lbl];
        lbl.center = self.view.center;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _preloadAndDestroy.title = [BearSDK shared].isLoaded ? destroyTitle : preloadTitle;
    if ([self navigationController]) {
        [[self navigationController] setNavigationBarHidden:NO animated:animated];
        [_dismissBtn setEnabled:NO];
    }
}

- (IBAction)preloadTapped {
    if (BearSDK.shared.isLoaded) {
        [BearSDK.shared destroy];
        _preloadAndDestroy.title = preloadTitle;
    } else {
        [BearSDK.shared preload:^{
            _preloadAndDestroy.title = destroyTitle;
            [_preloadAndDestroy setEnabled:YES];
        }];
        [_preloadAndDestroy setEnabled:NO];
    }
}

- (IBAction)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// MARK: UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _recognizedMarkers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%li", (long)_recognizedMarkers[indexPath.row].integerValue];
    return cell;
}

// MARK: UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NoStoryboardViewController* vc = [[NoStoryboardViewController alloc] init];
    [vc.handler showARSceneWithoutTrackingWithMarkerId:_recognizedMarkers[indexPath.row].integerValue];
    [self showViewController:vc sender:self];
}

@end
