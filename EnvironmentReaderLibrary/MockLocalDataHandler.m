//
//  MockLocalDataHandler.m
//  EnvironmentReaderLibrary
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "MockLocalDataHandler.h"

@implementation MockLocalDataHandler

- (BOOL)saveData:(nonnull id)data toPath:(nonnull NSString *)pathString
{
    return YES;
}

- (nullable id)getDataFromPath:(nonnull NSString *)pathString
{
    return pathString;
}

@end
