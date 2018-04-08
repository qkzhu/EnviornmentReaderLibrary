//
//  ERDataCell.h
//  EnvironmentReader
//
//  Created by QianKun on 8/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ERDataCell : UITableViewCell

- (void)updateCellWithTitle:(NSString *)title value:(NSString *)value firstRow:(BOOL)firstFlag;

@end

NS_ASSUME_NONNULL_END
