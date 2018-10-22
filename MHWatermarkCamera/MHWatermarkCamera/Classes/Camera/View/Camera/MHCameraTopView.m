//
//  MHCameraTopView.m
//  MHWatermarkCamera
//
//  Created by lx on 2018/9/21.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "MHCameraTopView.h"

@interface MHCameraTopView ()
/// containerView
@property (nonatomic , readwrite , weak) MHView *containerView;
/// backgroundView
@property (nonatomic , readwrite , weak) UIImageView *backgroundView;
/// 闪光灯按钮
@property (nonatomic , readwrite , weak) UIButton *flashBtn;
/// 照相机前置转换按钮
@property (nonatomic , readwrite , weak) UIButton *swapBtn;

@end

@implementation MHCameraTopView

/// init
+ (instancetype)topView{
    return [[self alloc] init];
}

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

#pragma mark - Private Method
- (void)_setup{
    
}

#pragma mark - 创建自控制器
- (void)_setupSubViews
{
    /// 背景View
    UIImageView *backgroundView = [[UIImageView alloc] init];
    self.backgroundView = backgroundView;
    backgroundView.image = MHImageNamed(@"camera_top_toolbar_bg_iphone5");
    backgroundView.userInteractionEnabled = YES;
    [self addSubview:backgroundView];
    
    /// 内容
    MHView *containerView = [[MHView alloc] init];
    containerView.backgroundColor = [UIColor clearColor];
    self.containerView = containerView;
    [self addSubview:containerView];
    
    /// 闪光灯按钮
    UIButton *flashBtn = [[UIButton alloc] init];
    [flashBtn setBackgroundImage:MHImageNamed(@"flash_auto_iphone5") forState:UIControlStateNormal];
    [flashBtn setBackgroundImage:MHImageNamed(@"flash_disable_iphone5") forState:UIControlStateDisabled];
    flashBtn.showsTouchWhenHighlighted = YES;
    self.flashBtn = flashBtn;
    [containerView addSubview:flashBtn];
    
    /// 照相机前置转换按钮
    UIButton *swapBtn = [[UIButton alloc] init];
    [swapBtn setBackgroundImage:MHImageNamed(@"camera_transfer_iphone5") forState:UIControlStateNormal];
    [swapBtn setBackgroundImage:MHImageNamed(@"camera_transfer_disable_iphone5") forState:UIControlStateDisabled];
    swapBtn.showsTouchWhenHighlighted = YES;
    self.swapBtn = swapBtn;
    [containerView addSubview:swapBtn];
}

#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints{
    /// 布局
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

#pragma mark - 布局
- (void)layoutSubviews{
    [super layoutSubviews];
    
    /// 布局容器
    CGFloat containerViewX = MHTopMargin(0);
    CGFloat containerViewY = 0;
    CGFloat containerViewW = self.mh_width;
    CGFloat containerViewH = self.mh_height - MHTopMargin(0);
    self.containerView.frame = CGRectMake(containerViewX, containerViewY, containerViewW, containerViewH);
    
    /// 布局闪光灯按钮
    CGFloat flashBtnW = MHConvertToFitPt(30);
    CGFloat flashBtnH = MHConvertToFitPt(30);
    CGFloat flashBtnX = MHConvertToFitPt(7);
    CGFloat flashBtnY = (self.containerView.mh_height - flashBtnH) * .5f;
    self.flashBtn.frame = CGRectMake(flashBtnX, flashBtnY, flashBtnW, flashBtnH);
    
    /// 布局前置按钮
    CGFloat swapBtnW = MHConvertToFitPt(30);
    CGFloat swapBtnH = MHConvertToFitPt(30);
    CGFloat swapBtnX = self.containerView.mh_width - MHConvertToFitPt(7) - swapBtnW;
    CGFloat swapBtnY = (self.containerView.mh_height - swapBtnH) * .5f;;
    self.swapBtn.frame = CGRectMake(swapBtnX, swapBtnY, swapBtnW, swapBtnH);
}

@end
