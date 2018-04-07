//
//  NetworkInterface.h
//  EnvironmentReaderLibrary
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkInterface <NSObject>

- (void)GET:(NSString *)URLString
 parameters:(nullable id)parameters
    success:(nullable void (^)(id _Nullable responseObject))success
    failure:(nullable void (^)(NSError *error))failure;

@end
