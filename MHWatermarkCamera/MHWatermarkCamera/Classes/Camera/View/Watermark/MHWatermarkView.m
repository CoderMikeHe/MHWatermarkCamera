//
//  MHWatermarkView.m
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/9.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//  

#import "MHWatermarkView.h"
#import "MHWatermarkCell.h"
#import "MHCameraZoomSlider.h"

@interface MHWatermarkView ()<UICollectionViewDelegateFlowLayout , UICollectionViewDataSource,UIGestureRecognizerDelegate>

/// collectionView
@property (nonatomic , readwrite , weak) UICollectionView *collectionView;
/// flowLayout
@property (nonatomic , readwrite , strong) UICollectionViewFlowLayout *flowLayout;
/// pageControl
@property (nonatomic , readwrite , weak) UIPageControl *pageControl;
/// photoView
@property (nonatomic , readwrite , weak) UIImageView *photoView;
/// slider
@property (nonatomic , readwrite , weak) MHCameraZoomSlider *slider;
@end



@implementation MHWatermarkView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 初始化
        [self _setup];
        
        // 创建自控制器
        [self _setupSubViews];
        
        // 布局子控件
        [self _makeSubViewsConstraints];
    }
    return self;
}

#pragma mark - 事件处理Or辅助方法
/// 缩放系数改变
- (void)_sliderValueChanged:(UISlider *)sender{
}

/// 当前索引
- (NSInteger)_fetchCurrentIndex{
    /// 容错
    if (self.collectionView.mh_width == 0 || self.collectionView.mh_height == 0 || self.dataSource.count == 0) {
        return 0;
    }
    /// 获取ItemSize
    CGSize itemSize = [self collectionView:self.collectionView layout:self.flowLayout sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    /// 获取索引
    int index  = (self.collectionView.contentOffset.x + itemSize.width * 0.5) / itemSize.width;
    
    return  MIN(self.dataSource.count-1, index);
}

/// 显示PageControl
- (void)_showPageControl{
    if (self.pageControl.alpha >= 1.0f) { return; }
    [UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.pageControl.alpha = 1.0f;
    } completion:NULL];
}
/// 隐藏PageControl
- (void)_hidePageControl{
    if (self.pageControl.alpha <= .000001f) { return; }
    [UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.pageControl.alpha = 0.0f;
    } completion:NULL];
}

#pragma mark - Override
- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (newSuperview) {
        /// 2s后 hide pageControl
        [self performSelector:@selector(_hidePageControl) withObject:nil afterDelay:2.0f];
    }
}

#pragma mark - UICollectionViewDataSource&UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MHWatermarkCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MHWatermarkCell" forIndexPath:indexPath];
//    [cell configureModel:self.dataSource[indexPath.item]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}



#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.bounds.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (!self.dataSource.count) return;
    NSInteger currentIndex = [self _fetchCurrentIndex];
    
    /// 这里必须要做个判断容错
    if (currentIndex >= self.dataSource.count) {
        return;
    }
    self.pageControl.currentPage = currentIndex;
    
//    if (currentIndex != self.preIndex) {
//        UFPosterPaster *preP = self.dataSource[self.preIndex];
//        preP.selected = NO;
//
//        UFPosterPaster *p = self.dataSource[currentIndex];
//        p.selected = YES;
//    }
//    self.preIndex = currentIndex;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    if (!self.isCapturePhoto) {
//        [self _invalidateTimer];
//    }
//
    /// 取消掉hide的操作
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_hidePageControl) object:nil];
    /// 显示
    [self _showPageControl];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    if (!self.isCapturePhoto) {
//        [self _setupTimer];
//    }
    /// 2s后 hide pageControl
    [self performSelector:@selector(_hidePageControl) withObject:nil afterDelay:2.0f];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
//    if (!self.dataSource.count) return;
//
//    /// 拍照状态 则不需要闪烁
//    if (self.isCapturePhoto) {  return; }
//
//    /// 当前索引
//    NSInteger currentItem = [self _fetchCurrentIndex];
//
//    /// 相同索引则跳过
//    if (self.currentIndex == currentItem) { return; }
//
//    /// 获取Cell
//    UFPosterPasterOperateCell *cell = (UFPosterPasterOperateCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:currentItem inSection:0]];
//    /// 闪烁可编辑区域
//    [cell flashEditableArea];
//    /// 记录索引
//    self.currentIndex = currentItem;
}



#pragma mark - 初始化&创建子控件&布局子控件
/// 初始化
- (void)_setup{
    self.dataSource = @[@0 , @1 , @2 , @3 , @4 , @5];
}

/// 创建子控件
- (void)_setupSubViews{
    ///
    /// photoView 展示拍照图片
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.contentMode = UIViewContentModeScaleAspectFit;
    self.photoView = photoView;
    photoView.backgroundColor = [UIColor clearColor];
    photoView.hidden = YES;
    [self addSubview:photoView];
    
    /// UICollectionViewFlowLayout + UICollectionView
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout = flowLayout;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.pagingEnabled = YES;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    /// 设置显示区域
    collectionView.contentInset = UIEdgeInsetsZero;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView = collectionView;
    /// 注册cell
    [collectionView registerClass:MHWatermarkCell.class forCellWithReuseIdentifier:@"MHWatermarkCell"];
#ifdef __IPHONE_11_0
    /// CoderMikeHe: 适配 iPhone X + iOS 11，
    MHAdjustsScrollViewInsets_Never(collectionView);
#endif
    [self addSubview:collectionView];
    
    /// pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.pageIndicatorTintColor = [[UIColor whiteColor] colorWithAlphaComponent:.3f];
    pageControl.userInteractionEnabled = NO;
    pageControl.currentPage = 0;
    pageControl.numberOfPages = 6;
    pageControl.hidesForSinglePage = YES;
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
    /// slider
    /// 设置slider
    MHCameraZoomSlider *slider = [[MHCameraZoomSlider alloc] initWithFrame:CGRectMake(0, 0, MHConvertToFitPt(247), 36)];
    slider.transform = CGAffineTransformMakeRotation(-M_PI_2);
    slider.backgroundColor = [UIColor redColor];
    [slider addTarget:self action:@selector(_sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:slider];
    self.slider = slider;
//    slider.alpha = .0f;
}

/// 布局子控件
- (void)_makeSubViewsConstraints{
}

/// Frame布局
- (void)layoutSubviews{
    [super layoutSubviews];
    
    /// 布局照片
    CGFloat photoViewX = 0;
    CGFloat photoViewY = 0;
    CGFloat photoViewW = 0;
    CGFloat photoViewH = 0;
//    photoViewX = 0;
//    photoViewY = 0;
//    photoViewW = 0;
//    photoViewH = 0;
    
    self.photoView.frame = CGRectMake(photoViewX, photoViewY, photoViewW, photoViewH);
    
    /// 布局CollectionView
    CGFloat collectionViewX = 0;
    CGFloat collectionViewY = 0;
    CGFloat collectionViewW = 0;
    CGFloat collectionViewH = 0;
    
    
    collectionViewX = 0;
    collectionViewY = 0;
    collectionViewW = self.bounds.size.width;
    collectionViewH = self.bounds.size.height;
    self.collectionView.frame = CGRectMake(collectionViewX, collectionViewY, collectionViewW, collectionViewH);
    
    /// 布局pageControl
    CGFloat pageControlX = 0;
    CGFloat pageControlY = self.bounds.size.height - 30;
    CGFloat pageControlW = self.bounds.size.width;
    CGFloat pageControlH = 30;
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
    
    /// 布局slider
    /// 逆时针旋转
    CGFloat sliderW = MHConvertToFitPt(247);
    CGFloat sliderH = 36;
    CGFloat sliderX = self.bounds.size.width - sliderH - 4;;
    CGFloat sliderY =(self.bounds.size.height - sliderW) * .5f;;
//    self.slider.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
    self.slider.mh_x = sliderX;
    self.slider.mh_y = sliderY;
}
@end
