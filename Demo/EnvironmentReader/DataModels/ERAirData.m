//
//  ERAirData.m
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "ERAirData.h"

static NSString *const kWest = @"west";
static NSString *const kNational = @"national";
static NSString *const kEast = @"east";
static NSString *const kCentral = @"central";
static NSString *const kSouth = @"south";
static NSString *const kNorth = @"north";

@implementation ERAirData

#pragma mark - life cycle
+ (instancetype)parse:(NSDictionary *)data
{
    return [[ERAirData alloc] initWithData:data];
}

- (instancetype)initWithData:(NSDictionary *)data
{
    if (self = [super init])
    {
        [self parseData:data];
    }
    return self;
}

- (double)getNationalData
{
    for (ERRegionAirDataMap *eachAirRegionData in self.regionWithAirData)
    {
        if ([eachAirRegionData.regionName isEqualToString:kNational]) { return eachAirRegionData.airData; }
    }
    return 0.0;
}

#pragma mark - private functions
- (void)parseData:(NSDictionary *)data
{
    if (!data || ![data isKindOfClass:[NSDictionary class]]) { return; }
    
    //regionWithAirData
    NSMutableArray *regionAirDataList = [NSMutableArray array];
    [regionAirDataList addObject:[ERRegionAirDataMap initWithRegionName:kWest airData:[data[kWest] doubleValue]]];
    [regionAirDataList addObject:[ERRegionAirDataMap initWithRegionName:kNational airData:[data[kNational] doubleValue]]];
    [regionAirDataList addObject:[ERRegionAirDataMap initWithRegionName:kEast airData:[data[kEast] doubleValue]]];
    [regionAirDataList addObject:[ERRegionAirDataMap initWithRegionName:kCentral airData:[data[kCentral] doubleValue]]];
    [regionAirDataList addObject:[ERRegionAirDataMap initWithRegionName:kSouth airData:[data[kSouth] doubleValue]]];
    [regionAirDataList addObject:[ERRegionAirDataMap initWithRegionName:kNorth airData:[data[kNorth] doubleValue]]];
    
    [regionAirDataList sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        ERRegionAirDataMap *d1 = (ERRegionAirDataMap *)obj1;
        ERRegionAirDataMap *d2 = (ERRegionAirDataMap *)obj2;
        
        return d1.regionName < d2.regionName;
    }];
    self.regionWithAirData = regionAirDataList;
}

@end


@implementation ERRegionAirDataMap

+ (instancetype)initWithRegionName:(NSString *)regName airData:(double)data
{
    ERRegionAirDataMap *regionAirMap = [ERRegionAirDataMap new];
    regionAirMap.regionName = regName;
    regionAirMap.airData = data;
    
    return regionAirMap;
}



@end
