//
//  AFNetworkHandler.m
//  EnvironmentReaderLibrary
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "AFNetworkHandler.h"
#import <AFNetworking/AFNetworking.h>

@implementation AFNetworkHandler

- (void)GET:(nonnull NSString *)urlString
 parameters:(nullable id)parameters
    success:(nullable void (^)(id _Nullable responseObject))success
    failure:(nullable void (^)(NSError *error))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager new];
    mgr.requestSerializer = [AFHTTPRequestSerializer new];
    mgr.responseSerializer = [AFHTTPResponseSerializer new];
    [mgr GET:urlString parameters:parameters
    progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
