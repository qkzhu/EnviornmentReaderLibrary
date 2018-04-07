//
//  ViewController.m
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "ViewController.h"
#import <NetworkHandler.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NetworkHandler *nh = [NetworkHandler new];
    [nh GET:@"test" parameters:nil success:^(id  _Nullable responseObject) {
        NSLog(@"successful");
    } failure:^(NSError *error) {
        NSLog(@"failure");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
