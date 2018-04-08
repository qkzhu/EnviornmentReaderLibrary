//
//  ERHistoryVC.h
//  EnvironmentReader
//
//  Created by QianKun on 8/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

NS_ASSUME_NONNULL_BEGIN

@class ERDailyData;

@interface ERHistoryVC : UITableViewController

@property (weak, nonatomic) NSArray<ERDailyData *> *dailyData;
@property (assign, nonatomic) eViewType vType;

@end

NS_ASSUME_NONNULL_END
