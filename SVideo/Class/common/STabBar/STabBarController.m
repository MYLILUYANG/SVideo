//
//  STabBarController.m
//  SVideo
//
//  Created by liluyang on 2017/12/5.
//  Copyright © 2017年 SVideo. All rights reserved.
//

#import "STabBarController.h"
#import "SHomeController.h"
#import "SPublishController.h"
#import "SProfileController.h"

@interface STabBarController ()

@end

@implementation STabBarController

+(void)initialize
{
//    文字字体颜色和大小
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGBA(180, 180, 180, 1), NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica" size:18.0f],NSFontAttributeName,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGBA(255, 255, 255, 1), NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica" size:20.0f],NSFontAttributeName,nil] forState:UIControlStateSelected];
//    设置文字位置
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -10)];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    SHomeController *home = [[SHomeController alloc] init];
    [self setItemWithController:home title:@"首页" normalImag:@"" selImg:@""];
    
    SPublishController *publish = [[SPublishController alloc] init];
    [self setItemWithController:publish title:@"发布" normalImag:@"" selImg:@""];
    
    SProfileController *profile = [[SProfileController alloc] init];
    [self setItemWithController:profile title:@"我" normalImag:@"" selImg:@""];
    
    self.tabBar.backgroundImage = [self imageWithColor:RGBA(255, 255, 255, 0)];
    
    
}
//颜色转图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f,0.0f, 1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)setItemWithController:(UIViewController *)controller title:(NSString *)title normalImag:(NSString *)normalImg selImg:(NSString *)selImg{
    
    controller.title = title;
    controller.tabBarItem.title = title;
    controller.tabBarItem.selectedImage = [UIImage imageNamed:selImg];
    controller.tabBarItem.image = [UIImage imageNamed:normalImg];
    controller.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 0, -3, 0);
    
    UINavigationController *Nav = [[UINavigationController alloc] initWithRootViewController:controller];
    
    [self addChildViewController:Nav];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
