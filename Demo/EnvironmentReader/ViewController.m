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

typedef enum {
    eViewTypeHome, eViewTypePSI, eViewTypePM25
} eViewType;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblDisplay;

@property (strong, nonatomic) ERNetworkManager *networkMgr;
@property (strong, nonatomic) ERDataManager *dataMgr;
@property (assign, nonatomic) eViewType currViewType;
@property (strong, nonatomic) ERDataCollection *allData;

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
    switch (self.currViewType)
    {
        case eViewTypeHome:
            self.lblDisplay.text = self.allData.regionData[0].regionName;
            break;
            
        case eViewTypePSI:
            self.lblDisplay.text = [NSString stringWithFormat:@"%.2f", self.allData.dailyData[0].psiData.national];
            break;
            
        case eViewTypePM25:
            self.lblDisplay.text = [NSString stringWithFormat:@"%.2f", self.allData.dailyData[0].pm25Data.national];
            break;
    }
}

@end
