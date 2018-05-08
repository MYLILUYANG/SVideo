//
//  SFilterSelView.m
//  SVideo
//
//  Created by liluyang on 2018/5/4.
//  Copyright © 2018年 SVideo. All rights reserved.
//

#import "SFilterSelView.h"
#import "SFilterArray.h"
@interface SFilterSelView()<UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, strong) NSArray *filterArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation SFilterSelView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = K_RandColor;
        _filterArray = [SFilterArray creatFilterArray];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _filterArray.count;
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FilterChooseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.nameLabel.text = _filterArray[indexPath.row][@"name"];
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.callBack) {
        _callBack(indexPath.row, (GPUImageOutput<GPUImageInput>*)_filterArray[indexPath.row][@"filter"]);
    }
    FilterChooseCell *cell = (FilterChooseCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.iconImage.backgroundColor = K_RandColor;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:CGSizeMake(k_Height(70), self.bounds.size.height)];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal]; //控制滑动分页用
        layout.minimumInteritemSpacing =0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[FilterChooseCell class] forCellWithReuseIdentifier:@"cellid"];
        _collectionView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _collectionView.autoresizesSubviews = YES;
        
    }
    return _collectionView;
}

-(void)select:(id)sender
{
    NSLog(@"%@",sender);
}


@end


@implementation FilterChooseCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, k_Height(5), k_Height(70), k_Width(70))];
        self.iconImage.backgroundColor = K_RandColor;
        self.iconImage.layer.cornerRadius = k_Height(35);
        self.iconImage.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_iconImage];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, k_Height(75), k_Height(70), k_Width(15))];
        _nameLabel.textColor = [UIColor orangeColor];
//        _nameLabel.backgroundColor = K_RandColor;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"123";
        _nameLabel.font = [UIFont systemFontOfSize:k_Height(14)];
        [self.contentView addSubview:_nameLabel];
        
    }
    return self;
}
@end







