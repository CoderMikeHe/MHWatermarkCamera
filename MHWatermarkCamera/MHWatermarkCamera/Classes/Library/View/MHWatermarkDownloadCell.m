//
//  MHWatermarkDownloadCell.m
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/22.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "MHWatermarkDownloadCell.h"

@implementation MHWatermarkDownloadCell
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
    self.backgroundColor = MHRandomColor;
}

/// 初始化子控件
- (void)_setupSubViews
{
    
}

/// 布局子控件
- (void)_makeSubViewsConstraints{
    
}
@end
