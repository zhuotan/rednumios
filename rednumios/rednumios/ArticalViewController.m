//
//  ArticalViewController.m
//  rednumios
//
//  Created by 谭卓 on 2017/5/20.
//  Copyright © 2017年 谭卓. All rights reserved.
//

#import "ArticalViewController.h"

@interface ArticalViewController ()

@end

@implementation ArticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    //CGRect rectNav = self.navigationController.navigationBar.frame;
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.hrefurl]];
    [self.view addSubview: self.webView];
    [self.webView loadRequest:request];
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
