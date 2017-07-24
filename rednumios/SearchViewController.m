//
//  SearchViewController.m
//  rednumios
//
//  Created by 谭卓 on 2017/5/23.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()


@end




@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    NSLog(@"find = %@",self.find);
    
    self.URLString  = @"http://rednum.cn/ViewListAction?method=pagex";
    self.HrefString = @"https://rednum.cn/ViewListAction?method=detail&dataid=";
    self.HrefString0 = @"";
    self.page = 1;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.itmes = [[NSMutableArray alloc] init];
    
    self.configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:self.configuration];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    __weak __typeof(self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
}
- (void)loadNewData{
    // 获取数据
    NSString  *PageString = [self.URLString stringByAppendingString:@"&page="];
    NSString *stringInt = [NSString stringWithFormat:@"%d",1];
    PageString =[PageString stringByAppendingString:stringInt];
    
    PageString = [PageString stringByAppendingString:@"&findword="];
    PageString = [PageString stringByAppendingString:self.find];
    
    self.URL = [NSURL URLWithString:PageString];
    
    __weak UITableView *tableView = self.tableView;
    NSURLRequest *request = [NSURLRequest requestWithURL:self.URL];
    
    self.dataTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id data, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            //NSLog(@"%@ %@", response, data);
            self.page = 1;
            [self.itmes removeAllObjects];
            NSArray *array = data;
            for(NSDictionary* dic in array) {
                RootObject *product = [[RootObject alloc] initWithDictionary:dic];
                [self.itmes addObject: product];
            }
            // 刷新表格
            [tableView reloadData];
            
            // 拿到当前的下拉刷新控件，结束刷新状态
            [self.tableView.mj_header endRefreshing];
        }
    }];
    [self.dataTask resume];
}
-(void)loadMoreData{
    self.page = self.page + 1;
    NSString  *PageString = [self.URLString stringByAppendingString:@"&page="];
    NSString *stringInt = [NSString stringWithFormat:@"%d",self.page];
    PageString =[PageString stringByAppendingString:stringInt];
    
    PageString = [PageString stringByAppendingString:@"&findword="];
    PageString = [PageString stringByAppendingString:self.find];
    
    self.URL = [NSURL URLWithString:PageString];
    __weak UITableView *tableView = self.tableView;
    NSURLRequest *request = [NSURLRequest requestWithURL:self.URL];
    self.dataTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id data, NSError *error) {
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
            [self.tableView.mj_footer endRefreshing];
        }
    }];
    [self.dataTask resume];
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
    self.HrefString0 = [self.HrefString stringByAppendingString:[item.pid stringValue]];
    [self performSegueWithIdentifier:@"detailSegue" sender:self.HrefString0];
}
    
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *destination =segue.destinationViewController;
    if([segue.identifier isEqualToString:@"detailSegue"]){
        [destination setValue:sender forKey:@"hrefurl"];
    }
    [destination setValue:self forKey:@"delegate"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
