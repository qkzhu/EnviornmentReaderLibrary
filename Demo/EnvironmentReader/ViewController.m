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
    
    //create testing
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"manuallyData.plist"];
        
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:@"1"];
        [data addObject:@"2"];
        [data addObject:@"3"];
        
        NSDictionary *plistDict = [[NSDictionary alloc] initWithObjects: [NSArray arrayWithObjects: data, nil]
                                                                forKeys:[NSArray arrayWithObjects: @"Numbers", nil]];
        
        NSError *error = nil;
        NSData *plistData = [NSPropertyListSerialization dataWithPropertyList:plistDict
                                                                       format:NSPropertyListXMLFormat_v1_0 options:0
                                                                        error:&error];
        
        if(plistData)
        {
            [plistData writeToFile:plistPath atomically:YES];
        }
    }
    //end crate tesing
    
    // retrieve testin
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"manuallyData.plist"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
        {
            plistPath = [[NSBundle mainBundle] pathForResource:@"manuallyData" ofType:@"plist"];
        }
        
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        NSLog(@"%@", dict);
    }
    // end retrieve testing
    
    // remove data testing
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"manuallyData.plist"];
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:(NSString *)plistPath];
        
        NSMutableArray *data = [dictionary objectForKey:@"Numbers"];
        [data removeObjectAtIndex:0];
        
        [dictionary writeToFile:plistPath atomically:YES];
    }
    // end removing data testing
    
    // updating test
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"manuallyData.plist"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
        {
            plistPath = [[NSBundle mainBundle] pathForResource:@"manuallyData" ofType:@"plist"];
        }
        
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:(NSString *)plistPath];
        NSMutableArray *data = [dictionary objectForKey:@"Numbers"];
        [data insertObject:@"1" atIndex:0];
        [data insertObject:@"5" atIndex:data.count - 1];
        [dictionary writeToFile:plistPath atomically:YES];
        NSLog(@"%@", dictionary);
    }
    // end updating test
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
