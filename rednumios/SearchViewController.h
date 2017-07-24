//
//  SearchViewController.h
//  rednumios
//
//  Created by 谭卓 on 2017/5/23.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "UIView+MJExtension.h"
#import "MJRefresh.h"
#import "object.h"
#import "ArticalViewCell.h"

@interface SearchViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
    @property (strong,nonatomic) NSString *find;
    
    @property (weak, nonatomic) IBOutlet UITableView *tableView;
    
    @property (strong,nonatomic) NSMutableArray *itmes;
    
    @property (nonatomic, strong) NSMutableDictionary *imagesDict;
    
    @property (nonatomic, strong) NSMutableDictionary *operationsDict;
    
    @property (nonatomic, strong) NSOperationQueue *queue;
    
    @property (nonatomic, strong) NSString  *URLString;
    
    @property (nonatomic, strong) NSString  *HrefString0;
    
    @property (nonatomic, strong) NSString  *HrefString;
    
    @property  int  page;
    
    @property (nonatomic, strong) NSURL *URL;
    
    @property (nonatomic, strong) NSURLSessionDataTask *dataTask;
    
    @property (nonatomic, strong) NSURLSessionConfiguration *configuration;
    
    @property (nonatomic, strong) AFHTTPSessionManager *manager;
@end
