//
//  ERAirData.h
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ERAirData : NSObject

+ (instancetype)parse:(NSDictionary *)data;

@property (assign, nonatomic) double west;
@property (assign, nonatomic) double national;
@property (assign, nonatomic) double east;
@property (assign, nonatomic) double central;
@property (assign, nonatomic) double south;
@property (assign, nonatomic) double north;

@end

NS_ASSUME_NONNULL_END
