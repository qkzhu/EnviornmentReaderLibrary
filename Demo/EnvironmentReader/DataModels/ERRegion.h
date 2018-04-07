//
//  ERRegion.h
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ERRegion : NSObject

+ (instancetype)parse:(NSDictionary *)data;

@property (strong, nonatomic) NSString *regionName;
@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double logitude;

@end

NS_ASSUME_NONNULL_END
