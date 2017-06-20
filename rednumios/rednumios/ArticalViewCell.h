//
//  ArticalViewCell.h
//  rednumios
//
//  Created by 谭卓 on 2017/5/16.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticalViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoimg;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *keys;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UILabel *pubtime;
@property (weak, nonatomic) IBOutlet UILabel *preview;
@end
