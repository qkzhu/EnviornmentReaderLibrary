//
//  ViewController.m
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "ViewController.h"
#import "ERNetworkManager.h"
#import "ERDataManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ERNetworkManager *nm = [ERNetworkManager new];
    [nm fetchLatestEnviromentDataOnSuccess:^(id  _Nullable responseObject) {
         NSLog(@"successful");
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"failure");
    }];
    
    ERDataManager *dm = [ERDataManager new];
    NSLog(@"received data: %@", [dm getData]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
