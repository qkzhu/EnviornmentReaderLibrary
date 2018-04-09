//
//  ERDataManagerTest.m
//  EnvironmentReaderTests
//
//  Created by QianKun on 9/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ERDataManager.h"

@interface ERDataManagerTest : XCTestCase
@property (strong, nonatomic) ERDataManager *erDataMgr;
@end

@implementation ERDataManagerTest

- (void)setUp
{
    [super setUp];
    self.erDataMgr = [ERDataManager new];
}

- (void)tearDown
{
    [super tearDown];
    self.erDataMgr = nil;
}

- (void)testSaveStringData{
    [self.erDataMgr saveData:@"" onComplete:^(BOOL result) {
        XCTAssertFalse([NSThread isMainThread]);
        XCTAssertFalse(result);
    }];
}

- (void)testSaveArrayData{
    [self.erDataMgr saveData:@[@1,@2] onComplete:^(BOOL result) {
        XCTAssertFalse(result);
    }];
}

- (void)testSaveAndRetrieveData
{
    NSDictionary *data = [NSDictionary dictionaryWithObject:@"data" forKey:@"key"];
    [self.erDataMgr saveData:data onComplete:^(BOOL result) {
        XCTAssertTrue(result);
        [self.erDataMgr getDataOnComplete:^(id _Nonnull data) {
            XCTAssertNotNil(data);
            XCTAssertTrue([data isKindOfClass:[NSDictionary class]]);
            NSDictionary *receivedData = (NSDictionary *)data;
            NSString *value = [receivedData objectForKey:@"key"];
            XCTAssertNotNil(value);
            XCTAssertTrue([value isEqualToString:@"data"]);
        }];
    }];
}

@end
