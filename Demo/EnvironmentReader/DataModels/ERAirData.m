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

#pragma mark - private functions
- (void)parseData:(NSDictionary *)data
{
    if (!data || ![data isKindOfClass:[NSDictionary class]]) { return; }
    
    self.west = [data[kWest] doubleValue];
    self.national = [data[kNational] doubleValue];
    self.east = [data[kEast] doubleValue];
    self.central = [data[kCentral] doubleValue];
    self.south = [data[kSouth] doubleValue];
    self.north = [data[kNorth] doubleValue];
}

@end
