//
//  SFilterArray.m
//  SVideo
//
//  Created by liluyang on 2018/5/4.
//  Copyright © 2018年 SVideo. All rights reserved.
//

#import "SFilterArray.h"

@implementation SFilterArray
+(NSArray *)creatFilterArray
{
//    创建滤镜数组
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    
    GPUImageOutput<GPUImageInput> * filter6 = [[GPUImageColorInvertFilter alloc] init];
    NSString *title6 = @"反色";
    NSDictionary *dic6 = [NSDictionary dictionaryWithObjectsAndKeys:filter6,@"filter", title6, @"name", nil];
    [array addObject:dic6];
    
    
    GPUImageOutput<GPUImageInput> *filter7 = [[GPUImageSepiaFilter alloc] init];
    NSString *title7 = @"经典怀旧";
    NSDictionary *dic7 = [NSDictionary dictionaryWithObjectsAndKeys:filter7,@"filter", title7, @"name", nil];
    [array addObject:dic7];
    
    GPUImageOutput<GPUImageInput> *filter8 = [[GPUImageRGBFilter alloc] init];
    NSString *title8 = @"RGB变幻";
    [(GPUImageRGBFilter *)filter8 setRed:0.4];
    [(GPUImageRGBFilter *)filter8 setGreen:0.8];
    [(GPUImageRGBFilter *)filter8 setBlue:0.1];
    NSDictionary *dic8 = [NSDictionary dictionaryWithObjectsAndKeys:filter8,@"filter", title8, @"name", nil];
    [array addObject:dic8];
    
    GPUImageOutput<GPUImageInput> *filter9 = [[GPUImageMonochromeFilter alloc] init];
    [(GPUImageMonochromeFilter *)filter9 setColorRed:0.3 green:0.5 blue:0.1];
    NSString *title9 = @"单色";
    NSDictionary *dic9 = [NSDictionary dictionaryWithObjectsAndKeys:filter9,@"filter", title9, @"name", nil];
    [array addObject:dic9];
    
    GPUImageOutput<GPUImageInput> * Filter15 = [[GPUImageSketchFilter alloc] init];
    //    [(GPUImageSobelEdgeDetectionFilter *)Filter13 ];
    NSString * title15 = @"素描";
    NSDictionary * dic15 = [NSDictionary dictionaryWithObjectsAndKeys:Filter15,@"filter",title15,@"name", nil];
    [array addObject:dic15];
    
    GPUImageOutput<GPUImageInput> * Filter16 = [[GPUImageSmoothToonFilter alloc] init];
    //    [(GPUImageSobelEdgeDetectionFilter *)Filter13 ];
    NSString * title16 = @"卡通";
    NSDictionary * dic16 = [NSDictionary dictionaryWithObjectsAndKeys:Filter16,@"filter",title16,@"name", nil];
    [array addObject:dic16];
    
    
    GPUImageOutput<GPUImageInput> * Filter17 = [[GPUImageColorPackingFilter alloc] init];
    //    [(GPUImageSobelEdgeDetectionFilter *)Filter13 ];
    NSString * title17 = @"监控";
    NSDictionary * dic17 = [NSDictionary dictionaryWithObjectsAndKeys:Filter17,@"filter",title17,@"name", nil];
    [array addObject:dic17];
    
    
    //    GPUImageOutput<GPUImageInput> * Filter18 = [[GPUImageVignetteFilter alloc] init];
    //    //    [(GPUImageSobelEdgeDetectionFilter *)Filter13 ];
    //    NSString * title18 = @"晕影";
    //    NSDictionary * dic18 = [NSDictionary dictionaryWithObjectsAndKeys:Filter18,@"filter",title18,@"name", nil];
    //    [arr addObject:dic18];
    
    
    GPUImageOutput<GPUImageInput> * Filter19 = [[GPUImageSwirlFilter alloc] init];
    [(GPUImageSwirlFilter *)Filter19 setRadius:1.0];
    [(GPUImageSwirlFilter*)Filter19 setAngle:0.3];
    NSString * title19 = @"漩涡";
    NSDictionary * dic19 = [NSDictionary dictionaryWithObjectsAndKeys:Filter19,@"filter",title19,@"name", nil];
    [array addObject:dic19];
    
    GPUImageOutput<GPUImageInput> * Filter20 = [[GPUImageBulgeDistortionFilter alloc] init];
    [(GPUImageBulgeDistortionFilter *)Filter20 setRadius:0.5];//0-1
    [(GPUImageBulgeDistortionFilter*)Filter20 setScale:0.5];//-1.0----1.0
    NSString * title20 = @"鱼眼";
    NSDictionary * dic20 = [NSDictionary dictionaryWithObjectsAndKeys:Filter20,@"filter",title20,@"name", nil];
    [array addObject:dic20];
    
    
    GPUImageOutput<GPUImageInput> * Filter21 = [[GPUImagePinchDistortionFilter alloc] init];
    //    [(GPUImagePinchDistortionFilter *)Filter21 setRadius:0.5];
    //    [(GPUImagePinchDistortionFilter*)Filter21 setScale:0.5];
    NSString * title21 = @"凹面镜";
    NSDictionary * dic21 = [NSDictionary dictionaryWithObjectsAndKeys:Filter21,@"filter",title21,@"name", nil];
    [array addObject:dic21];
    
    
    GPUImageOutput<GPUImageInput> * Filter22 = [[GPUImageStretchDistortionFilter alloc] init];
    //    [(GPUImageStretchDistortionFilter *)Filter21 setRadius:0.5];
    //    [(GPUImageStretchDistortionFilter*)Filter21 setScale:0.5];
    NSString * title22 = @"凹面镜";
    NSDictionary * dic22 = [NSDictionary dictionaryWithObjectsAndKeys:Filter22,@"filter",title22,@"name", nil];
    [array addObject:dic22];
    
    
    GPUImageOutput<GPUImageInput> * Filter23 = [[GPUImageGlassSphereFilter alloc] init];
    NSString * title23 = @"水晶球";
    NSDictionary * dic23 = [NSDictionary dictionaryWithObjectsAndKeys:Filter23,@"filter",title23,@"name", nil];
    [array addObject:dic23];
    
    
    GPUImageOutput<GPUImageInput> * Filter24 = [[GPUImageSphereRefractionFilter alloc] init];
    NSString * title24 = @"水晶球反";
    NSDictionary * dic24 = [NSDictionary dictionaryWithObjectsAndKeys:Filter24,@"filter",title24,@"name", nil];
    [array addObject:dic24];
    
    
    GPUImageOutput<GPUImageInput> * Filter25 = [[GPUImageEmbossFilter alloc] init];
    NSString * title25 = @"浮雕";
    NSDictionary * dic25 = [NSDictionary dictionaryWithObjectsAndKeys:Filter25,@"filter",title25,@"name", nil];
    [array addObject:dic25];
    
    
    return array;
    
}
@end
