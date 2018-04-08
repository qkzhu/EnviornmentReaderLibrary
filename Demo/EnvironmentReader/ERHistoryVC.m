//
//  ERHistoryVC.m
//  EnvironmentReader
//
//  Created by QianKun on 8/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "ERHistoryVC.h"
#import "ERDailyData.h"
#import "ERHelper.h"
#import "Constants.h"
#import "DisplayDataVC.h"

static NSString *const CellID = @"historyCellIdentifier";

@interface ERHistoryVC ()
@property (strong, nonatomic) DisplayDataVC *displayVC;
@end

@implementation ERHistoryVC

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    self.tableView.rowHeight = 50;
    self.navigationItem.title = @"Activity Log";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dailyData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    
    ERDailyData *eachDayData = self.dailyData[indexPath.row];
    NSString *updateDateInStr = [ERHelper convertDate:eachDayData.updateDate toStringWithFormat:DATE_FORMAT_DISPLAY];
    if (updateDateInStr) { cell.textLabel.text = [NSString stringWithFormat:@"Date: %@", updateDateInStr]; }
    else { cell.textLabel.text = @"";}
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERDailyData *latestData = self.dailyData[indexPath.row];
    NSString *updateDateString = [ERHelper convertDate:latestData.updateDate toStringWithFormat:DATE_FORMAT_DISPLAY];
    NSString *titleStr = updateDateString ? [NSString stringWithFormat:@"Last Result: %@", updateDateString] : @"";
    [self.displayVC updateWithTitle:titleStr withData:latestData forViewType:self.vType];
    
    [self.navigationController pushViewController:self.displayVC animated:YES];
}

#pragma mark - lazy
- (DisplayDataVC *)displayVC
{
    if (!_displayVC)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
        _displayVC = [storyboard instantiateViewControllerWithIdentifier:@"DisplayDataVCIdentifier"];
    }
    return _displayVC;
}

@end
