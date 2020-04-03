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

@interface HistoryViewController ()

@property (nonatomic, nonnull, strong, readonly) NSArray<NSNumber*>* recognizedMarkers;
@property (weak, nonatomic, nullable) IBOutlet UIBarButtonItem *unloadBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *dismissBtn;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation HistoryViewController

static NSString* reuseIdentifier = @"historyReuseId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _recognizedMarkers = [[NSUserDefaults standardUserDefaults] arrayForKey:UserDefaultKeys.recognizedMarkers];
    
    if (_hideUnloadBtn) {
        NSMutableArray* copyArr = [_toolbar.items mutableCopy];
        [copyArr removeObjectAtIndex:0];
        _toolbar.items = copyArr;
    }
    
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
    if (_unloadBtn)
        _unloadBtn.enabled = BearSDK.shared.isLoaded;
    
    if ([self navigationController]) {
        [[self navigationController] setNavigationBarHidden:NO animated:animated];
        [_dismissBtn setEnabled:NO];
    }
}

- (IBAction)unloadTapped {
    if (!_unloadBtn || !BearSDK.shared.isLoaded) {
        return NSLog(@"BearSDK is not loaded, nothing to destroy");
    }
    [BearSDK.shared releaseResources];
    _unloadBtn.enabled = false;
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
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc.handler showARSceneWithoutTrackingWithMarkerId:_recognizedMarkers[indexPath.row].integerValue];
    [self showViewController:vc sender:self];
}

@end
