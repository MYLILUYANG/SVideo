//
//  SCustomLayout.h
//  SVideo
//
//  Created by liluyang on 2019/5/9.
//  Copyright © 2019年 SVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCustomLayout : UICollectionViewLayout

@property (nonatomic, copy) void (^myblock)(NSInteger index);

@end
