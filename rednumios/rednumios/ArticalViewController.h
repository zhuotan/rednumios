//
//  ArticalViewController.h
//  rednumios
//
//  Created by 谭卓 on 2017/5/20.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import "ViewController.h"
#import "object.h"
@interface ArticalViewController : ViewController

@property (weak,nonatomic) NSString *hrefurl;
@property (weak,nonatomic) id delegate;
@property (nonatomic,strong) UIWebView *webView;
@end
