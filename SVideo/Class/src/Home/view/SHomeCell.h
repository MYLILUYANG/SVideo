//
//  SHomeCell.h
//  SVideo
//
//  Created by liluyang on 2017/12/6.
//  Copyright © 2017年 SVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SHomeDelegate;

@class SHomeModel;



@interface SHomeCell : UICollectionViewCell

@property (nonatomic, strong) SHomeModel *videoModel;

@property (nonatomic, assign) id<SHomeDelegate> delegate;

//+(instancetype)collectionViewWithIndexpath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)colletionView;
/**
 视频播放的view
 */
@property (nonatomic, strong) UIView *videoPlayView;

-(void)play:(BOOL)play index:(NSInteger)index videoArray:(NSMutableArray *)videoArray;

@end

@protocol SHomeDelegate<NSObject>

-(void)tapClickView:(SHomeCell *)cell;

-(void)doubleTapClickView:(SHomeCell *)cell;



@end
