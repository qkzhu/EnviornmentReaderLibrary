//
//  ERMapVC.m
//  EnvironmentReader
//
//  Created by QianKun on 8/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "ERMapVC.h"
#import <MapKit/MapKit.h>
#import "ERDailyData.h"
#import "ERRegion.h"
#import "ERMapAnnotation.h"

@interface ERMapVC ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) ERDailyData *data;
@property (weak, nonatomic) NSArray<ERRegion *> *regionData;
@property (strong, nonatomic) NSString *titleStr;

@end

@implementation ERMapVC

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Enviornment Reader";
    [self updateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public function
- (void)updateWithTitle:(NSString *)title withData:(ERDailyData *)data regionData:(NSArray<ERRegion *> *)rData
{
    self.data = data;
    self.titleStr = title;
    self.regionData = rData;
    [self updateUI];
}

- (void)updateUI
{
    self.lblTitle.text = self.titleStr;
    [self updateMap];
}

- (void)updateMap
{
    NSMutableDictionary *regionSummaryDataMap = [NSMutableDictionary dictionary];
    for (ERRegionAirDataMap *regionPsiMap in self.data.psiData.regionWithAirData)
    {
        regionSummaryDataMap[regionPsiMap.regionName] = [NSString stringWithFormat:@"PSI:%d", (int)regionPsiMap.airData];
    }
    
    for (ERRegionAirDataMap *regionPM25Map in self.data.pm25Data.regionWithAirData)
    {
        ERRegion *regionData = [self getRegionByRegionName:regionPM25Map.regionName];
        if (!regionData) { continue; }
        
        NSString *summary = regionSummaryDataMap[regionPM25Map.regionName];
        if (summary) { summary = [NSString stringWithFormat:@"%@, PM2.5:%d", summary, (int)regionPM25Map.airData]; }
        else { summary = [NSString stringWithFormat:@"PM2.5: %d", (int)regionPM25Map.airData]; }
        
        [self.mapView addAnnotation:[[ERMapAnnotation alloc] initWithTitle:regionPM25Map.regionName
                                                                  subtitle:summary
                                                                  latitude:regionData.latitude
                                                                 longitude:regionData.logitude]];
    }
}

- (ERRegion *)getRegionByRegionName:(NSString *)regionName
{
    for (ERRegion *reg in self.regionData)
    {
        if ([reg.regionName isEqualToString:regionName]) { return reg; }
    }
    
    return nil;
}

@end
