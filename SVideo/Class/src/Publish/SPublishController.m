//
//  SPublishController.m
//  SVideo
//
//  Created by liluyang on 2017/12/5.
//  Copyright © 2017年 SVideo. All rights reserved.
//

#import "SPublishController.h"

@interface SPublishController ()
@property (nonatomic, strong)  AVCaptureSession *recordSession;
@property (nonatomic, strong) AVCaptureDeviceInput *backCameraInput;
@property (nonatomic, strong) AVCaptureDeviceInput *audioMicInput;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoOutput;
@property (nonatomic, strong) NSThread *captureQueue;
@property (nonatomic, strong) NSOperationQueue *capQue;
@end

@implementation SPublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    button.titleLabel.text = @"paishe";
    [self.view addSubview:button];
}
-(void)btnAction:(UIButton *)sender
{
    NSLog(@"12");
    
    
}

#pragma mark - 视频相关

// capturesession    捕捉视频的会话
-(AVCaptureSession *)recordSession
{
    if (!_recordSession) {
        _recordSession = [[AVCaptureSession alloc] init];
//        添加后置摄像头输入
        if ([_recordSession canAddInput:self.backCameraInput]) {
            [_recordSession addInput:self.backCameraInput];
        }
//         添加麦克风
        if ([_recordSession canAddInput:self.audioMicInput]) {
            [_recordSession addInput:self.audioMicInput];
        }
//        添加视频输出
        
        
        
        
    }
    return _recordSession;
}

//session 的输入源
-(AVCaptureDeviceInput *)backCameraInput
{
    if (!_backCameraInput) {
        NSError *error;
        _backCameraInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCamera] error:&error];
        if (error) {
            NSLog(@"%@",error.localizedDescription);
        }
    }
    return _backCameraInput;
}
// 前置摄像头设备 和后置摄像头设备
-(AVCaptureDevice *)backCamera
{
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
    
}

-(AVCaptureDevice *)frontCamera
{
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

//添加麦克风输入源
-(AVCaptureDeviceInput *)audioMicInput
{
    if (!_audioMicInput) {
        
        NSError *error;
        
        _audioMicInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self deviceAudio] error:&error];
        if (error) {
            NSLog(@"添加麦克风失败");
        }
    }
    return _audioMicInput;
}

//麦克风
-(AVCaptureDevice *)deviceAudio
{
    
    return [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
}

//返回前后摄像头
-(AVCaptureDevice*)cameraWithPosition:(AVCaptureDevicePosition)position
{
#warning 方法被废弃 应该使用新方法
    NSArray *array = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    for (AVCaptureDevice *device in array) {
        if (device.position == position) {
            return device;
        }
        
    }
    return nil;
    
}
//视频输出
-(AVCaptureVideoDataOutput *)videoOutput{
    if (!_videoOutput) {
        _videoOutput = [[AVCaptureVideoDataOutput alloc] init];
//        [_videoOutput setSampleBufferDelegate:self queue:self.captureQueue];
                [_videoOutput setSampleBufferDelegate:self queue:self.captureQueue];

    }
    return _videoOutput;
}

//线程操作
-(NSThread *)captureQueue
{
    if (!_captureQueue) {
        _captureQueue = [[NSThread alloc] init];
    }
    return _captureQueue;
}

-(NSOperationQueue *)capQue
{
    if (!_capQue) {
        _capQue = [NSOperationQueue mainQueue];
    }
    return _captureQueue;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
