//
//  MHWatermarkCell.m
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/10.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "MHWatermarkCell.h"

@implementation MHWatermarkCell

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

#pragma mark - 初始化 & 初始化子控件 & 布局子控件
/// 初始化
- (void)_setup{
    self.contentView.backgroundColor = MHRandomColor;
}

/// 初始化子控件
- (void)_setupSubViews
{
    
}

/// 布局子控件
- (void)_makeSubViewsConstraints{
    
}

@end
