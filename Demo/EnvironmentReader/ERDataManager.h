//
//  ERDataManager.h
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ERDataManager : NSObject

- (void)saveData:(nonnull id)data onComplete:(nullable void (^)(BOOL))complete;

- (void)getDataOnComplete:(nullable void (^)(id))complete;

@end

NS_ASSUME_NONNULL_END
