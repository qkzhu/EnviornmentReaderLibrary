//
//  PlistLocalDataHandler.m
//  EnvironmentReaderLibrary
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "PlistLocalDataHandler.h"

@interface PlistLocalDataHandler()

@property (strong, nonatomic) NSString *plistPath;

@end


@implementation PlistLocalDataHandler

#pragma mark - life cycle
- (instancetype)initWithPlistPath:(nonnull NSString *)plistPath
{
    if (self = [super init])
    {
        self.plistPath = plistPath;
    }
    
    return self;
}

- (void)dealloc
{
    self.plistPath = nil;
}

#pragma mark - LocalDataInterface impl
- (BOOL)saveData:(nonnull id)data toPath:(nonnull NSString *)pathString
{
    if (![data isKindOfClass:[NSDictionary class]]) { return NO; }
    
    NSError *error = nil;
    NSData *plistData = [NSPropertyListSerialization dataWithPropertyList:data
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                                  options:0
                                                                    error:&error];
    
    if (plistData) { return [plistData writeToFile:pathString atomically:YES]; }
    else { return NO; }
}

- (nullable id)getDataFromPath:(nonnull NSString *)pathString
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:pathString]) { return nil; }
    
    return  [[NSDictionary alloc] initWithContentsOfFile:pathString];
}

#pragma mark - private functions

@end
