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
#define margin k_Width(60)
#define userHeaderW k_Width(50)
@interface SHomeCell ()<WMPlayerDelegate>

/**
 用户信息存放view
 */
@property (nonatomic, strong) UIView *userInfoView;


/**
 视频简介
 */
@property (nonatomic, strong) UIView *videoIntriduceView;

/**
 用户头像
 */
@property (nonatomic, strong) UIImageView *userHeaderImageView;

/**
 视频播放类
 */

@property (nonatomic, strong) WMPlayer *videoPlayer;

/**
 简介label
 */
@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UIImageView *testImageView;
@end

@implementation SHomeCell

//+(instancetype)collectionViewWithIndexpath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)colletionView
//{
//    
//    static NSString *cellid =@"homeCellid";
//    
//    SHomeCell *cell = [colletionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    
//    if (!cell) {
//        cell = [[SHomeCell alloc] initWithFrame:CGRectMake(0, 0, K_ScreenWidth, k_ScreenHeight)];
//
//    }
    
//    return cell;
//}


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
    
//    self.testImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(8.0, 8.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    self.layer.masksToBounds = YES;
    
    self.videoPlayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.backgroundColor = K_RandColor;
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

-(void)setupViews
{
//    播放的view
//    [self.contentView addSubview:self.videoPlayView];
    [self.contentView addSubview:self.videoPlayer];

//    videoPlayer
    
//右侧展示view
//    [self.contentView addSubview:self.userInfoView];

//    [self.userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(margin * 3);
//        make.left.mas_equalTo(self.mas_right).mas_offset(-margin);
//        make.right.mas_equalTo(self.mas_right);
//        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-margin * 2);
//    }];
    
    //    底部展示信息
//    [self.contentView addSubview:self.videoIntriduceView];
    
//    [self.videoIntriduceView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.mas_equalTo(self.mas_bottom).mas_offset(-margin * 2 );
//        make.left.mas_equalTo(self.mas_left);
//        make.right.mas_equalTo(self.mas_right);
//        make.bottom.mas_equalTo(self.mas_bottom);
//    }];
    
    
//    UIView *videoView = [[UIView alloc] initWithFrame:CGRectMake(k_Width(30), k_Height(40), K_ScreenWidth-k_Height(60), k_ScreenHeight - k_Height(80))];
//    videoView.backgroundColor = K_RandColor;
//    [self addSubview:videoView];
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5.0, 5.0)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = self.frame;
//    maskLayer.path = path.CGPath;
//    self.layer.mask = maskLayer;

    
    self.contentView.backgroundColor = K_RandColor;
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
//    LYLog(@"%@",_videoModel.videoUrl);
    _videoPlayer.placeholderImage = [UIImage imageWithColor:[UIColor grayColor]];
    _videoPlayer.URLString = _videoModel.videoUrl;
    _videoPlayer.backgroundColor = K_RandColor;
    if (videoModel.isPlay) {
        [_videoPlayer pause];
    }else{
        [_videoPlayer play];
    }
    
    

    
    
//    设置用户头像
//    [self.userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:videoModel.userHeader]];
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    view.backgroundColor = [UIColor redColor];
//    [self.videoPlayView addSubview:view];
    
    
    
//        [self.videoPlayer  resetWMPlayer];
    
//    if (_videoPlayer) {
//
//    }


//    if (_videoPlayer.state == WMPlayerStatePlaying) {
//        self.videoPlayer.state = WMPlayerStateStopped;
//        [self.videoPlayer pause];
//        [self.videoPlayer removeFromSuperview];
//        _videoPlayer = nil;
//    }

//    [self.videoPlayView addSubview:self.videoPlayer];

//    [self.videoPlayer setURLString:videoModel.videoUrl];

//    [self.videoPlayer play];
    
//    self.introduceLabel.text = videoModel.videoIntroduce;
//    LYLog(@"%@",videoModel.videoIntroduce);

}

-(void)selectAll:(id)sender
{
    NSLog(@"%@",sender);
}


#pragma mark - WMPlayerDelegate
///播放器事件
//点击播放暂停按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedPlayOrPauseButton:(UIButton *)playOrPauseBtn
{
    LYLog(@"点击播放暂停按钮代理方法");
}
//点击关闭按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn
{
    LYLog(@"点击关闭按钮代理方法");
}
//点击全屏按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn
{
    
    LYLog(@"点击全屏按钮代理方法");
}
//单击WMPlayer的代理方法
-(void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap
{
    LYLog(@"单击WMPlayer的代理方法");
}
//双击WMPlayer的代理方法
-(void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap
{
    LYLog(@"双击WMPlayer的代理方法 增加点赞 ");
}
//WMPlayer的的操作栏隐藏和显示
-(void)wmplayer:(WMPlayer *)wmplayer isHiddenTopAndBottomView:(BOOL )isHidden
{
    LYLog(@"hidden");
}
///播放状态
//播放失败的代理方法
-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state
{
    
}
//准备播放的代理方法
-(void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state
{
    
}
//播放完毕的代理方法
-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer
{
    [wmplayer play];
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

        
        [_userInfoView addSubview:self.userHeaderImageView];
        
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

-(UIView *)videoIntriduceView
{
    if (!_videoIntriduceView) {
        _videoIntriduceView = [UIView new];
        _videoIntriduceView.backgroundColor = [UIColor yellowColor];
        [_videoIntriduceView addSubview:self.introduceLabel];
    }
    return _videoIntriduceView;
}

-(UIImageView *)userHeaderImageView
{
    if (!_userHeaderImageView) {
        
        _userHeaderImageView = [[UIImageView alloc] init];
        _userHeaderImageView.frame = CGRectMake(0, 0, userHeaderW, userHeaderW);
        _userHeaderImageView.layer.cornerRadius = userHeaderW * 0.5;
        _userHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
        _userHeaderImageView.layer.masksToBounds = YES;
        _userHeaderImageView.layer.borderWidth = 1;
        _userHeaderImageView.layer.borderColor = [UIColor yellowColor].CGColor;
    }
    return _userHeaderImageView;
}

-(WMPlayer *)videoPlayer
{
    if (!_videoPlayer) {
        _videoPlayer = [[WMPlayer alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _videoPlayer.backgroundColor = K_RandColor;
        _videoPlayer.delegate = self;
        _videoPlayer.titleLabel.hidden = YES;
        _videoPlayer.fullScreenBtn.hidden = YES;
        _videoPlayer.playOrPauseBtn.hidden = YES;
        _videoPlayer.closeBtn.hidden = YES;
        _videoPlayer.bottomView.hidden = YES;
        _videoPlayer.enableVolumeGesture = NO;
        _videoPlayer.enableFastForwardGesture = NO;
        _videoPlayer.playerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    return _videoPlayer;
}

@end
