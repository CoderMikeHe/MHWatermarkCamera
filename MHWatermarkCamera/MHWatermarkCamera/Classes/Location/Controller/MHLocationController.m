//
//  MHLocationController.m
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/18.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "MHLocationController.h"

@interface MHLocationController ()

@end

@implementation MHLocationController

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
- (void)_cancel:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark - 初始化
- (void)_setup{
}

#pragma mark - 设置导航栏
- (void)_setupNavigationItem{
    self.title = @"位置";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem mh_systemItemWithTitle:@"取消" titleColor:MHColorFromHexString(@"#1ab3ef") imageName:nil target:self selector:@selector(_cancel:) textType:YES];
}

#pragma mark - 设置子控件
- (void)_setupSubViews{
    
}

#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints{
    
}

#pragma mark - Setter & Getter

@end
