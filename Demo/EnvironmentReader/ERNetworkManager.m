//
//  ERNetworkManager.m
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "ERNetworkManager.h"
#import <EnvironmentReaderLibrary/NetworkInterface.h>
#import <EnvironmentReaderLibrary/MockNetworkHandler.h>


@interface ERNetworkManager()

@property (strong, nonatomic) id<NetworkInterface> networkHandler;

@end

@implementation ERNetworkManager

- (instancetype)init
{
    if (self = [super init])
    {
        self.networkHandler = [MockNetworkHandler new];
    }
    
    return self;
}

- (void)fetchEnviromentDataForDate:(nonnull NSDate *)queryDate
                           success:(nullable void (^)(id _Nullable responseObject))success
                           failure:(nullable void (^)(NSError *error))failure;
{
    [self.networkHandler GET:@"123" parameters:nil success:^(id  _Nullable responseObject) {
        NSLog(@"ERCall success");
        success(@"success");
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"ERCALL failure");
        failure(nil);
    }];
}

- (void)fetchLatestEnviromentDataOnSuccess:(nullable void (^)(id _Nullable responseObject))success
                                   failure:(nullable void (^)(NSError *error))failure
{
    [self fetchEnviromentDataForDate:[NSDate date] success:success failure:failure];
}

@end
