//
//  SFilterSelView.h
//  SVideo
//
//  Created by liluyang on 2018/5/4.
//  Copyright © 2018年 SVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFilterSelView : UIView
@property (nonatomic, copy) void (^callBack)(NSInteger index, GPUImageOutput<GPUImageInput> *filter);
@end

@interface FilterChooseCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *iconImage;

@property (nonatomic, strong) UILabel *nameLabel;

@end
