//
//  MockLocalDataHandler.h
//  EnvironmentReaderLibrary
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocalDataInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface MockLocalDataHandler : NSObject <LocalDataInterface>

- (NSString *)getData;

@end

NS_ASSUME_NONNULL_END
