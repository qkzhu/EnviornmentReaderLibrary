//
//  DisplayDataVC.h
//  EnvironmentReader
//
//  Created by QianKun on 8/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@class ERDailyData;

@interface DisplayDataVC : UIViewController

- (void)updateWithTitle:(NSString *)title withData:(ERDailyData *)data forViewType:(eViewType)viewType;

@end
