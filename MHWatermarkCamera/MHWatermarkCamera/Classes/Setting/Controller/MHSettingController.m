//
//  MHSettingController.m
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/18.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "MHSettingController.h"
#import "MHCommonArrowItem.h"
#import "MHCommonSwitchItem.h"
@interface MHSettingController ()

@end

@implementation MHSettingController

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
- (void)_done:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark - Override
- (void)configure{
    [super configure];
    
    /// 第一组
    MHCommonGroup *group0 = [MHCommonGroup group];
    group0.headerHeight = MHConvertToFitPt(35);
    /// 0.我的账号
    MHCommonArrowItem *myAccount = [MHCommonArrowItem itemWithTitle:@"我的账号"];
    /// 1.个人信息
    MHCommonArrowItem *personInfo = [MHCommonArrowItem itemWithTitle:@"个人信息"];
    group0.items = @[myAccount,personInfo];
    
    /// 第二组
    MHCommonGroup *group1 = [MHCommonGroup group];
    group1.headerHeight = MHConvertToFitPt(35);
    /// 0.字体
    MHCommonArrowItem *fonts = [MHCommonArrowItem itemWithTitle:@"字体"];
    /// 1.拍照时保存原图
    MHCommonSwitchItem *saveOriginalPic = [MHCommonSwitchItem itemWithTitle:@"拍照时保存原图"];
    saveOriginalPic.key = MHPreferenceSettingSaveOriginalPic;
    group1.items = @[fonts,saveOriginalPic];
    
    /// 第一组
    MHCommonGroup *group2 = [MHCommonGroup group];
    group2.headerHeight = MHConvertToFitPt(35);
    /// 0.反馈
    MHCommonArrowItem *feedback = [MHCommonArrowItem itemWithTitle:@"反馈"];
    /// 1.给水印相机打分
    MHCommonArrowItem *score = [MHCommonArrowItem itemWithTitle:@"给水印相机打分"];
    /// 2.帮助
    MHCommonArrowItem *help = [MHCommonArrowItem itemWithTitle:@"帮助"];
    /// 3.关于
    MHCommonArrowItem *about = [MHCommonArrowItem itemWithTitle:@"关于"];
    group2.items = @[feedback,score,help,about];
    
    [self.dataSource addObject:group0];
    [self.dataSource addObject:group1];
    [self.dataSource addObject:group2];
}


#pragma mark - 初始化
- (void)_setup{
}

#pragma mark - 设置导航栏
- (void)_setupNavigationItem{
    self.title = @"设置";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem mh_systemItemWithTitle:@"完成" titleColor:MHColorFromHexString(@"#1ab3ef") imageName:nil target:self selector:@selector(_done:) textType:YES];
}

#pragma mark - 设置子控件
- (void)_setupSubViews{
    
}

#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints{
    
}

#pragma mark - Setter & Getter



@end
