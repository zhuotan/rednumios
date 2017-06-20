//
//  ViewController.m
//  rednumios
//
//  Created by 谭卓 on 2017/5/13.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

NSString  *URLString = @"http://rednum.cn/ViewListAction?method=pagex";
NSString  *HrefString = @"https://rednum.cn/ViewListAction?method=detail&dataid=";
NSString  *HrefString0 = @"";
int page = 1;
NSURL *URL;
NSURLSessionDataTask *dataTask;
NSURLSessionConfiguration *configuration;
AFHTTPSessionManager *manager;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.tableView.scrollEnabled = NO;
    
    [self creatSearchBar];
    /******************** internet ********************/
    NSArray *URLs = @[@"https://rednum.cn/img/banner-1.png",
                      @"https://rednum.cn/img/banner-2.png",
                      @"https://rednum.cn/img/banner-3.png"];
    
    [self.topview addSubview:({
        
        LCBannerView *bannerView = [LCBannerView bannerViewWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, 120.0f)
                                                            delegate:nil
                                                           imageURLs:URLs
                                                placeholderImageName:nil
                                                        timeInterval:2.0f
                                       currentPageIndicatorTintColor:[UIColor redColor]
                                              pageIndicatorTintColor:[UIColor whiteColor]];
        bannerView.didClickedImageIndexBlock = ^(LCBannerView *bannerView, NSInteger index) {
            
            //NSLog(@"Block: Clicked image in %p at index: %d", bannerView, (int)index);
        };
        
        bannerView.didScrollToIndexBlock = ^(LCBannerView *bannerView, NSInteger index) {
            
            //NSLog(@"Block: Scrolled in %p to index: %d", bannerView, (int)index);
        };
        bannerView.hidePageControl = NO;
        self.bannerView = bannerView;
    })];
    
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    
    self.itmes = [[NSMutableArray alloc] init];
    configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    __weak __typeof(self) weakSelf = self;
    
    self.topview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    self.topview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       [weakSelf loadMoreData];
    }];
    [self.topview.mj_header beginRefreshing];
}

-(void)creatSearchBar
{
    UITextField *text = [[UITextField alloc] init];
    text.frame = CGRectMake(0, 0, 300, 26);
    
    //文字垂直居中
    text.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    text.backgroundColor = [UIColor colorWithRed:73.0f/255.0f green:148.0f/255.0f blue:230.0f/255.0f alpha:0.1];
    text.layer.cornerRadius = 5;
    text.font = [UIFont systemFontOfSize:12];
    text.placeholder = @"搜索 标题|内容|作者";
    //搜索图标
    UIImageView *view = [[UIImageView alloc] init];
    view.image = [UIImage imageNamed:@"search.png"];
    view.frame = CGRectMake(0, 0, 35, 35);
    //左边搜索图标的模式
    view.contentMode = UIViewContentModeCenter;
    text.leftView = view;
    //左边搜索图标总是显示
    text.leftViewMode = UITextFieldViewModeAlways;
    //右边删除所有图标
    text.clearButtonMode = UITextFieldViewModeAlways;
    
    text.delegate = self;
    
    self.navigationItem.titleView = text;

}

#pragma -mark -doClickActions
-(void)searchViewPress:(UIGestureRecognizer *)tap
{
    
}

-(void)textFieldDidBeginEditing:(UITextField*)textField

{
    //SearchViewController *search=[[SearchViewController alloc]init];
    //[self.navigationController pushViewController:search animated:YES];
    SearchViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchView"];
    [self.navigationController pushViewController:view animated:YES];
    
}

- (void)loadNewData{
    // 获取数据
    NSString  *PageString = [URLString stringByAppendingString:@"&page="];
    NSString *stringInt = [NSString stringWithFormat:@"%d",page];
    PageString =[PageString stringByAppendingString:stringInt];
    URL = [NSURL URLWithString:PageString];
    
    __weak UITableView *tableView = self.tableView;
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id data, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            //NSLog(@"%@ %@", response, data);
            page = 1;
            [self.itmes removeAllObjects];
            NSArray *array = data;
            for(NSDictionary* dic in array) {
                RootObject *product = [[RootObject alloc] initWithDictionary:dic];
                [self.itmes addObject: product];
            }
            // 刷新表格
            [tableView reloadData];
            
            // 拿到当前的下拉刷新控件，结束刷新状态
            [self.topview.mj_header endRefreshing];
        }
    }];
    [dataTask resume];
}
-(void)loadMoreData{
    page = page + 1;
    NSString  *PageString = [URLString stringByAppendingString:@"&page="];
    NSString *stringInt = [NSString stringWithFormat:@"%d",page];
    PageString =[PageString stringByAppendingString:stringInt];
    URL = [NSURL URLWithString:PageString];
    __weak UITableView *tableView = self.tableView;
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id data, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            //NSLog(@"%@ %@", response, data);
            NSArray *array = data;
            for(NSDictionary* dic in array) {
                RootObject *product = [[RootObject alloc] initWithDictionary:dic];
                [self.itmes addObject: product];
            }
            // 刷新表格
            [tableView reloadData];
            
            // 拿到当前的下拉刷新控件，结束刷新状态
            [self.topview.mj_footer endRefreshing];
        }
    }];
    [dataTask resume];
}

- (NSMutableDictionary *)imagesDict {
    if (!_imagesDict) {
        _imagesDict = [NSMutableDictionary dictionary];
    }
    return _imagesDict;
}
- (NSMutableDictionary *)operations {
    if (!_operationsDict) {
        _operationsDict = [NSMutableDictionary dictionary];
    }
    return _operationsDict;
}
- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.itmes count];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifer = @"ArticalCell";
    RootObject *rootobject = [self.itmes objectAtIndex:[indexPath row]];
    
    ArticalViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer forIndexPath:indexPath];
    if(cell == nil){
        cell = [[ArticalViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
    }
    
    cell.title.text = rootobject.title;
    cell.author.text = rootobject.author;
    cell.preview.text = rootobject.content;
    cell.pubtime.text = rootobject.pubtime;
    cell.level.text = rootobject.level;
    cell.keys.text = rootobject.description;
    
    NSString *imageName = rootobject.logourl;
    
    UIImage *image = self.imagesDict[imageName];
    if (!image) {                   //image字典中没有图片
        NSOperation *operation = self.operationsDict[imageName];
        if (!operation) {           //queue中没有下载任务
            operation = [NSBlockOperation blockOperationWithBlock:^{
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageName]];
                UIImage *imageb = [UIImage imageWithData:imageData];
                
                self.imagesDict[imageName] = imageb;
                self.operationsDict[imageName] = nil;
                
                //主线程中刷新image
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.logoimg.image = imageb;
                });
            }];
            [self.queue addOperation:operation];
            self.operationsDict[imageName] = operation;
        } else {                    //正在下载
            cell.logoimg.image = [UIImage imageNamed:@"default"];
        }
    } else {
        cell.logoimg.image = image;
    }

 
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    RootObject *item = self.itmes[indexPath.row];
    HrefString0 = [HrefString stringByAppendingString:[item.pid stringValue]];
    [self performSegueWithIdentifier:@"taskSegue" sender:HrefString0];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *destination =segue.destinationViewController;
    if([segue.identifier isEqualToString:@"taskSegue"]){
        [destination setValue:sender forKey:@"hrefurl"];
    }
    [destination setValue:self forKey:@"delegate"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
