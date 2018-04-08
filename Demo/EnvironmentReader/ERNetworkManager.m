//
//  ERNetworkManager.m
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "ERNetworkManager.h"
#import <EnvironmentReaderLibrary/NetworkInterface.h>
#import <EnvironmentReaderLibrary/AFNetworkHandler.h>
#import "Constants.h"

@interface ERNetworkManager()

@property (strong, nonatomic) id<NetworkInterface> networkHandler;

@end

@implementation ERNetworkManager

- (instancetype)init
{
    if (self = [super init])
    {
        self.networkHandler = [AFNetworkHandler new];
    }
    
    return self;
}

- (void)fetchEnviromentDataForDate:(nonnull NSDate *)queryDate
                           success:(nullable void (^)(id _Nullable responseObject))success
                           failure:(nullable void (^)(NSError *error))failure;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.networkHandler GET:END_POINT_URL parameters:nil success:^(id  _Nullable responseObject) {
            NSError *error;
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
            if (responseObject) { success(responseDic); }
            else { failure(error); }
        } failure:^(NSError * _Nonnull error) {
            failure(error);
        }];
    });
}

- (void)fetchLatestEnviromentDataOnSuccess:(nullable void (^)(id _Nullable responseObject))success
                                   failure:(nullable void (^)(NSError *error))failure
{
    [self fetchEnviromentDataForDate:[NSDate date] success:success failure:failure];
}

@end
