//
//  SEditVideoViewController.m
//  SVideo
//
//  Created by liluyang on 2018/5/3.
//  Copyright © 2018年 SVideo. All rights reserved.
//

#import "SEditVideoViewController.h"
#import "SEditView.h"
@interface SEditVideoViewController ()
@property (nonatomic, strong) AVPlayer * player;
@property (nonatomic, strong) UIImageView * showImageView;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayerItem *playItem;
@end

@implementation SEditVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.showImageView];
    
    SEditView *view = [[SEditView alloc] init];
    view.frame = CGRectMake(0, 0, K_ScreenWidth, k_ScreenHeight);
//    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [self.view insertSubview:view aboveSubview:self.showImageView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinish) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([object isKindOfClass:[AVPlayerItem class]]) {
        if ([keyPath isEqualToString:@"status"]) {
            switch (_playItem.status) {
                case AVPlayerItemStatusReadyToPlay:
                    //推荐将视频播放放在这里
                    [self.player play];
                    break;
                    
                case AVPlayerItemStatusUnknown:
                    NSLog(@"AVPlayerItemStatusUnknown");
                    break;
                    
                case AVPlayerItemStatusFailed:
                    NSLog(@"AVPlayerItemStatusFailed = %@",_playItem.error);
                    
                    break;
                    
                default:
                    break;
            }
            
        }
    }
}

-(void)setFilePathStr:(NSString *)filePathStr
{
    _filePathStr = filePathStr;

}

-(void)playFinish{
    
    [_player seekToTime:CMTimeMake(0, 1)];
    [self.player play];
}

-(void)rePlay
{
    
}

- (UIImageView *)showImageView{
    if (!_showImageView ){
        _showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, K_ScreenWidth, k_ScreenHeight)];
        _showImageView.contentMode = UIViewContentModeScaleAspectFill;
        AVPlayerLayer * playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        playerLayer.frame = _showImageView.bounds;

        [_showImageView.layer addSublayer:playerLayer];
        
        
    }
    return _showImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(AVPlayer *)player
{
    if (!_player) {
        _player = [AVPlayer playerWithPlayerItem:self.playItem];
    }
    return _player;
}

-(AVPlayerItem *)playItem
{
    if (!_playItem) {
        NSURL * url = [NSURL fileURLWithPath:self.filePathStr];
        _playItem = [AVPlayerItem playerItemWithURL:url];
        [_playItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _playItem;
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
