//
//  MHCameraBottomView.m
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/8.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "MHCameraBottomView.h"
#import "MHShareView.h"

#import "MHSettingController.h"
#import "MHLibraryController.h"
#import "MHLocationController.h"

@interface MHCameraBottomView ()
/// containerView
@property (nonatomic , readwrite , weak) MHView *containerView;
/// backgroundView
@property (nonatomic , readwrite , weak) UIImageView *backgroundView;
/// 拍照按钮
@property (nonatomic , readwrite , weak) UIButton *takePhotoBtn;
/// 定位按钮
@property (nonatomic , readwrite , weak) UIButton *gpsBtn;
/// albumBtn
@property (nonatomic , readwrite , weak) UIButton *albumBtn;

/// 完成按钮
@property (nonatomic , readwrite , weak) UIButton *doneBtn;
/// 取消按钮
@property (nonatomic , readwrite , weak) UIButton *cancelBtn;
/// 关闭按钮
@property (nonatomic , readwrite , weak) UIButton *closeBtn;
/// 分享按钮
@property (nonatomic , readwrite , weak) UIButton *shareBtn;
/// 设置按钮
@property (nonatomic , readwrite , weak) UIButton *settingBtn;
/// 水印库按钮
@property (nonatomic , readwrite , weak) UIButton *libBtn;
/// 显示模式
@property (nonatomic , readwrite , assign) MHCameraShowMode showModel;

@end

@implementation MHCameraBottomView

/// init
+ (instancetype)bottomView{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 初始化
        [self _setup];
        
        // 创建自控制器
        [self _setupSubViews];
        
        /// 事件处理
        [self _dealwithAction];
        
        // 布局子控件
        [self _makeSubViewsConstraints];
    }
    return self;
}




#pragma mark - 事件处理Or辅助方法
/// 事件处理
- (void)_dealwithAction{
    
    /// 拍照按钮事件
    [self.takePhotoBtn addTarget:self action:@selector(_takePhotoBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    /// 完成按钮事件
    [self.doneBtn addTarget:self action:@selector(_doneBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    /// 取消按钮事件
    [self.cancelBtn addTarget:self action:@selector(_cancelBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    /// 相册按钮事件
    [self.albumBtn addTarget:self action:@selector(_albumBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    /// 设置按钮事件
    [self.settingBtn addTarget:self action:@selector(_settingBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    /// 水印库事件
    [self.libBtn addTarget:self action:@selector(_libBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    /// 取消按钮事件
    [self.closeBtn addTarget:self action:@selector(_closeBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    /// 分享按钮事件
    [self.shareBtn addTarget:self action:@selector(_shareBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    /// 导航按钮事件
    [self.gpsBtn addTarget:self action:@selector(_gpsBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

/// 拍照按钮事件
- (void)_takePhotoBtnDidClicked:(UIButton *)sender{
    self.showModel = MHCameraShowModeCapturePhoto;
}

/// 完成按钮事件
- (void)_doneBtnDidClicked:(UIButton *)sender{
    self.showModel = MHCameraShowModeDefault;
}

/// 取消按钮事件
- (void)_cancelBtnDidClicked:(UIButton *)sender{
    self.showModel = MHCameraShowModeWatermarkGather;
}

/// 相册按钮事件
- (void)_albumBtnDidClicked:(UIButton *)sender{
    ///
    
}

/// 设置按钮事件
- (void)_settingBtnDidClicked:(UIButton *)sender{
    MHSettingController *setting = [[MHSettingController alloc] initWithParams:nil];
    MHNavigationController *nav = [[MHNavigationController alloc] initWithRootViewController:setting];
    [self.viewController presentViewController:nav animated:YES completion:NULL];
}

/// 关闭按钮事件
- (void)_closeBtnDidClicked:(UIButton *)sender{
    self.showModel = MHCameraShowModeDefault;
}

/// 分享按钮事件
- (void)_shareBtnDidClicked:(UIButton *)sender{
    MHShareView *shareView = [[MHShareView alloc] initWithSelectedShareType:^(MHShareViewType type) {
        
    }];
    [shareView showInView:nil];
}

/// 导航按钮事件
- (void)_gpsBtnDidClicked:(UIButton *)sender{
    MHLocationController *location = [[MHLocationController alloc] initWithParams:nil];
    MHNavigationController *nav = [[MHNavigationController alloc] initWithRootViewController:location];
    [self.viewController presentViewController:nav animated:YES completion:NULL];
}

/// 水印库按钮事件
- (void)_libBtnDidClicked:(UIButton *)sender{
    MHLibraryController *lib = [[MHLibraryController alloc] init];
    MHNavigationController *nav = [[MHNavigationController alloc] initWithRootViewController:lib];
    [self.viewController presentViewController:nav animated:YES completion:NULL];
}

///

- (void)_setup{
    /// 默认样式
    _showModel = MHCameraShowModeDefault;
    
    /// 监听showMode
    @weakify(self);
    [[[[RACObserve(self, showModel) skip:1] distinctUntilChanged] deliverOnMainThread] subscribeNext:^(NSNumber *  _Nullable x) {
        @strongify(self);
        MHCameraShowMode showMode = [x integerValue];
        NSTimeInterval duration = .25f;
        /// 根据不同的模式去切换不同的UI
        switch (showMode) {
            case MHCameraShowModeCapturePhoto:
            {
                [UIView animateWithDuration:.25 animations:^{
                    self.albumBtn.alpha = .0f;
                    self.takePhotoBtn.alpha = .0f;
                    self.gpsBtn.alpha = 1.0f;
                    
                    self.cancelBtn.alpha = 1.0f;
                    self.doneBtn.alpha = 1.0f;
                    self.shareBtn.alpha = 1.0f;
                    
                    self.closeBtn.alpha = .0f;
                    self.settingBtn.alpha = .0f;
                    self.libBtn.alpha = .0f;
                }];
            }
                break;
            case MHCameraShowModeWatermarkGather:
            {
                [UIView animateWithDuration:.25 animations:^{
                    
                    self.albumBtn.alpha = .0f;
                    self.takePhotoBtn.alpha = .0f;
                    self.gpsBtn.alpha = .0f;
                    
                    self.cancelBtn.alpha = .0f;
                    self.doneBtn.alpha = .0f;
                    self.shareBtn.alpha = .0f;
                    
                    self.closeBtn.alpha = 1.0f;
                    self.settingBtn.alpha = 1.0f;
                    self.libBtn.alpha = 1.0f;
                }];
            }
                break;
            default:
            {
                [UIView animateWithDuration:duration animations:^{
                    self.albumBtn.alpha = 1.0f;
                    self.takePhotoBtn.alpha = 1.0f;
                    self.gpsBtn.alpha = 1.0f;
                    
                    self.cancelBtn.alpha = .0f;
                    self.doneBtn.alpha = .0f;
                    self.shareBtn.alpha = .0f;
                    
                    self.closeBtn.alpha = .0f;
                    self.settingBtn.alpha = .0f;
                    self.libBtn.alpha = .0f;
                }];
            }
                break;
        }
        
        
        
        
        
    }];
    
}

/// 创建子视图
- (void)_setupSubViews{
    /// 背景View
    UIImageView *backgroundView = [[UIImageView alloc] init];
    self.backgroundView = backgroundView;
    backgroundView.image = MHImageNamed(@"camera_bg_iphone5");
    backgroundView.userInteractionEnabled = YES;
    [self addSubview:backgroundView];
    
    /// 内容
    MHView *containerView = [[MHView alloc] init];
    containerView.backgroundColor = [UIColor clearColor];
    self.containerView = containerView;
    [self addSubview:containerView];
    
    /// 拍照按钮
    UIButton *takePhotoBtn = [[UIButton alloc] init];
    [takePhotoBtn setBackgroundImage:MHImageNamed(@"camera_normal_iphone5") forState:UIControlStateNormal];
    [takePhotoBtn setBackgroundImage:MHImageNamed(@"camera_press_iphone5") forState:UIControlStateHighlighted];
    [takePhotoBtn setBackgroundImage:MHImageNamed(@"camera_disable_iphone5") forState:UIControlStateDisabled];
    self.takePhotoBtn = takePhotoBtn;
    [containerView addSubview:takePhotoBtn];
    
    
    /// 完成按钮
    UIButton *doneBtn = [[UIButton alloc] init];
    [doneBtn setBackgroundImage:MHImageNamed(@"done_normal_iphone5") forState:UIControlStateNormal];
    [doneBtn setBackgroundImage:MHImageNamed(@"done_press_iphone5") forState:UIControlStateHighlighted];
    [doneBtn setBackgroundImage:MHImageNamed(@"done_disable_iphone5") forState:UIControlStateDisabled];
    [doneBtn setTitle:@"保存" forState:UIControlStateNormal];
    doneBtn.titleLabel.font = MHMediumFont(MHConvertToFitPt(17.0f));
    self.doneBtn = doneBtn;
    [containerView addSubview:doneBtn];
    doneBtn.alpha = .0f;
    
    /// GPS
    UIButton *gpsBtn = [[UIButton alloc] init];
    [gpsBtn setBackgroundImage:MHImageNamed(@"GPS") forState:UIControlStateNormal];
    self.gpsBtn = gpsBtn;
    [containerView addSubview:gpsBtn];
    gpsBtn.showsTouchWhenHighlighted = YES;
    
    /// 相册
    UIButton *albumBtn = [[UIButton alloc] init];
    albumBtn.layer.cornerRadius = MHConvertToFitPt(4.0f);
    albumBtn.layer.masksToBounds = YES;
    albumBtn.backgroundColor = [UIColor redColor];
    albumBtn.showsTouchWhenHighlighted = YES;
    self.albumBtn = albumBtn;
    [containerView addSubview:albumBtn];
    
    /// 取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundImage:MHImageNamed(@"close") forState:UIControlStateNormal];
    cancelBtn.showsTouchWhenHighlighted = YES;
    self.cancelBtn = cancelBtn;
    [containerView addSubview:cancelBtn];
    cancelBtn.alpha = .0f;
    cancelBtn.showsTouchWhenHighlighted = YES;
    
    /// 关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setBackgroundImage:MHImageNamed(@"close") forState:UIControlStateNormal];
    closeBtn.showsTouchWhenHighlighted = YES;
    self.closeBtn = closeBtn;
    [containerView addSubview:closeBtn];
    closeBtn.alpha = .0f;
    closeBtn.showsTouchWhenHighlighted = YES;
    
    /// 分享按钮
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setBackgroundImage:MHImageNamed(@"btn_share") forState:UIControlStateNormal];
    shareBtn.showsTouchWhenHighlighted = YES;
    self.shareBtn = shareBtn;
    [containerView addSubview:shareBtn];
    shareBtn.alpha = .0f;
    shareBtn.showsTouchWhenHighlighted = YES;
    
    /// 设置按钮
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setBackgroundImage:MHImageNamed(@"setting") forState:UIControlStateNormal];
    settingBtn.showsTouchWhenHighlighted = YES;
    self.settingBtn = settingBtn;
    [containerView addSubview:settingBtn];
    settingBtn.alpha = .0f;
    settingBtn.showsTouchWhenHighlighted = YES;
    
    /// 水印库按钮
    UIButton *libBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [libBtn setBackgroundImage:[UIImage mh_resizableImage:@"watermark_library_normal"] forState:UIControlStateNormal];
    [libBtn setBackgroundImage:[UIImage mh_resizableImage:@"watermark_library_press"] forState:UIControlStateHighlighted];
    [libBtn setTitle:@"水印库" forState:UIControlStateNormal];
    [libBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    libBtn.titleLabel.font = MHRegularFont(MHConvertToFitPt(15));
    self.libBtn = libBtn;
    [containerView addSubview:libBtn];
    libBtn.alpha = .0f;
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
    CGFloat containerViewX = 0;
    CGFloat containerViewY = 0;
    CGFloat containerViewW = self.mh_width;
    CGFloat containerViewH = self.mh_height - MHBottomMargin(0);
    self.containerView.frame = CGRectMake(containerViewX, containerViewY, containerViewW, containerViewH);
    
    /// 布局照相机
    CGFloat takePhotoBtnW = MHConvertToFitPt(66);
    CGFloat takePhotoBtnH = MHConvertToFitPt(66);
    CGFloat takePhotoBtnX = (self.containerView.mh_width - takePhotoBtnW) * .5f;
    CGFloat takePhotoBtnY = (self.containerView.mh_height - takePhotoBtnH) * .5f;
    self.takePhotoBtn.frame = CGRectMake(takePhotoBtnX, takePhotoBtnY, takePhotoBtnW, takePhotoBtnH);
    /// 布局保存按钮
    self.doneBtn.frame = self.takePhotoBtn.frame;
    
    /// GPS Btn
    CGFloat gpsBtnW = MHConvertToFitPt(29);
    CGFloat gpsBtnH = MHConvertToFitPt(29);
    CGFloat gpsBtnX = CGRectGetMinX(self.takePhotoBtn.frame) - MHConvertToFitPt(30) - gpsBtnW ;
    CGFloat gpsBtnY = (self.containerView.mh_height - gpsBtnH) * .5f;
    self.gpsBtn.frame = CGRectMake(gpsBtnX, gpsBtnY, gpsBtnW, gpsBtnH);
    
    /// 间距
    CGFloat margin = MHConvertToFitPt(28);
    
    /// 相册按钮
    CGFloat albumBtnW = MHConvertToFitPt(32);
    CGFloat albumBtnH = MHConvertToFitPt(32);
    CGFloat albumBtnX = CGRectGetMinX(self.gpsBtn.frame) - margin - albumBtnW ;
    CGFloat albumBtnY = (self.containerView.mh_height - albumBtnH) * .5f;
    self.albumBtn.frame = CGRectMake(albumBtnX, albumBtnY, albumBtnW, albumBtnH);
    
    /// 取消按钮
    CGFloat cancelBtnX = CGRectGetMinX(self.gpsBtn.frame) - margin - gpsBtnW;
    self.cancelBtn.frame = CGRectMake(cancelBtnX, gpsBtnY, gpsBtnW, gpsBtnH);
    /// 设置按钮
    self.settingBtn.frame = self.cancelBtn.frame;
    
    /// 分享按钮
    CGFloat shareBtnX = CGRectGetMaxX(self.takePhotoBtn.frame) + MHConvertToFitPt(30);
    self.shareBtn.frame = CGRectMake(shareBtnX, gpsBtnY, gpsBtnW, gpsBtnH);
    
    /// 关闭按钮
    CGFloat closeBtnX = CGRectGetMaxX(self.shareBtn.frame) + margin;
    self.closeBtn.frame = CGRectMake(closeBtnX, gpsBtnY, gpsBtnW, gpsBtnH);
    
    
    /// 布局水印库按钮
    CGFloat libBtnW = MHConvertToFitPt(76);
    CGFloat libBtnH = MHConvertToFitPt(29);
    CGFloat libBtnX = (self.containerView.mh_width - libBtnW) *.5f;
    CGFloat libBtnY = (self.containerView.mh_height - libBtnH) * .5f;
    self.libBtn.frame = CGRectMake(libBtnX, libBtnY, libBtnW, libBtnH);
}

@end
