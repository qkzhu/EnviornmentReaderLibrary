//
//  ERDataManager.m
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "ERDataManager.h"
#import <EnvironmentReaderLibrary/LocalDataInterface.h>
#import <EnvironmentReaderLibrary/MockLocalDataHandler.h>

@interface ERDataManager()

@property (strong, nonatomic) id<LocalDataInterface> localDataHandler;

@end

@implementation ERDataManager

- (instancetype)init
{
    if (self = [super init])
    {
        self.localDataHandler = [MockLocalDataHandler new];
    }
    
    return self;
}

- (NSString *)getData
{
    return [self.localDataHandler getData];
}

@end
