//
//  ERHelper.m
//  EnvironmentReader
//
//  Created by QianKun on 8/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "ERHelper.h"

@implementation ERHelper

+ (nullable NSDate *)dateFromString:(NSString *)dateStr format:(NSString *)formatStr
{
    if (!dateStr || !formatStr) { return nil; }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatStr];
    return [dateFormatter dateFromString: dateStr];
}

@end
