//
//  SHomeCell.m
//  SVideo
//
//  Created by liluyang on 2017/12/6.
//  Copyright © 2017年 SVideo. All rights reserved.
//

#import "SHomeCell.h"
#import "SHomeModel.h"
#import "WMPlayer.h"
#import <TXVodPlayer.h>
#import <TXVodPlayConfig.h>
#import <TXVodPlayListener.h>

#define margin k_Width(60)
#define userHeaderW k_Width(50)
@interface SHomeCell ()<TXVodPlayListener>

/**
 用户信息存放view
 */
@property (nonatomic, strong) UIView *userInfoView;

@property (nonatomic, strong) TXVodPlayer *vodPlayer;


/**
 简介label
 */
@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UIImageView *testImageView;

@property (nonatomic, strong) NSMutableArray *playVideoArray;

@end

@implementation SHomeCell

-(void) onPlayEvent:(TXVodPlayer *)player event:(int)EvtID withParam:(NSDictionary*)param
{
    NSLog(@"%@",param);
}
-(void) onNetStatus:(TXVodPlayer *)player withParam:(NSDictionary*)param
{
    NSLog(@"%@",param);
}
-(void)play:(BOOL)play index:(NSInteger)index videoArray:(NSMutableArray *)videoArray
{
//    self.playVideoArray = videoArray;
//    if (index == 0) {
//        [self.vodPlayer setupVideoWidget:self.contentView insertIndex:0];
//        SHomeModel *model = videoArray[0];
//        
//        if (play) {
//            [self.vodPlayer startPlay:model.videoUrl];
//            
//        }else{
//            // 停止播放
//            [self.vodPlayer stopPlay];
//            
//            // 移除播放视图
//            [self.vodPlayer removeVideoWidget];
//            
//            [self removeFromSuperview];
//        }
//        
//        NSLog(@"%d, %d", self.vodPlayer.height, self.vodPlayer.width);
//        
//    }else if (index == 2){
//        
//        [self.vodPlayer setupVideoWidget:self.contentView insertIndex:0];
//        SHomeModel *model = videoArray[0];
//        
//        if (play) {
//            [self.vodPlayer startPlay:model.videoUrl];
//            
//        }else{
//            // 停止播放
//            [self.vodPlayer stopPlay];
//            // 移除播放视图
//            [self.vodPlayer removeVideoWidget];
//        }
//    }
    
    
//    NSLog(@" %ld 数组长度%ld 播放器状态%ld",index, videoArray.count, self.videoPlayer.state);
    
    
//    if (index == 0) {
//        [self addSubview:self.videoPlayer];
//        SHomeModel *model = videoArray[0];
//        self.videoPlayer.URLString = model.videoUrl;
//
////        NSLog(@"%@ 数组长度%ld 播放器状态%ld",model.videoUrl, videoArray.count, self.videoPlayer.state);
//        if (play) {
//            [self.videoPlayer play];
//        }else{
//            [self.videoPlayer pause];
//        }
//
//
//    }else if (index == 1){
//
//        [self addSubview:self.videoPlayer2];
//        SHomeModel *model = videoArray[1];
//        self.videoPlayer2.URLString = model.videoUrl;
//        if (play) {
//            [self.videoPlayer2 play];
//        }else{
//            [self.videoPlayer2 pause];
//        }
//
//    }else if (index == 2){
//        [self addSubview:self.videoPlayer3];
//        SHomeModel *model = videoArray[0];
//        self.videoPlayer3.URLString = model.videoUrl;
//
//        if (play) {
//            [self.videoPlayer3 play];
//        }else{
//            [self.videoPlayer3 pause];
//        }
//    }
}

-(void)playWith:(NSString *)URLString player:(WMPlayer *)player{
    player.placeholderImage = [UIImage imageWithColor:[UIColor grayColor]];
    player.URLString = URLString;
    player.backgroundColor = K_RandColor;
    [player player];
}

-(instancetype)init
{
    if (self = [super init]) {
         [self setupViews];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(8.0, 8.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    self.layer.masksToBounds = YES;
    
//    self.testImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    
    self.backgroundColor = [UIColor blackColor];
}

-(UIImageView *)testImageView
{
    if (!_testImageView) {
        _testImageView = [[UIImageView alloc] init];
        _testImageView.clipsToBounds = YES;
        _testImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _testImageView;
}

-(NSMutableArray *)playVideoArray
{
    if (!_playVideoArray) {
        _playVideoArray = [NSMutableArray array];
    }
    return _playVideoArray;
}

-(void)setupViews
{
//    播放的view
    [self.contentView addSubview:self.testImageView];
//    self.contentView.backgroundColor = K_RandColor;
}

-(void)tap:(UITapGestureRecognizer *)tap
{
//    CGPoint point = [tap locationInView:self];
//    NSLog(@"%@",NSStringFromCGPoint(point));
    if (_delegate && [_delegate respondsToSelector:@selector(tapClickView:)]) {
        [_delegate tapClickView:self];
    }
}

-(void)doubleTap:(UITapGestureRecognizer *)doubleTap
{
//    CGPoint point = [doubleTap locationInView:self];
//       NSLog(@"%@",NSStringFromCGPoint(point));
    if (_delegate && [_delegate respondsToSelector:@selector(doubleTapClickView:)]) {
        [_delegate doubleTapClickView:self];
    }
}



-(void)setVideoModel:(SHomeModel *)videoModel
{
    _videoModel = videoModel;
//    [_testImageView sd_setImageWithURL:[NSURL URLWithString:videoModel.testImageStr] placeholderImage:[UIImage imageWithColor:[UIColor grayColor]]];
}


-(TXVodPlayer *)vodPlayer
{
    if (!_vodPlayer) {
        _vodPlayer = [TXVodPlayer new];
        _vodPlayer.vodDelegate = self;
        _vodPlayer.loop = YES;
        [_vodPlayer setRenderMode:RENDER_MODE_FILL_SCREEN];
    }
    return _vodPlayer;
}

-(void)selectAll:(id)sender
{
    NSLog(@"%@",sender);
}

#pragma mark - lazyload

-(UIView *)videoPlayView
{
    if (!_videoPlayView) {
        _videoPlayView = [UIView new];
        _videoPlayView.userInteractionEnabled = YES;
        _videoPlayView.frame = self.bounds;
        
        
        
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//        tap.numberOfTapsRequired = 1;
//        tap.numberOfTouchesRequired = 1;
//        [_videoPlayView addGestureRecognizer:tap];
        
//        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
//        doubleTap.numberOfTapsRequired = 2;
//        doubleTap.numberOfTouchesRequired = 1;
//        [_videoPlayView addGestureRecognizer:doubleTap];
//        当双击手势无法识别的时候才会调用单击手势
//        [tap requireGestureRecognizerToFail:doubleTap];
        
//        _videoPlayView.backgroundColor = [UIColor redColor];
        
        
    }
    return _videoPlayView;
}

-(UIView *)userInfoView{
    if (!_userInfoView) {
        _userInfoView = [UIView new];

        
//        [_userInfoView addSubview:self.userHeaderImageView];
        
    }
    return _userInfoView;
}

-(UILabel *)introduceLabel
{
    if(!_introduceLabel){
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, K_ScreenWidth, k_Height(30))];
        
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor redColor];

        _introduceLabel = label;
    }
    return _introduceLabel;
}
@end
