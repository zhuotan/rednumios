//
//  ViewController.h
//  rednumios
//
//  Created by 谭卓 on 2017/5/13.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"
#import "AFNetworking.h"
#import "UIView+MJExtension.h"
#import "MJRefresh.h"
#import "LCBannerView.h"
#import "object.h"
#import "ArticalViewCell.h"
#import "PYSearch.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

    @property (weak, nonatomic) IBOutlet UIScrollView *topview;

    @property (weak, nonatomic) IBOutlet UITableView *tableView;

    @property (nonatomic, weak) LCBannerView *bannerView;

    @property (strong,nonatomic) NSMutableArray *itmes;

    @property (nonatomic, strong) NSMutableDictionary *imagesDict;

    @property (nonatomic, strong) NSMutableDictionary *operationsDict;

    @property (nonatomic, strong) NSOperationQueue *queue;
@end

