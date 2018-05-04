//
//  SEditView.m
//  SVideo
//
//  Created by liluyang on 2018/5/3.
//  Copyright © 2018年 SVideo. All rights reserved.
//

#import "SEditView.h"

@implementation SEditView
 -(instancetype)init
{
    if (self =[super init]) {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.text = @"hhhhh";
    label.backgroundColor = [UIColor redColor];
    [self addSubview:label];
}

@end
