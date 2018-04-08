//
//  DisplayDataVC.m
//  EnvironmentReader
//
//  Created by QianKun on 8/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "DisplayDataVC.h"
#import "ERDataCell.h"
#import "ERDailyData.h"

static NSString *const CellID = @"ERDataCellIdentifier";

@interface DisplayDataVC() <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) ERDailyData *data;
@property (assign, nonatomic) eViewType vType;
@property (strong, nonatomic) NSString *detailTitle;

@end


@implementation DisplayDataVC

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [self setupTableView];
    self.lblTitle.text = self.detailTitle;
    if (self.navigationController)
    {
        self.navigationItem.title = self.vType == eViewTypeHome ? @"Nation Data"
        : self.vType == eViewTypePSI ? @"PSI (Hourly)"
        : @"PM2.5 (Hourly)";
    }
}

- (void)setupTableView
{
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 36.0;
}

#pragma mark - public function
- (void)updateWithTitle:(NSString *)title withData:(ERDailyData *)data forViewType:(eViewType)viewType
{
    self.detailTitle = title;
    self.lblTitle.text = title;
    self.vType = viewType;
    self.data = data;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vType == eViewTypeHome ? 3
    : self.vType == eViewTypePSI ? self.data.psiData.regionWithAirData.count
    : self.data.pm25Data.regionWithAirData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERDataCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    
    switch (self.vType)
    {
        case eViewTypeHome:
            if (indexPath.row == 0) { [cell updateCellWithTitle:@"Current Location" value:@"Singapore" firstRow:YES]; }
            if (indexPath.row == 1) { [cell updateCellWithTitle:@"PSI"
                                                          value:[NSString stringWithFormat:@"%d", (int)[self.data.psiData getNationalData]]
                                                       firstRow:NO]; }
            if (indexPath.row == 2) { [cell updateCellWithTitle:@"PM2.5"
                                                          value:[NSString stringWithFormat:@"%d", (int)[self.data.pm25Data getNationalData]]
                                                       firstRow:NO]; }
            break;
            
        case eViewTypePSI:
            if (indexPath.row == 0) { [cell updateCellWithTitle:@"Region" value:@"PSI (hourly)" firstRow:YES]; }
            else
            {
                ERRegionAirDataMap * regionWithAirData = self.data.psiData.regionWithAirData[indexPath.row - 1];
                [cell updateCellWithTitle:regionWithAirData.regionName
                                    value:[NSString stringWithFormat:@"%d", (int)regionWithAirData.airData]
                                 firstRow:NO];
            }
            break;
            
        case eViewTypePM25:
            if (indexPath.row == 0) { [cell updateCellWithTitle:@"Region" value:@"PM2.5 (hourly)" firstRow:YES]; }
            else
            {
                ERRegionAirDataMap * regionWithAirData = self.data.pm25Data.regionWithAirData[indexPath.row - 1];
                [cell updateCellWithTitle:regionWithAirData.regionName
                                    value:[NSString stringWithFormat:@"%d", (int)regionWithAirData.airData]
                                 firstRow:NO];
            }
            break;
            
        default:
            break;
    }
    return cell;
}


@end
