//
//  SPublishController.m
//  SVideo
//
//  Created by liluyang on 2017/12/5.
//  Copyright © 2017年 SVideo. All rights reserved.
//

#import "SPublishController.h"
#import "SEditVideoViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface SPublishController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>



@property (nonatomic, strong) UIImagePickerController *pickController;

@end

@implementation SPublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    //相机权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
        authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
    {
        // 无权限 引导去开启
//        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//        if ([[UIApplication sharedApplication]canOpenURL:url]) {
//            [[UIApplication sharedApplication]openURL:url];
//        }
    }
    
    //相册权限
//    AVAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
//    if (author ==AVAuthorizationStatusRestricted || author ==AVAuthorizationStatusDenied){
//        //无权限 引导去开启
////        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
////        if ([[UIApplication sharedApplication] canOpenURL:url]) {
////            [[UIApplication sharedApplication] openURL:url];
////        }
//    }
    [self setpuUI];
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
{
    NSLog(@"照片拍完了");
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    NSURL * url = [info objectForKey:UIImagePickerControllerMediaURL];
    NSString * urlStr = [url path];
//    NSLog(@"%@",urlStr);
//    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
//        //保存视频到相簿，注意也可以使用ALAssetsLibrary来保存
//        UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
//    }
    [picker dismissViewControllerAnimated:YES completion:^{
        SEditVideoViewController *controller = [[SEditVideoViewController alloc] init];
        controller.filePathStr = urlStr;
        [self.navigationController pushViewController:controller animated:YES];
    }];
    

}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    } else {
        NSLog(@"视频保存成功");
        //录制完后自动播放
        SEditVideoViewController *controller = [[SEditVideoViewController alloc] init];
        controller.filePathStr = videoPath;
        [self.navigationController pushViewController:controller animated:YES];
        
        

    }
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancel");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)setpuUI
{
    
    
    UIButton *selBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, k_Height(100), K_ScreenWidth, k_Height(40))];
    
    [selBtn addTarget:self action:@selector(selBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [selBtn setTitle:@"从相册选择" forState:UIControlStateNormal];
    
    [self.view addSubview:selBtn];
    
    
    UIButton *photoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, k_Height(300), K_ScreenWidth, k_Height(40))];
    
    [photoBtn addTarget:self action:@selector(photoBtnBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [photoBtn setTitle:@"拍摄视频" forState:UIControlStateNormal];
    
    [self.view addSubview:photoBtn];
    
}


-(void)selBtnAction:(UIButton *)sender
{
    NSLog(@"%s",__func__);
    
}

-(void)photoBtnBtnAction:(UIButton *)sender
{

    [self presentViewController:self.pickController animated:YES completion:nil];
}

-(UIImagePickerController *)pickController
{
    if (!_pickController) {
        _pickController = [[UIImagePickerController alloc] init];
        _pickController.delegate = self;
        _pickController.sourceType = UIImagePickerControllerSourceTypeCamera;// 相册  相机
        _pickController.cameraDevice =  UIImagePickerControllerCameraDeviceRear;//默认是后置摄像头
//        视频类型
        _pickController.videoMaximumDuration = 10;
        _pickController.mediaTypes = @[(NSString *)kUTTypeMovie];
        _pickController.allowsEditing = YES;
        _pickController.videoQuality = UIImagePickerControllerQualityTypeIFrame1280x720;
        _pickController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        
    }
    return _pickController;
}

#pragma mark - 视频相关

// capturesession    捕捉视频的会话
//-(AVCaptureSession *)recordSession
//{
//    if (!_recordSession) {
//        _recordSession = [[AVCaptureSession alloc] init];
////        添加后置摄像头输入
//        if ([_recordSession canAddInput:self.backCameraInput]) {
//            [_recordSession addInput:self.backCameraInput];
//        }
////         添加麦克风
//        if ([_recordSession canAddInput:self.audioMicInput]) {
//            [_recordSession addInput:self.audioMicInput];
//        }
////        添加视频输出
//
//
//
//
//    }
//    return _recordSession;
//}

//session 的输入源
//-(AVCaptureDeviceInput *)backCameraInput
//{
//    if (!_backCameraInput) {
//        NSError *error;
//        _backCameraInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCamera] error:&error];
//        if (error) {
//            NSLog(@"%@",error.localizedDescription);
//        }
//    }
//    return _backCameraInput;
//}
// 前置摄像头设备 和后置摄像头设备
//-(AVCaptureDevice *)backCamera
//{
//    return [self cameraWithPosition:AVCaptureDevicePositionBack];
//
//}
//
//-(AVCaptureDevice *)frontCamera
//{
//    return [self cameraWithPosition:AVCaptureDevicePositionFront];
//}
//
////添加麦克风输入源
//-(AVCaptureDeviceInput *)audioMicInput
//{
//    if (!_audioMicInput) {
//
//        NSError *error;
//
//        _audioMicInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self deviceAudio] error:&error];
//        if (error) {
//            NSLog(@"添加麦克风失败");
//        }
//    }
//    return _audioMicInput;
//}
//
////麦克风
//-(AVCaptureDevice *)deviceAudio
//{
//
//    return [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
//}
//
////返回前后摄像头
//-(AVCaptureDevice*)cameraWithPosition:(AVCaptureDevicePosition)position
//{
//#warning 方法被废弃 应该使用新方法
//    NSArray *array = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
//
//    for (AVCaptureDevice *device in array) {
//        if (device.position == position) {
//            return device;
//        }
//
//    }
//    return nil;
//
//}
////视频输出
//-(AVCaptureVideoDataOutput *)videoOutput{
//    if (!_videoOutput) {
//        _videoOutput = [[AVCaptureVideoDataOutput alloc] init];
////        [_videoOutput setSampleBufferDelegate:self queue:self.captureQueue];
//                [_videoOutput setSampleBufferDelegate:self queue:self.captureQueue];
//
//    }
//    return _videoOutput;
//}
//
////线程操作
//-(NSThread *)captureQueue
//{
//    if (!_captureQueue) {
//        _captureQueue = [[NSThread alloc] init];
//    }
//    return _captureQueue;
//}
//
//-(NSOperationQueue *)capQue
//{
//    if (!_capQue) {
//        _capQue = [NSOperationQueue mainQueue];
//    }
//    return _captureQueue;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//


@end
