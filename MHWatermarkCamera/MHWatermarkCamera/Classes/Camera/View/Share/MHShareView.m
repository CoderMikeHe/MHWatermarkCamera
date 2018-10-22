//
//  MHShareView.m
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/10.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "MHShareView.h"
#import <pop/POP.h>
#import "MHShareTypeButton.h"

@interface MHShareView ()

/// 底部工具条
@property (nonatomic, readwrite, weak) UIView *contentView;
/// 完成回调
@property (nonatomic, copy) void (^completionCallBack)(MHShareViewType);
/// closeButton
@property (nonatomic, readwrite, weak) UIButton *closeButton;
/// menuButtons
@property (nonatomic, readwrite, strong) NSMutableArray *menuButtons;
/// selectedButton
@property (nonatomic, readwrite, weak) UIButton *selectedButton;
/// 显示类型
//@property (nonatomic , readwrite , assign) UFShareViewShowType showType;

/// titleLabel
@property (nonatomic , readwrite , weak) UILabel *titleLabel;
/// 取消按钮
@property (nonatomic, readwrite, weak) UIButton *cancelBtn;
/// 分割线
@property (nonatomic , readwrite , weak) UIView *lineView;


@end



@implementation MHShareView

- (void)dealloc{
    NSLog(@"__ %@ dealloc __", [self class]);
}

/// 构造函数
///
/// @param completed 完成回调
///
/// @return 撰写类型视图
- (instancetype)initWithSelectedShareType:(void (^)(MHShareViewType type))completed{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        // 初始化
        [self _setup];
        
        // 创建自控制器
        [self _setupSubViews];
        
        // 布局子控件
        [self _makeSubViewsConstraints];
        
        /// 添加手势
        // 添加手势识别
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_closeView)];
        [self addGestureRecognizer:tap];
        
        // 记录完成回调
        self.completionCallBack = completed;
    }
    
    return self;
}



/// 显示在指定视图中
- (void)showInView:(UIView *)view{
    
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [view addSubview:self];
    // 自动布局
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    // 显示按钮
    [self _showAnimation];
}



#pragma mark - 按钮动画方法
/// 动画显示撰写类型按钮
- (void)_showAnimation {
    /// 背景颜色动画
    [UIView animateWithDuration:.25 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    }];
    
    NSInteger index = 0;
    /// 显示label
    [self _springAnimation:self.titleLabel index:index offsetY:-1 *MHConvertToFitPt(300)];
    /// 索引加一
    index = index+1;
    /// 中间功能按钮
    NSInteger i = 0;
    /// 布局按钮
    CGFloat btnH = MHConvertToFitPt(75);
    /// 竖屏margin
    CGFloat pMargin = (MHConvertToFitPt(300) - MHConvertToFitPt(54) -MHConvertToFitPt(57) - 2*btnH)/2.0f;
    for (UIButton *btn in self.menuButtons) {
        CGFloat offsetY = MHConvertToFitPt(300) - MHConvertToFitPt(54) - (i/3)*(btnH+pMargin);
        [self _springAnimation:btn index:index offsetY:(-1 * offsetY)];
        index++;
        i++;
    }
    /// 取消按钮
    [self _springAnimation:self.cancelBtn index:index offsetY:-1 * MHConvertToFitPt(57)];
}

/// 动画隐藏撰写类型按钮
- (void)_hideAnimation {
    NSInteger index = 0;
    /// 显示label
    CGFloat offsetY = MHConvertToFitPt(300);
    [self _springAnimation:self.cancelBtn index:index offsetY:offsetY];
    index++;
    for (UIButton *btn in self.menuButtons.reverseObjectEnumerator) {
        [self _springAnimation:btn index:index offsetY:offsetY];
        index++;
    }
    [self _springAnimation:self.titleLabel index:index offsetY:offsetY];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.25 animations:^{
            self.contentView.alpha = .0;
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.0];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    });
}

/// 按钮动画
///
/// @param button  要动画的按钮
/// @param index   按钮索引，根据索引计算动画延时
/// @param offsetY 中心 Y 值偏移量
///
/// @return 弹力动画
- (POPSpringAnimation *)_springAnimation:(UIView *)view index:(NSInteger)index offsetY:(CGFloat)offsetY {
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationY];
    
    anim.toValue = @(offsetY);
    
    // 弹力系数，取值范围 0~20，数值越大，弹性越大，默认数值为4
    anim.springBounciness = 8;
    // 弹力速度，取值范围 0~20，数值越大，速度越快，默认数值为12
    anim.springSpeed = 10;
    // 动画起始时间
    anim.beginTime = CACurrentMediaTime() + index * 0.025;
    // 添加动画
    [view.layer pop_addAnimation:anim forKey:nil];
    return anim;
}

#pragma mark - 事件处理
/// 点击分享平台按钮
- (void)_clickShareTypeButton:(UIButton *)button {
    
    // 记录选中的按钮
    self.selectedButton = button;
    
    // 遍历所有按钮
    for (UIButton *btn in self.menuButtons) {
        
        POPBasicAnimation *scaleAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        
        CGFloat scale = (btn == button) ? 1.2 : 0.8;
        scaleAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(scale, scale)];
        
        POPBasicAnimation *alphaAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        alphaAnim.toValue = @(0.2);
        
        [btn.layer pop_addAnimation:scaleAnim forKey:nil];
        [btn.layer pop_addAnimation:alphaAnim forKey:nil];
        
        if (btn == button) {
            alphaAnim.delegate = self;
        }
    }
}

/// 关闭分享面板
- (void)_closeView{
    [self _hideAnimation];
}

#pragma mark - POPAnimationDelegate
- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {
    // 完成回调
    if (self.completionCallBack != nil) {
        self.completionCallBack(self.selectedButton.tag);
    }
    // 移除当前视图
    [self removeFromSuperview];
}

#pragma mark - 初始化
- (void)_setup{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
}

#pragma mark - 初始化子空间
- (void)_setupSubViews{
    // 底部工具视图
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    self.contentView = contentView;
    contentView.clipsToBounds = NO;
    [self addSubview:contentView];
    
    /// titleLabel
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"分享到";
    titleLabel.font = MHRegularFont(MHConvertToFitPt(18));
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    /// 设置按钮
    NSMutableArray *btnImageNames = [NSMutableArray array];
    [btnImageNames addObjectsFromArray:@[@"friends" , @"tencent_weibo" , @"QQ" , @"wechat" , @"sina" , @"qzone"]];
    NSMutableArray *btnTitleNames = [NSMutableArray array];
    [btnTitleNames addObjectsFromArray:@[@"朋友圈" , @"腾讯微博" , @"QQ" , @"微信" , @"新浪微博" , @"QQ空间"]];
    NSInteger count = btnTitleNames.count;
    for (NSInteger i = 0; i < count; i++) {
        MHShareTypeButton *button = [[MHShareTypeButton alloc] initWithFrame:CGRectMake(0, 0, MHConvertToFitPt(60), MHConvertToFitPt(75))];
        [button setImage:[UIImage imageNamed:btnImageNames[i]] forState:UIControlStateNormal];
        [button setTitle:btnTitleNames[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorFromHexString:@"#333333"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(_clickShareTypeButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.menuButtons addObject:button];
        [contentView addSubview:button];
    }
    
    /// 取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(_closeView) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = MHRegularFont(MHConvertToFitPt(18));
    self.cancelBtn = cancelBtn;
    [contentView addSubview:cancelBtn];
    
    /// 分割线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = MHColorFromHexString(@"a2a2a2");
    [contentView addSubview:lineView];
    self.lineView = lineView;
}

#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints{
    
    CGFloat contentViewH = MHConvertToFitPt(300);
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(contentViewH);
    }];
    
    /// topView
    CGFloat topViewH = MHConvertToFitPt(54);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(topViewH);
        make.left.and.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).with.offset(contentViewH);
    }];
    
    /// 底部View
    CGFloat bottomViewH = MHConvertToFitPt(57);
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).with.offset(-(bottomViewH-1));
        make.height.mas_equalTo(1);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).with.offset(bottomViewH);
        make.height.mas_equalTo(bottomViewH);
    }];
}

#pragma mark - 布局
- (void)layoutSubviews{
    [super layoutSubviews];
    /// 布局按钮
    CGFloat btnW = MHConvertToFitPt(60);
    CGFloat btnH = MHConvertToFitPt(75);
    /// 横屏margin
    CGFloat lMargin = (self.mh_width - 3 * btnW)/ 6.0f;
    for (NSInteger i = 0; i < self.menuButtons.count; i++) {
        UIButton *btn = self.menuButtons[i];
        CGFloat btnX = lMargin + (lMargin + btnW + lMargin) * (i % 3);
        /// Y值先将其设置在最底下即可
        CGFloat btnY = MHConvertToFitPt(300);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}


#pragma mark - Setter & Getter
- (NSMutableArray *)menuButtons{
    if (_menuButtons == nil) {
        _menuButtons = [[NSMutableArray alloc] init];
    }
    return _menuButtons;
}
@end
