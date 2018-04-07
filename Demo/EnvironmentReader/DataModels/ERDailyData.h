//
//  ERDailyData.h
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ERAirData.h"

NS_ASSUME_NONNULL_BEGIN

@interface ERDailyData : NSObject

+ (instancetype)parse:(NSDictionary *)data;

@property (strong, nonatomic) NSDate *publishDate;
@property (strong, nonatomic) NSDate *updateDate;
@property (strong, nonatomic) ERAirData *psiData;
@property (strong, nonatomic) ERAirData *pm25Data;

@end

NS_ASSUME_NONNULL_END
