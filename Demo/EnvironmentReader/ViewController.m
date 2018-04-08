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
#import "ERMapVC.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewDetailHolder;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@property (strong, nonatomic) ERNetworkManager *networkMgr;
@property (strong, nonatomic) ERDataManager *dataMgr;
@property (assign, nonatomic) eViewType currViewType;
@property (strong, nonatomic) ERDataCollection *allData;
@property (strong, nonatomic) DisplayDataVC *displayVC;

@property (assign, nonatomic) BOOL isQuerying;
@end

@implementation ViewController

#pragma mark - Life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.isQuerying = NO;
    [self updateButtonsUI];
    self.currViewType = eViewTypeHome;
    [self updateButtonBackground];
    [self refreshDataOnline];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueMapView"])
    {
        ERMapVC *mapVC = (ERMapVC *)segue.destinationViewController;
        
        ERDailyData *latestData = self.allData.dailyData.firstObject;
        NSString *updateDateString = [ERHelper convertDate:latestData.updateDate toStringWithFormat:DATE_FORMAT_DISPLAY];
        NSString *titleStr = updateDateString ? [NSString stringWithFormat:@"Last Result: %@", updateDateString] : @"";
        [mapVC updateWithTitle:titleStr withData:latestData regionData:self.allData.regionData];
    }
}
#pragma mark - IBActions

- (IBAction)btnHomeTapped:(id)sender
{
    self.currViewType = eViewTypeHome;
    [self updateButtonBackground];
    [self displayData];
}

- (IBAction)btnPSITapped:(id)sender
{
    self.currViewType = eViewTypePSI;
    [self updateButtonBackground];
    [self displayData];
}

- (IBAction)btnPS25Tapped:(id)sender
{
    self.currViewType = eViewTypePM25;
    [self updateButtonBackground];
    [self displayData];
}

- (IBAction)btnMapTapped:(id)sender
{
    self.currViewType = eViewTypeMap;
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
- (void)updateButtonsUI
{
    for (UIButton *button in self.buttons)
    {
        button.layer.borderColor = [UIColor.lightGrayColor CGColor];
        button.layer.borderWidth = .5;
    }
}

- (void)refreshDataOnline
{
    if (self.isQuerying) { return; }
    
    self.isQuerying = YES;
    
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Query in progress..."
                                                                     message:nil
                                                              preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.isQuerying = NO;
        [weakSelf refreshDataFromLocal];
        [alertVC dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
    [self.networkMgr fetchLatestEnviromentDataOnSuccess:^(id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [alertVC dismissViewControllerAnimated:YES completion:^{
                [weakSelf refreshDataFromLocal];
                weakSelf.isQuerying = NO;
            }];
        });
        
        [weakSelf.dataMgr saveData:responseObject onComplete:^(BOOL success) {
            [weakSelf refreshDataFromLocal];
            weakSelf.isQuerying = NO;
        }];
    } failure:^(NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [alertVC dismissViewControllerAnimated:YES completion:^{
                if (!weakSelf.isQuerying) { [weakSelf refreshDataFromLocal];  }
                else { [weakSelf promptAlertVCToRetryFetch]; }
                weakSelf.isQuerying = NO;
            }];
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

- (void)promptAlertVCToRetryFetch
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Online fetch failed"
                                                                     message:@"Do you want to retry?"
                                                              preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf = self;
    [alertVC addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf refreshDataFromLocal];
        [alertVC dismissViewControllerAnimated:YES completion:nil];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf refreshDataOnline];
        [alertVC dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)displayData
{
    ERDailyData *latestData = self.allData.dailyData.firstObject;
    NSString *updateDateString = [ERHelper convertDate:latestData.updateDate toStringWithFormat:DATE_FORMAT_DISPLAY];
    NSString *titleStr = updateDateString ? [NSString stringWithFormat:@"Last Result: %@", updateDateString] : @"";
    
    switch (self.currViewType)
    {
        case eViewTypeHome:
            [self.displayVC updateWithTitle:titleStr withData:latestData forViewType:self.currViewType];
            [self updateNavibarTitle:@"Enviornment Reader"];
            break;
            
        case eViewTypePSI:
            [self.displayVC updateWithTitle:titleStr withData:latestData forViewType:self.currViewType];
            [self updateNavibarTitle:@"PSI (Hourly)"];
            break;
            
        case eViewTypePM25:
            [self.displayVC updateWithTitle:titleStr withData:latestData forViewType:self.currViewType];
            [self updateNavibarTitle:@"PM2.5 (Hourly)"];
            break;
            
        case eViewTypeMap:
            break;
    }
}

- (void)updateNavibarTitle:(NSString *)title
{
    self.navigationItem.title = title;
}

- (void)updateButtonBackground
{
    UIColor *unSelectedBg = UIColor.whiteColor;
    UIColor *selectedBg = UIColor.lightGrayColor;
    
    for (UIButton *button in self.buttons)
    {
        if (button.tag == (int)self.currViewType) { button.backgroundColor = selectedBg; }
        else { button.backgroundColor = unSelectedBg; }
    }
}

- (void)showActivityPanel
{
    UIAlertController *alvertVC = [UIAlertController alertControllerWithTitle:@"Loading"
                                                                      message:nil
                                                               preferredStyle:UIAlertControllerStyleAlert];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:alvertVC.view.bounds];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    indicator.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [alvertVC.view addSubview:indicator];
    [indicator startAnimating];
    [self presentViewController:alvertVC animated:YES completion:nil];
    
}
@end
