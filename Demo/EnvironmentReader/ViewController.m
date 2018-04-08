//
//  ViewController.m
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "ViewController.h"
#import "ERNetworkManager.h"
#import "ERDataManager.h"
#import "ERDataCollection.h"
#import "DisplayDataVC.h"
#import "ERDailyData.h"
#import "ERHelper.h"
#import "Constants.h"
#import "ERHistoryVC.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewDetailHolder;

@property (strong, nonatomic) ERNetworkManager *networkMgr;
@property (strong, nonatomic) ERDataManager *dataMgr;
@property (assign, nonatomic) eViewType currViewType;
@property (strong, nonatomic) ERDataCollection *allData;

@property (strong, nonatomic) DisplayDataVC *displayVC;

@end

@implementation ViewController

#pragma mark - Life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currViewType = eViewTypeHome;
    [self refreshDataOnline];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)btnHomeTapped:(id)sender
{
    self.currViewType = eViewTypeHome;
    [self displayData];
}

- (IBAction)btnPSITapped:(id)sender
{
    self.currViewType = eViewTypePSI;
    [self displayData];
}

- (IBAction)btnPS25Tapped:(id)sender
{
    self.currViewType = eViewTypePM25;
    [self displayData];
}

- (IBAction)btnRefreshTapped:(id)sender
{
    [self refreshDataOnline];
}

- (IBAction)btnHistoryTapped:(id)sender
{
    ERHistoryVC *historyVC = [ERHistoryVC new];
    historyVC.dailyData = self.allData.dailyData;
    historyVC.vType = self.currViewType;
    [self.navigationController pushViewController:historyVC animated:YES];
}


#pragma mark - Lazy
- (ERNetworkManager* )networkMgr
{
    if (!_networkMgr) { _networkMgr = [ERNetworkManager new]; }
    return _networkMgr;
}

- (ERDataManager *)dataMgr
{
    if (!_dataMgr) { _dataMgr = [ERDataManager new]; }
    return _dataMgr;
}

- (DisplayDataVC *)displayVC
{
    if (!_displayVC)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
        
        _displayVC = [storyboard instantiateViewControllerWithIdentifier:@"DisplayDataVCIdentifier"];
        [self addChildViewController:_displayVC];
        [self.viewDetailHolder addSubview:_displayVC.view];
        _displayVC.view.frame = self.viewDetailHolder.bounds;
    }
    return _displayVC;
}

#pragma mark - Other Private functions
- (void)refreshDataOnline
{
    __weak typeof(self) weakSelf = self;
    [self.networkMgr fetchLatestEnviromentDataOnSuccess:^(id  _Nullable responseObject) {
        [weakSelf.dataMgr saveData:responseObject onComplete:^(BOOL success) {
            [weakSelf refreshDataFromLocal];
        }];
    } failure:^(NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf refreshDataFromLocal];
        });
    }];
}

- (void)refreshDataFromLocal
{
    __weak typeof(self) weakSelf = self;
    [self.dataMgr getDataOnComplete:^(id _Nonnull localData) {
        [ERDataCollection parseData:localData onComplete:^(ERDataCollection * _Nonnull allData) {
            weakSelf.allData = allData;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf displayData];
            });
        }];
    }];
}

- (void)displayData
{
    ERDailyData *latestData = self.allData.dailyData.firstObject;
    NSString *updateDateString = [ERHelper convertDate:latestData.updateDate toStringWithFormat:DATE_FORMAT_DISPLAY];
    NSString *titleStr = updateDateString ? [NSString stringWithFormat:@"Last Result: %@", updateDateString] : @"";
    [self.displayVC updateWithTitle:titleStr withData:latestData forViewType:self.currViewType];
    
    switch (self.currViewType)
    {
        case eViewTypeHome:
            [self updateNavibarTitle:@"Enviornment Reader"];
            break;
            
        case eViewTypePSI:
            [self updateNavibarTitle:@"PSI (Hourly)"];
            break;
            
        case eViewTypePM25:
            [self updateNavibarTitle:@"PM2.5 (Hourly)"];
            break;
    }
}

- (void)updateNavibarTitle:(NSString *)title
{
    self.navigationItem.title = title;
}

@end
