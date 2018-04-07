//
//  ERDailyData.m
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "ERDailyData.h"
#import "ERAirData.h"

static NSString *const kPublishDate = @"timestamp";
static NSString *const kUpdateDate = @"update_timestamp";
static NSString *const kPSIData = @"psi_twenty_four_hourly";
static NSString *const kPM25Data = @"pm25_twenty_four_hourly";

@implementation ERDailyData

#pragma mark - life cycle
+ (instancetype)parse:(NSDictionary *)data
{
    return [[ERDailyData alloc] initWithData:data];
}

- (instancetype)initWithData:(NSDictionary *)data
{
    if (self = [super init])
    {
        [self parseData:data];
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    if (self == object) { return YES; }
    if (![object isKindOfClass:[self class]]) { return NO; }
    
    return [self.updateDate isEqual:((ERDailyData *)object).updateDate];
}

#pragma mark - private functions
- (void)parseData:(NSDictionary *)data
{
    if (!data || ![data isKindOfClass:[NSDictionary class]]) { return; }
    
    self.publishDate = [data[kPublishDate] date];
    self.updateDate = [data[kUpdateDate] date];
    
    self.psiData = [ERAirData parse:data[kPSIData]];
    self.pm25Data = [ERAirData parse:data[kPM25Data]];
}

@end
