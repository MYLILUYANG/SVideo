//
//  SCustomLayout.m
//  SVideo
//
//  Created by liluyang on 2019/5/9.
//  Copyright © 2019年 SVideo. All rights reserved.
//

#import "SCustomLayout.h"

@implementation SCustomLayout
//每次布局变化后都重新布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(CGSize)collectionViewContentSize
{
    return CGSizeMake(k_Width(300), k_Height(400));
}

//重写layoutAttributesForItemAtIndexPath 返回每个item的属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    NSLog(@"---------%ld",indexPath.item);
    
//    设置布局属性
    attributes.center = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5 - k_Height(50));
//    设置偏移量
    NSArray * offsets = @[@(0.0),@(15.0),@(30.0)];
    
    
    if (indexPath.item >=3 ) {
        attributes.hidden = YES;
    }else{
        
        attributes.transform = CGAffineTransformMakeTranslation(0, [offsets[indexPath.item] floatValue]);
        attributes.size = CGSizeMake(k_Height(300)- [offsets[indexPath.item] floatValue], k_Height(400));
//        zIndex越大 位置越在上边
        attributes.zIndex = [self.collectionView numberOfItemsInSection:indexPath.section] - indexPath.item;
//        NSLog(@"%ld",attributes.zIndex);
//        NSLog(@"______________________%ld",indexPath.item);
//
//        NSLog(@"%@", [self.collectionView cellForItemAtIndexPath:indexPath]);
        
//        self.myblock(indexPath.item);
    }
    return attributes;
//    NSArray
    
    
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array  = [NSMutableArray array];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < count; i++) {
        
        
        UICollectionViewLayoutAttributes *attr = [self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [array addObject:attr];
    }
    return array;
}

@end
