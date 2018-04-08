//
//  ERMapVC.h
//  EnvironmentReader
//
//  Created by QianKun on 8/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

NS_ASSUME_NONNULL_BEGIN

@class ERDailyData;
@class ERRegion;

@interface ERMapVC : UIViewController

- (void)updateWithTitle:(NSString *)title withData:(ERDailyData *)data regionData:(NSArray<ERRegion *> *)rData;

@end

NS_ASSUME_NONNULL_END
