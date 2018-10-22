//
//  MHWatermarkDownloadController.m
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/19.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "MHWatermarkDownloadController.h"
#import "MHWatermarkDownloadCell.h"
@interface MHWatermarkDownloadController ()

@end

@implementation MHWatermarkDownloadController

- (void)viewDidLoad {
    [super viewDidLoad];
    /// 设置
    [self _setup];
    
    /// 设置导航栏
    [self _setupNavigationItem];
    
    /// 设置子控件
    [self _setupSubViews];
    
    /// 布局子空间
    [self _makeSubViewsConstraints];
    
    /// 注册一个Cell
    [self.collectionView registerClass:MHWatermarkDownloadCell.class forCellWithReuseIdentifier:@"MHWatermarkDownloadCell"];
}

#pragma mark - 事件处理Or辅助方法

#pragma mark - Override
- (void)configure{
    [super configure];
    
    [self.dataSource addObject:@1];
    [self.dataSource addObject:@1];
    [self.dataSource addObject:@1];
    [self.dataSource addObject:@1];
    [self.dataSource addObject:@1];
    [self.dataSource addObject:@1];
    [self.dataSource addObject:@1];
    [self.dataSource addObject:@1];
    
}

- (UIEdgeInsets)contentInset{
    return UIEdgeInsetsZero;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    /// 布局子控件的frame
    self.collectionView.frame = self.view.bounds;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"MHWatermarkDownloadCell" forIndexPath:indexPath];
}

- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    /// Item 尺寸 每行2个Item
    CGFloat num = 2.0f;
    CGFloat W = floor((MH_SCREEN_WIDTH - (num - 1) * MHConvertToFitPt(11) - MHConvertToFitPt(15) * 2)/num);
    CGFloat H = floor((93.0f * W)/70.0f);
    return CGSizeMake(W, H);
}
/// 每段的内容显示区域
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(MHConvertToFitPt(11), MHConvertToFitPt(15), MHConvertToFitPt(11), MHConvertToFitPt(15));
}
/// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return MHConvertToFitPt(12);
}

/// 每行内部item的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return MHConvertToFitPt(11);
}


#pragma mark - 初始化
- (void)_setup{
}

#pragma mark - 设置导航栏
- (void)_setupNavigationItem{
    
}

#pragma mark - 设置子控件
- (void)_setupSubViews{
    
}

#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints{
    
}

#pragma mark - Setter & Getter


@end
