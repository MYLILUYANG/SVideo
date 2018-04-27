//
//  SProfileController.m
//  SVideo
//
//  Created by liluyang on 2017/11/25.
//  Copyright © 2017年 SVideo. All rights reserved.
//

#import "SProfileController.h"

@interface SProfileController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation SProfileController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    CGFloat width = K_ScreenWidth;
    CGFloat height = k_ScreenHeight;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64 , width, height -64 + 34 )];
    // 2.创建URL
    NSURL *url = [NSURL URLWithString:@"https://m.tamaidan.com/personalCenter"];
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 4.加载网页
    [webView loadRequest:request];
    // 5.最后将webView添加到界面
    [self.view addSubview:webView];
//    self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
//    self.webView.scroview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever
    self.webView = webView;
  
    
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
