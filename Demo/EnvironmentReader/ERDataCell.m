//
//  ERDataCell.m
//  EnvironmentReader
//
//  Created by QianKun on 8/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "ERDataCell.h"

@interface ERDataCell()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblValue;

@end

@implementation ERDataCell

#pragma mark - life cycle
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    CGColorRef borderColor = [UIColor.blackColor CGColor];
    CGFloat borderWidth = 1;
    
    self.lblTitle.layer.borderColor = borderColor;
    self.lblTitle.layer.borderWidth = borderWidth;
    self.lblValue.layer.borderColor = borderColor;
    self.lblValue.layer.borderWidth = borderWidth;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - function
- (void)updateCellWithTitle:(NSString *)title value:(NSString *)value firstRow:(BOOL)firstFlag
{
    self.lblTitle.text = title;
    self.lblValue.text = value;
    
    UIColor *bgColor =firstFlag ? UIColor.grayColor : UIColor.whiteColor;
    self.lblTitle.backgroundColor = bgColor;
    self.lblValue.backgroundColor = bgColor;
}

@end
