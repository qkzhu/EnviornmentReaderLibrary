//
//  ERDataCell.h
//  EnvironmentReader
//
//  Created by QianKun on 8/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ERDataCell : UITableViewCell

- (void)updateCellWithTitle:(NSString *)title value:(NSString *)value firstRow:(BOOL)firstFlag;

@end
