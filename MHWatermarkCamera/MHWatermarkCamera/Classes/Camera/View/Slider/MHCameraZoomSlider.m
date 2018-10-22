//
//  MHCameraZoomSlider.m
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/10.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "MHCameraZoomSlider.h"

@interface MHCameraZoomSlider ()

/// 是否设置过layer
@property (nonatomic , readwrite , assign) BOOL didSetLayer;

@end


@implementation MHCameraZoomSlider

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
    self.minimumValue = 1;
    self.maximumValue = 5;
}

#pragma mark - 创建自控制器
- (void)_setupSubViews
{
    self.minimumTrackTintColor = [[UIColor whiteColor] colorWithAlphaComponent:.4];
    self.maximumTrackTintColor = self.minimumTrackTintColor;
    
    UIImage * minimumValueImage = MHImageNamed(@"zoom-");
    self.minimumValueImage = [minimumValueImage yy_imageByRotateRight90];
    
    UIImage * maximumValueImage = MHImageNamed(@"zoom+");
    self.maximumValueImage = [maximumValueImage yy_imageByRotateRight90];
    
    
    
    
    UIImage *norImage = MHImageNamed(@"slider_dot");
    UIImage *highImage = MHImageNamed(@"slider_dot_pressed");
    
    /// 图片合成
    UIGraphicsBeginImageContextWithOptions(highImage.size , NO, highImage.scale);
    [highImage drawInRect:CGRectMake(0, 0, highImage.size.width, highImage.size.height)];
    CGFloat w = norImage.size.width;
    CGFloat h = norImage.size.height;
    CGFloat x = (highImage.size.width - w) * .5f;
    CGFloat y = (highImage.size.height - h) * .5f;
    [norImage yy_drawInRect:CGRectMake(x, y, w, h) withContentMode:UIViewContentModeScaleAspectFit clipsToBounds:NO];
    highImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self setThumbImage:norImage forState:UIControlStateNormal];
    [self setThumbImage:highImage forState:UIControlStateHighlighted];
}

#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints{
    
}



#pragma mark - Override
- (CGRect)minimumValueImageRectForBounds:(CGRect)bounds{
    CGFloat X = 0;
    CGFloat H = MHConvertToFitPt(21);
    CGFloat Y =( bounds.size.height - H ) *.5f;
    CGFloat W = H;
    return CGRectMake(X, Y, W, H);
    
}
- (CGRect)maximumValueImageRectForBounds:(CGRect)bounds{
    CGFloat H = MHConvertToFitPt(21);
    CGFloat Y =( bounds.size.height - H ) *.5f;
    CGFloat W = H;
    CGFloat X = bounds.size.width - W;
    return CGRectMake(X, Y, W, H);
}

- (CGRect)trackRectForBounds:(CGRect)bounds{
    CGRect minimumValueImageRect = [self minimumValueImageRectForBounds:bounds];
    CGRect maximumValueImageRect = [self maximumValueImageRectForBounds:bounds];
    CGFloat margin = MHConvertToFitPt(2);
    CGFloat H = MHConvertToFitPt(6);
    CGFloat Y =( bounds.size.height - H ) *.5f;
    CGFloat X = CGRectGetMaxX(minimumValueImageRect) + margin;
    CGFloat W = CGRectGetMinX(maximumValueImageRect) - X - margin;
    return CGRectMake(X, Y, W, H);
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value{
    
    CGFloat WH = 30;
    CGFloat margin = WH *.5f - 21 *.5f + 2;
    /// 滑块的滑动区域宽度
    CGFloat maxWidth = CGRectGetWidth(rect) + 2 * margin;
    /// 每次偏移量
    CGFloat offset = (maxWidth - WH)/(self.maximumValue - self.minimumValue);
    
    CGFloat H = WH;
    CGFloat Y = (bounds.size.height - H ) *.5f;
    CGFloat W = H;
    CGFloat X = CGRectGetMinX(rect) - margin + offset *(value-self.minimumValue);
    CGRect r =  CGRectMake(X, Y, W, H);
    return r;
}


#pragma mark - 布局
- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.didSetLayer) {
        return;
    }
    BOOL didSetLayer = NO;
    for (UIView *v in self.subviews) {
        if (v.mh_height <= MHConvertToFitPt(6) &&  self.mh_height > 0) {
            v.layer.borderWidth = 0.5f;
            v.layer.borderColor = MHColorFromHexString(@"#2C2E30").CGColor;
            v.layer.cornerRadius = MHConvertToFitPt(6) *.5f;
            v.layer.masksToBounds = YES;
            didSetLayer = YES;
        }
    }
    self.didSetLayer = didSetLayer;
}

@end
