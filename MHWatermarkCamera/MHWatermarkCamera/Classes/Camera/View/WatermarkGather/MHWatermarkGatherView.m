//
//  MHWatermarkGatherView.m
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/9.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "MHWatermarkGatherView.h"

@implementation MHWatermarkGatherView

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
    
}

#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints{
    
}

@end
