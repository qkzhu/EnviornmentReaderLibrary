//
//  NetworkInterface.h
//  EnvironmentReaderLibrary
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef NetworkInterface_h
#define NetworkInterface_h

NS_ASSUME_NONNULL_BEGIN

@protocol NetworkInterface <NSObject>

- (void)GET:(nonnull NSString *)URLString
 parameters:(nullable id)parameters
    success:(nullable void (^)(id _Nullable responseObject))success
    failure:(nullable void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END

#endif /* NetworkInterface_h */
