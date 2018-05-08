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

@end

@implementation SShootingController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = K_RandColor;
    self.navigationController.navigationBarHidden = YES;
    
    _filterView = [[GPUImageView alloc] init];
    _filterView.frame = self.view.bounds;
    [self.view addSubview:_filterView];
    
    _camera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionBack];
    
    _camera.outputImageOrientation = UIInterfaceOrientationPortrait;
    _camera.horizontallyMirrorRearFacingCamera = false;
    _camera.horizontallyMirrorFrontFacingCamera = false;
    
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
    
    UIButton * back = [UIButton buttonWithType:0];
    back.backgroundColor = [UIColor redColor];
    back.frame = CGRectMake(k_Height(15), k_Height(20), k_Height(40), k_Height(40));
    [back addTarget:self action:@selector(back_toHome) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
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
        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"是否保存到相册" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存", nil];
        [alertview show];
    }else{
        NSString *fileName = [@"Documents/" stringByAppendingFormat:@"Movie%d.m4v",(int)[[NSDate date] timeIntervalSince1970]];
        
        
        pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
        NSLog(@"pathToMovie = %@",pathToMovie);
        
        NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
        self.writer = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(480.0, 640.0)];
        [self.filter addTarget:self.writer];
        self.camera.audioEncodingTarget = self.writer;
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
