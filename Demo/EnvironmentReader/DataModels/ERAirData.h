//
//  ERAirData.h
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ERRegionAirDataMap;

@interface ERAirData : NSObject

@property (strong, nonatomic) NSArray<ERRegionAirDataMap *> *regionWithAirData;

+ (instancetype)parse:(NSDictionary *)data;
- (double)getNationalData;

@end


@interface ERRegionAirDataMap: NSObject

+ (instancetype)initWithRegionName:(NSString *)regName airData:(double)data;

@property (strong, nonatomic) NSString *regionName;
@property (assign, nonatomic) double airData;

@end

NS_ASSUME_NONNULL_END
