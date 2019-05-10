//
//  SHomeController.m
//  SVideo
//
//  Created by liluyang on 2017/11/25.
//  Copyright © 2017年 SVideo. All rights reserved.
//

#import "SHomeController.h"
#import "SHomeCell.h"
#import "SHomeModel.h"
#import "WMPlayer.h"
#import "SCustomLayout.h"
#define kAngleMuti  180
@interface SHomeController ()<UICollectionViewDelegate, UICollectionViewDataSource, SHomeDelegate, WMPlayerDelegate,WMPlayerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *baseCollectionView;
@property (nonatomic, strong) NSMutableArray *videosArray;
@property (assign,nonatomic)CGFloat angle;
@property (assign,nonatomic)CGPoint originalCenter;
/**
 视频播放类
 */

@property (nonatomic, strong) WMPlayer *videoPlayer;
@end

@implementation SHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData:1];
    [self setupView];
    
}

-(void)setupView
{
    self.view.backgroundColor = K_RandColor;
    
    self.navigationController.navigationBarHidden = YES;
//    self.baseCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.baseCollectionView];
//上拉下拉 刷新加载
//    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerReload)];
//    self.baseCollectionView.mj_footer = refreshFooter;
//    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerReload)];
//    self.baseCollectionView.mj_header = refreshHeader;
//    [self.baseCollectionView.mj_header beginRefreshing];
}

#pragma mark - SHomeDelegate

-(void)tapClickView:(SHomeCell *)cell
{
    NSLog(@"点击播放或者暂停");
//
}

-(void)doubleTapClickView:(SHomeCell *)cell
{
    NSLog(@"双击点赞");
}

#pragma loadData
-(void)footerReload
{
    [self loadData:1];
}
-(void)headerReload
{
    [self loadData:0];
    
}

-(void)loadData:(NSInteger)type
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"loadData");
        [self.baseCollectionView.mj_header endRefreshing];
        [self.baseCollectionView.mj_footer endRefreshing];
    });
    
    NSString *videoUrl = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    NSString *userHeader = @"https://img.qq1234.org/uploads/allimg/140818/3_140818171934_4.jpg";
    NSString *testImage = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1557479435009&di=3874267457dbb3fed40958334ac90185&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F17bd4b72f4d43662b65b94eb0d61b6ac7bb7d9d323ba2-XMM11S_fw658";
    for (int i = 0; i <= 100; i++) {

        SHomeModel *model = [[SHomeModel alloc] init];
        model.videoUrl = videoUrl;
        model.isPlay = false;
        model.userHeader = userHeader;
        model.testImageStr = testImage;
        model.videoIntroduce = [NSString stringWithFormat:@"%d ++++++++%d",arc4random() ,i];
        [self.videosArray addObject:model];
    }
    [self.baseCollectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.videosArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"customCollectionCellId" forIndexPath:indexPath];
    cell.videoModel = self.videosArray[indexPath.row];
    cell.delegate = self;
    self.originalCenter = cell.center;
    [cell addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)]];
    
//    NSLog(@"%ld",indexPath.item);
    
    
    
    
    
    return cell;
}

//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"%s",__func__);
//}
//
//-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"%s",__func__);
//}

//-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%s",__func__);
//
//
//
//}





-(void)pan:(UIPanGestureRecognizer *)pan{
//    NSLog(@"%s",__func__);
    
    SHomeCell *cell = (SHomeCell*)pan.view;
    
    NSIndexPath *indexpath = [self.baseCollectionView indexPathForCell:cell];
//    NSLog(@"%ld",indexpath.row);
    if (indexpath.row >0) {
//       只能拖拽第一张图片
        return;
    }
    if (pan.state == UIGestureRecognizerStateChanged) {

        CGPoint movePoint = [pan translationInView:self.baseCollectionView];
        cell.center = CGPointMake(cell.center.x + movePoint.x, cell.center.y + movePoint.y);
        _angle = (cell.center.x - cell.frame.size.width * 0.5) / cell.frame.size.width * 0.5;
        cell.transform = CGAffineTransformMakeRotation(_angle);
        [pan setTranslation:CGPointZero inView:self.baseCollectionView];
        
        
    }else if (pan.state == UIGestureRecognizerStateEnded){

        if (ABS(_angle * kAngleMuti) >= 30) {
            [self.videosArray removeObjectAtIndex:indexpath.item];
            [self.baseCollectionView deleteItemsAtIndexPaths:@[indexpath]];
        }
        else{
            [UIView animateWithDuration:0.5 animations:^{
                cell.center = self.originalCenter;
                cell.transform = CGAffineTransformMakeRotation(0);
            }];
        }
        
    }
    
    
    
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


- (void)selectItemAtIndexPath:(nullable NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition
{
    LYLog(@"选中%ld",indexPath.row);
}


-(UICollectionView *)baseCollectionView{
    if (!_baseCollectionView) {

        SCustomLayout *flowLayout = [[SCustomLayout alloc] init];
//        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _baseCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, K_ScreenWidth, k_ScreenHeight) collectionViewLayout:flowLayout];
        _baseCollectionView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
        _baseCollectionView.delegate = self;
        _baseCollectionView.dataSource = self;
        [_baseCollectionView registerClass:[SHomeCell class] forCellWithReuseIdentifier:@"customCollectionCellId"];
    }
    return _baseCollectionView;
}

-(WMPlayer *)videoPlayer
{
    if (!_videoPlayer) {
        _videoPlayer = [[WMPlayer alloc] initWithFrame:CGRectMake(0, 0, K_ScreenWidth, k_ScreenHeight)];
        _videoPlayer.delegate = self;
        _videoPlayer.titleLabel.hidden = YES;
        _videoPlayer.fullScreenBtn.hidden = YES;
        _videoPlayer.playOrPauseBtn.hidden = YES;
        _videoPlayer.closeBtn.hidden = YES;
        _videoPlayer.bottomView.hidden = YES;
        
    }
    return _videoPlayer;
}


-(NSMutableArray *)videosArray
{
    if (!_videosArray) {
        _videosArray = [NSMutableArray array];
    }
    return _videosArray;
}

-(void)dealloc
{
    
}

@end
