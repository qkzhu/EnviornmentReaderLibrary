//
//  MockLocalDataHandler.m
//  EnvironmentReaderLibrary
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "MockLocalDataHandler.h"

@implementation MockLocalDataHandler

- (NSString *)getData
{
    return NSStringFromClass([self class]);
}

@end
