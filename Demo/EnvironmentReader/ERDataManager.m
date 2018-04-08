//
//  ERDataManager.m
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "ERDataManager.h"
#import <EnvironmentReaderLibrary/LocalDataInterface.h>
#import <EnvironmentReaderLibrary/PlistLocalDataHandler.h>
#import "Constants.h"


@interface ERDataManager()

@property (strong, nonatomic) id<LocalDataInterface> localDataHandler;
@property (strong, nonatomic) NSString *plistFullPath;

@end

@implementation ERDataManager

#pragma mark - life cycle
- (instancetype)init
{
    if (self = [super init])
    {
        self.localDataHandler = [[PlistLocalDataHandler alloc] initWithPlistPath:self.plistFullPath];
    }
    
    return self;
}

- (void)dealloc
{
    self.localDataHandler = nil;
    self.plistFullPath = nil;
}

#pragma mark - public functions
- (void)saveData:(nonnull id)data onComplete:(nullable void (^)(BOOL))complete
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL saveResult = [self.localDataHandler saveData:data toPath:self.plistFullPath];
        complete(saveResult);
    });
}

- (void)getDataOnComplete:(nullable void (^)(id))complete;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id retrievedData = [self.localDataHandler getDataFromPath:self.plistFullPath];
        complete(retrievedData);
    });
}

#pragma mark - private functions
- (NSString *)plistFullPath
{
    if (!_plistFullPath)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        _plistFullPath = [documentsPath stringByAppendingPathComponent:PLIST_NAME];
    }
    return _plistFullPath;
}

- (BOOL)isPlistExist { return [[NSFileManager defaultManager] fileExistsAtPath:self.plistFullPath]; }

@end
