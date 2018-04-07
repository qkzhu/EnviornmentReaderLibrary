//
//  MockNetworkHandler.m
//  EnvironmentReaderLibrary
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "MockNetworkHandler.h"

@implementation MockNetworkHandler

- (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError *))failure
{
    success(@"hello");
}

@end
