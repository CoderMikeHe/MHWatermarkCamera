//
//  MHShareTypeButton.m
//  MHExample
//
//  Created by lx on 2018/4/3.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "MHShareTypeButton.h"

@implementation MHShareTypeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = MHRegularFont(MHConvertToFitPt(14));
    }
    return self;
}

#pragma mark - 布局
- (void)layoutSubviews{
    [super layoutSubviews];
    
    /// 布局图片
    CGFloat imageViewX = 0;
    CGFloat imageViewY = 0;
    CGFloat imageViewW = self.imageView.frame.size.width;
    CGFloat imageViewH = self.imageView.frame.size.width;
    self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    self.imageView.mh_centerX = self.mh_width *.5f;
    
    
    /// 布局文字
    CGFloat titleLabelX = 0;
    CGFloat titleLabelW = self.mh_width;
    CGFloat titleLabelH = self.titleLabel.frame.size.height;
    CGFloat titleLabelY = self.mh_height - titleLabelH;
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
}

@end
