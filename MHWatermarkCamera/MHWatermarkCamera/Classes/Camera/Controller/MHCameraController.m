//
//  MHCameraController.m
//  MHWatermarkCamera
//
//  Created by lx on 2018/9/21.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "MHCameraController.h"
#import "MHCameraTopView.h"
#import "MHCameraBottomView.h"
#import "MHWatermarkView.h"
@interface MHCameraController ()
/// topView
@property (nonatomic , readwrite , weak) MHCameraTopView *cameraTopView;
/// bottomView
@property (nonatomic , readwrite , weak) MHCameraBottomView *cameraBottomView;
/// watermarkView
@property (nonatomic , readwrite , weak) MHWatermarkView *watermarkView;
@end

@implementation MHCameraController

- (instancetype)initWithParams:(NSDictionary *)params{
    if (self = [super initWithParams:params]) {
        /// 隐藏系统的导航栏
        self.prefersNavigationBarHidden = YES;
    }
    return self;
}

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
}

#pragma mark - 事件处理Or辅助方法


#pragma mark - Override
- (BOOL)prefersStatusBarHidden{ return YES; }

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    MHLogFunc;
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

#pragma mark - 初始化
- (void)_setup{
    
    ///
    
    
}

#pragma mark - 设置导航栏
- (void)_setupNavigationItem{
    
}

#pragma mark - 设置子控件
- (void)_setupSubViews{
    /// 顶部View
    MHCameraTopView * cameraTopView = [MHCameraTopView topView];
    self.cameraTopView = cameraTopView;
    [self.view addSubview:cameraTopView];
    
    /// 底部View
    MHCameraBottomView * cameraBottomView = [MHCameraBottomView bottomView];
    self.cameraBottomView = cameraBottomView;
    [self.view addSubview:cameraBottomView];
    
    /// 单个水印集合View
    MHWatermarkView *watermarkView = [[MHWatermarkView alloc] init];
    self.watermarkView = watermarkView;
    [self.view addSubview:watermarkView];
}

#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints{
    
    CGFloat cameraTopViewH = MHTopMargin(MHConvertToFitPt(44));
    CGFloat cameraBottomViewH = MHBottomMargin(MHConvertToFitPt(98));
    
    [self.cameraTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.and.right.equalTo(self.view);
        make.height.mas_equalTo(cameraTopViewH);
    }];
    
    [self.cameraBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.and.right.equalTo(self.view);
        make.height.mas_equalTo(cameraBottomViewH);
    }];
    
    /// 布局水印层
    CGFloat watermarkViewX = 0;
    CGFloat watermarkViewY = cameraTopViewH;
    CGFloat watermarkViewW = MH_SCREEN_WIDTH;
    CGFloat watermarkViewH = MH_SCREEN_HEIGHT - cameraTopViewH - cameraBottomViewH;
    self.watermarkView.frame = CGRectMake(watermarkViewX, watermarkViewY, watermarkViewW, watermarkViewH);
}

#pragma mark - Setter & Getter



@end
