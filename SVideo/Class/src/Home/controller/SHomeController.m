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
#import <TXVodPlayer.h>
#import <TXVodPlayConfig.h>
#import <TXVodPlayListener.h>
@interface SHomeController ()<UICollectionViewDelegate, UICollectionViewDataSource, SHomeDelegate, WMPlayerDelegate,WMPlayerDelegate, TXVodPlayListener>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *baseCollectionView;
@property (nonatomic, strong) NSMutableArray *videosArray;
@property (assign,nonatomic)CGFloat angle;
@property (assign,nonatomic)CGPoint originalCenter;
@property (nonatomic, assign) int  cou;
@property (nonatomic, strong) TXVodPlayer *vodPlayer;
@property (nonatomic, strong) TXVodPlayer *vodPlayer2;
//vodPlayer2

@end

@implementation SHomeController

-(void) onPlayEvent:(TXVodPlayer *)player event:(int)EvtID withParam:(NSDictionary*)param
{
    NSLog(@"%@",param);
}

/**
 * 网络状态通知
 *
 * @param player 点播对象
 * @param param 参见TXLiveSDKTypeDef.h
 * @see TXVodPlayer
 */
-(void) onNetStatus:(TXVodPlayer *)player withParam:(NSDictionary*)param
{
    NSLog(@"%@",param);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData:1];
    [self setupView];
    
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

-(TXVodPlayer *)vodPlayer2
{
    if (!_vodPlayer2) {
        _vodPlayer2 = [TXVodPlayer new];
        _vodPlayer2.vodDelegate = self;
        _vodPlayer2.loop = YES;
        [_vodPlayer2 setRenderMode:RENDER_MODE_FILL_SCREEN];
    }
    return _vodPlayer2;
}

-(void)setupView
{
    

//    self.view.backgroundColor = K_RandColor;
    
    self.navigationController.navigationBarHidden = YES;
//    self.baseCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.baseCollectionView];
//上拉下拉 刷新加载

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
    NSString *video2Url = @"http://tb-video.bdstatic.com/tieba-smallvideo-transcode/2148489_1c9d8082c70caa732fc0648a21be383c_1.mp4";
    NSString *testImage2 = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1557828807316&di=2cf188be8ca9e76176fb1a480b5db605&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Faaa81b417fcb146174ea24d5e541f917078068704cf9e-ia2S7b_fw658";
    for (int i = 0; i <= 100; i++) {
        
        SHomeModel *model = [[SHomeModel alloc] init];
        model.videoUrl = videoUrl;
        if (i % 2 == 1) {
            model.videoUrl = videoUrl;
            model.testImageStr = testImage;
        }else{
            model.videoUrl = video2Url;
            model.testImageStr = testImage2;
        }
//        NSLog(@"%@", model.videoUrl);
        model.isPlay = false;
        model.userHeader = userHeader;
        
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
    
    if (indexPath.item == 0) {
        [self.vodPlayer setupVideoWidget:cell.contentView insertIndex:0];
        SHomeModel *model = self.videosArray[0];
        [self.vodPlayer startPlay:model.videoUrl];
    }
    return cell;
}


-(void)pan:(UIPanGestureRecognizer *)pan{
    SHomeCell *cell = (SHomeCell*)pan.view;
    
    NSIndexPath *indexpath = [self.baseCollectionView indexPathForCell:cell];
    
    SHomeCell *cell1 = (SHomeCell*)[self.baseCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];
    
    if (indexpath.row >0) {
        
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
            [self.vodPlayer stopPlay];
            [self.vodPlayer removeVideoWidget];
            
            
            [self.videosArray removeObjectAtIndex:indexpath.item];
            [self.baseCollectionView deleteItemsAtIndexPaths:@[indexpath]];
            NSLog(@"%@",cell1);
            [self.vodPlayer setupVideoWidget:cell1.contentView insertIndex:0];
            SHomeModel *model = self.videosArray[0];
            SHomeModel *model1 = self.videosArray[1];
            [self.vodPlayer startPlay:model.videoUrl];
            self.vodPlayer.config.cacheFolderPath = model1.videoUrl;
//            self.vodPlayer.cacheFolderPath = model1.videoUrl;
            
        }else if (_angle * kAngleMuti <= -30){
            
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

- (void)selectItemAtIndexPath:(nullable NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition
{
    LYLog(@"选中%ld",indexPath.row);
}


-(UICollectionView *)baseCollectionView{
    if (!_baseCollectionView) {

        SCustomLayout *flowLayout = [[SCustomLayout alloc] init];
        _baseCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, K_ScreenWidth, k_ScreenHeight) collectionViewLayout:flowLayout];
        _baseCollectionView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
        _baseCollectionView.delegate = self;
        _baseCollectionView.dataSource = self;
        [_baseCollectionView registerClass:[SHomeCell class] forCellWithReuseIdentifier:@"customCollectionCellId"];
    }
    return _baseCollectionView;
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
