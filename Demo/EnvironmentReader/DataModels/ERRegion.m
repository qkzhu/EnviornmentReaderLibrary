//
//  ERRegion.m
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "ERRegion.h"

static NSString *const kRegionName = @"name";
static NSString *const kLocationData = @"label_location";
static NSString *const kLatitude = @"latitude";
static NSString *const kLongitude = @"longitude";


@implementation ERRegion

#pragma mark - life cycle
+ (instancetype)parse:(NSDictionary *)data
{
    return [[ERRegion alloc] initWithData:data];
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
    
    self.regionName = data[kRegionName];
    NSDictionary *locationData = data[kLocationData];
    
    if (!locationData || ![locationData isKindOfClass:[NSDictionary class]]) { return; }
    self.latitude = [locationData[kLatitude] doubleValue];
    self.logitude = [locationData[kLongitude] doubleValue];
}

@end
