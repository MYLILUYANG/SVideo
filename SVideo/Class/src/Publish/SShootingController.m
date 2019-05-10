//
//  SShootingController.m
//  SVideo
//
//  Created by liluyang on 2018/5/4.
//  Copyright © 2018年 SVideo. All rights reserved.
//

#import "SShootingController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "SFilterSelView.h"
#import "GPUImageBeautifyFilter.h"
#define FilterViewHeight k_Height(95)
@interface SShootingController ()
{
    NSString *pathToMovie;
}
@property (nonatomic,retain) UISlider *progress;
@property (nonatomic,retain) UIButton *movieButton;

@property (nonatomic,retain) GPUImageVideoCamera *camera;
@property(nonatomic,strong) GPUImageView * filterView;
@property (nonatomic,retain) GPUImageMovieWriter *writer;
@property (nonatomic,retain) GPUImageOutput<GPUImageInput> *filter;
@property (nonatomic, strong) UIButton *beautifulBtn;
@end

@implementation SShootingController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = K_RandColor;
    self.navigationController.navigationBarHidden = YES;
    
    _filterView = [[GPUImageView alloc] init];
    _filterView.frame = self.view.bounds;
    [self.view addSubview:_filterView];
    
    _camera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionFront];
    
    _camera.outputImageOrientation = UIInterfaceOrientationPortrait;
    _camera.horizontallyMirrorRearFacingCamera = false;
    _camera.horizontallyMirrorFrontFacingCamera = YES;
    [_camera addAudioInputsAndOutputs];
//    self.videoCamera.horizontallyMirrorFrontFacingCamera = YES;
    if (self.filter) {
        [self.camera addTarget:self.filter];
        [self.filter addTarget:_filterView];
    }else
    {
        [self.camera addTarget:_filterView];
    }
    
    [self.camera startCameraCapture];
    
    
    SFilterSelView *filterView = [[SFilterSelView alloc] initWithFrame:CGRectMake(0, k_ScreenHeight - FilterViewHeight - k_Height(20), K_ScreenWidth, FilterViewHeight)];
    
    [filterView setCallBack:^(NSInteger index, GPUImageOutput<GPUImageInput> *filter) {
        
        NSLog(@"%ld", index);
        [self choose_callBack:filter];
        
    }];
    [self.view addSubview:filterView];
    
    [self setupUI];
    
}

-(void)setupUI{
    
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, k_Height(100), K_ScreenWidth, 10)];
    
    [self.view addSubview:progressView];

    self.movieButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.movieButton.layer.borderWidth  = 2;
    self.movieButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.movieButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.movieButton setTitle:@"start" forState:UIControlStateNormal];
    [self.movieButton setTitle:@"stop" forState:UIControlStateSelected];
    [self.movieButton addTarget:self action:@selector(start_stop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.movieButton];
    
    [self.movieButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.height.equalTo([NSNumber numberWithFloat:k_Height(40)]);
        make.bottomMargin.mas_equalTo([NSNumber numberWithFloat:k_Height(-125)]);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    _beautifulBtn = [[UIButton alloc] init];
    [_beautifulBtn setTitle:@"美颜" forState:UIControlStateNormal];
    [_beautifulBtn setTitle:@"关美颜" forState:UIControlStateSelected];
    _beautifulBtn.backgroundColor = [UIColor redColor];
    _beautifulBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_beautifulBtn addTarget:self action:@selector(beautifulAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_beautifulBtn];
    
    UIButton * back = [UIButton buttonWithType:0];
    back.backgroundColor = [UIColor redColor];
    back.frame = CGRectMake(k_Height(15), k_Height(20), k_Height(40), k_Height(40));
    [back addTarget:self action:@selector(back_toHome) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    [_beautifulBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo([NSNumber numberWithFloat:k_Height(20)]);
        make.right.equalTo([NSNumber numberWithFloat:-k_Height(80)]);
        make.width.equalTo([NSNumber numberWithFloat:k_Height(50)]);
        make.width.equalTo([NSNumber numberWithFloat:k_Height(40)]);
        
    }];
}

-(void)beautifulAction
{
    if (self.beautifulBtn.selected) {
        self.beautifulBtn.selected = NO;
        
        [self.camera removeAllTargets];
        [self.camera addTarget:self.filterView];
        
    }else
    {
        self.beautifulBtn.selected = YES;
        [self.camera removeAllTargets];
        GPUImageBeautifyFilter *filter = [[GPUImageBeautifyFilter alloc] init];
        [self.camera addTarget:filter];
        [filter addTarget:self.filterView];
    }
}

-(void)choose_callBack:(GPUImageOutput<GPUImageInput> *)filter
{
    BOOL isSelected = self.movieButton.isSelected;
    if (isSelected) {
        return;
    }
    self.filter = filter;
    [self.camera removeAllTargets];
    [self.camera addTarget:_filter];
    [_filter addTarget:_filterView];
}


-(void)start_stop
{
    NSLog(@"%s",__func__);
    BOOL isSelected = self.movieButton.isSelected;
    [self.movieButton setSelected:!isSelected];
    if (isSelected) {
        [self.filter removeTarget:self.writer];
        self.camera.audioEncodingTarget = nil;
        [self.writer finishRecording];
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否保存视频" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           
            
        }] ];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *fileName = [@"Documents/" stringByAppendingFormat:@"Movie%d.m4v",(int)[[NSDate date] timeIntervalSince1970]];
            pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
            NSLog(@"pathToMovie = %@",pathToMovie);
            NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
            self.writer = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(480.0, 640.0)];
            self.writer.encodingLiveVideo = YES;
            self.writer.shouldPassthroughAudio = YES;
            self.writer.hasAudioTrack = YES;
            [self.writer startRecording];
            [self.filter addTarget:self.writer];
            self.camera.audioEncodingTarget = self.writer;
            __weak typeof(self.writer)weakWrite = self.writer;
            [self.writer setCompletionBlock:^{
                NSLog(@"写入完成");
                [weakWrite finishRecording];
            }];
            
//            self.navigationController pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>
        }]];
        [self presentViewController:alert animated:YES completion:nil];

    }else{
      
        [self.writer startRecording];
        
    }
}

-(void)back_toHome
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
