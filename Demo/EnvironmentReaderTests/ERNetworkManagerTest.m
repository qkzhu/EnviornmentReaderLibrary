//
//  ERNetworkManagerTest.m
//  EnvironmentReaderTests
//
//  Created by QianKun on 9/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ERNetworkManager.h"

@interface ERNetworkManagerTest : XCTestCase
@property (strong, nonatomic) ERNetworkManager *networkMgr;
@end

@implementation ERNetworkManagerTest

- (void)setUp
{
    [super setUp];
    self.networkMgr = [ERNetworkManager new];
}

- (void)tearDown
{
    [super tearDown];
    self.networkMgr = nil;
}

- (void)testFetchData
{
    [self.networkMgr fetchLatestEnviromentDataOnSuccess:^(id  _Nullable responseObject) {
        XCTAssertNotNil(responseObject);
        XCTAssertTrue([responseObject isKindOfClass:[NSDictionary class]]);
    } failure:^(NSError * _Nonnull error) {
        XCTAssertNotNil(error);
    }];
}

@end
