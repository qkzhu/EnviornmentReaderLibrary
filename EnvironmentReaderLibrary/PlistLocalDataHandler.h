//
//  PlistLocalDataHandler.h
//  EnvironmentReaderLibrary
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocalDataInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlistLocalDataHandler : NSObject <LocalDataInterface>

- (instancetype)initWithPlistPath:(nonnull NSString *)plistPath;

@end

NS_ASSUME_NONNULL_END
