//
//  ERDataCollection.h
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ERRegion.h"
#import "ERDailyData.h"

NS_ASSUME_NONNULL_BEGIN

@interface ERDataCollection : NSObject

+ (instancetype)parse:(NSDictionary *)data;

@property (strong, nonatomic) NSArray<ERRegion *> *regionData;
@property (strong, nonatomic) NSArray<ERDailyData *> *dailyData;

@end

NS_ASSUME_NONNULL_END
