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

typedef enum {
    eViewTypeHome, eViewTypePSI, eViewTypePM25
} eViewType;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblDisplay;

@property (strong, nonatomic) ERNetworkManager *networkMgr;
@property (strong, nonatomic) ERDataManager *dataMgr;
@property (assign, nonatomic) eViewType currViewType;

@end

@implementation ViewController

#pragma mark - Life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currViewType = eViewTypeHome;
    [self refreshData];
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
    [self refreshData];
    [self displayData];
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
- (void)refreshData
{
    __weak typeof(self) weakSelf = self;
    [self.networkMgr fetchLatestEnviromentDataOnSuccess:^(id  _Nullable responseObject) {
        NSLog(@"fetch data success");
        [weakSelf displayData];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"fetch data failed");
        [weakSelf displayData];
    }];
}

- (void)displayData
{
    switch (self.currViewType)
    {
        case eViewTypeHome:
            self.lblDisplay.text = @"home data";
            break;
            
        case eViewTypePSI:
            self.lblDisplay.text = @"PSI data";
            break;
            
        case eViewTypePM25:
            self.lblDisplay.text = @"PM2.5 data";
            break;
    }
}

@end
