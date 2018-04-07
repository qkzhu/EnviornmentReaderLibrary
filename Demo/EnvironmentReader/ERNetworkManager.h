//
//  ERNetworkManager.h
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ERNetworkManager : NSObject

- (void)fetchEnviromentDataForDate:(nonnull NSDate *)queryDate
                           success:(nullable void (^)(id _Nullable responseObject))success
                           failure:(nullable void (^)(NSError *error))failure;

- (void)fetchLatestEnviromentDataOnSuccess:(nullable void (^)(id _Nullable responseObject))success
                                   failure:(nullable void (^)(NSError *error))failure;


@end

NS_ASSUME_NONNULL_END
