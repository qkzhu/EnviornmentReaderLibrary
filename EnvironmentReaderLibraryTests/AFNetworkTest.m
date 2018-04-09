//
//  AFNetworkTest.m
//  EnvironmentReaderLibraryTests
//
//  Created by QianKun on 9/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AFNetworkHandler.h"

@interface AFNetworkTest : XCTestCase
@property (strong, nonatomic) AFNetworkHandler *afNetworkHandler;
@end

@implementation AFNetworkTest

- (void)setUp
{
    [super setUp];
    self.afNetworkHandler = [AFNetworkHandler new];
}

- (void)tearDown
{
    [super tearDown];
    self.afNetworkHandler = nil;
}

- (void)testNetworkCallWithEmptyData
{
    XCTAssertNotNil(self.afNetworkHandler);
//    [self.afNetworkHandler GET:@"" parameters:nil success:^(id  _Nullable responseObject) {
//        XCTAssertNotNil(responseObject);
//    } failure:^(NSError * _Nonnull error) {
//        XCTAssertNotNil(responseObject);
//    }];
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
