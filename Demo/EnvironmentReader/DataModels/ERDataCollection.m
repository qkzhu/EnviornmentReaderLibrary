//
//  ERDataCollection.m
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "ERDataCollection.h"

static NSString *const kRegionData = @"region_metadata";
static NSString *const kItems = @"items";


@implementation ERDataCollection

#pragma mark - life cycle
+ (instancetype)parse:(NSDictionary *)data
{
    return [[ERDataCollection alloc] initWithData:data];
}

- (instancetype)initWithData:(NSDictionary *)data
{
    if (self = [super init])
    {
        [self parseData:data];
    }
    return self;
}

#pragma mark - private functions
- (void)parseData:(NSDictionary *)data
{
    if (!data || ![data isKindOfClass:[NSDictionary class]]) { return; }
    
    NSArray *regionRawData = data[kRegionData];
    if (regionRawData && [regionRawData isKindOfClass:[NSArray class]])
    {
        NSMutableArray<ERRegion *> *regionData = [NSMutableArray arrayWithCapacity:regionRawData.count];
        for (NSDictionary *dic in regionRawData) {
            [regionData addObject:[ERRegion parse:dic]];
        }
        self.regionData = regionData;
    }
    
    NSArray *airData = data[kItems];
    if (airData && [airData isKindOfClass:[NSArray class]])
    {
        NSMutableArray<ERDailyData *> *dailyData = [NSMutableArray arrayWithCapacity:airData.count];
        for (NSDictionary *dic in airData) {
            [dailyData addObject:[ERDailyData parse:dic]];
        }
        [dailyData sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return obj1 > obj2;
        }];
        self.dailyData = dailyData;
    }
}


@end
