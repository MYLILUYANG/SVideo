//
//  SHomeModel.h
//  SVideo
//
//  Created by liluyang on 2017/12/6.
//  Copyright © 2017年 SVideo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHomeModel : NSObject

/**
 视频url
 */
@property (nonatomic, strong) NSString *videoUrl;

/**
 用户头像url
 */
@property (nonatomic, strong) NSString *userHeader;

/**
 视频简介
 */
@property (nonatomic, strong) NSString *videoIntroduce;

/**
 视频标签  这里应该使用枚举值
 */
@property (nonatomic, assign) NSInteger videoTag;


@property (nonatomic, strong) NSString *testImageStr;

@property (nonatomic, assign) BOOL isPlay;

@end
