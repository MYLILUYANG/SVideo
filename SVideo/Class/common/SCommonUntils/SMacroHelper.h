//
//  SMacroHelper.h
//  SVideo
//
//  Created by liluyang on 2017/11/25.
//  Copyright © 2017年 SVideo. All rights reserved.
//

#ifndef SMacroHelper_h
#define SMacroHelper_h

#define K_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define k_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:a]

#define RandomColor RGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


// 机型判断
#define iPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

//  根据6 屏幕适配
#define k_Width(R) (R)*(K_ScreenWidth)/375 //这里的375我是针对6为标准适配的,如果需要其他标准可以修改
#define k_Height(R) k_Width(R) 

#define K_RGBA(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A ]
#define K_RGB(R,G,B) K_RGBA(R, G, B, 1)

#define K_RandColor [UIColor colorWithRed:rand()%255 / 255.0 green:rand()%255 / 255.0 blue:rand()%255 / 255.0 alpha:1]

//打印
#ifdef DEBUG
#define LYLog(fmt, ...) NSLog(fmt, ## __VA_ARGS__)
#else
#define LYLog(fmt, ...) nil
#endif

#endif /* SMacroHelper_h */
