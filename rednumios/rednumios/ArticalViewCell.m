//
//  ArticalViewCell.m
//  rednumios
//
//  Created by 谭卓 on 2017/5/16.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import "ArticalViewCell.h"

@implementation ArticalViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.logoimg.layer setCornerRadius:5];
    [self.logoimg.layer setMasksToBounds:YES];
    
  }
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
