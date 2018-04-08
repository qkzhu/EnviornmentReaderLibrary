//
//  ERHelper.h
//  EnvironmentReader
//
//  Created by QianKun on 8/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERHelper : NSObject

+ (nullable NSDate *)dateFromString:(NSString *)dateStr format:(NSString *)formatStr;
+ (nullable NSString *)convertDate:(NSDate *)date toStringWithFormat:(NSString *)formatStr;

@end
