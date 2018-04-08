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
+ (void)parseData:(NSDictionary *)data onComplete:(nullable void (^)(ERDataCollection *))complete
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ERDataCollection *erData = [[ERDataCollection alloc] initWithData:data];
        complete(erData);
    });
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
            ERDailyData *d1 = (ERDailyData *)obj1;
            ERDailyData *d2 = (ERDailyData *)obj2;
            
            return [d1 isEqual:d2];
        }];
        self.dailyData = dailyData;
    }
}


@end
