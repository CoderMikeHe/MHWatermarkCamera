//
//  MHLibraryController.m
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/18.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "MHLibraryController.h"
#import "MHWatermarkDownloadController.h"
@interface MHLibraryController ()
/// titleNames
@property (nonatomic , readwrite , copy) NSArray *titleNames;

@end

@implementation MHLibraryController

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
- (void)_close:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - WMPageControllerDataSource, WMPageControllerDelegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titleNames.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titleNames[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    return [[MHWatermarkDownloadController alloc] initWithParams:nil];
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 10;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat leftMargin = 0;
    CGFloat originY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    menuView.backgroundColor = [UIColor blackColor];
    return CGRectMake(leftMargin, originY, self.view.frame.size.width - 2*leftMargin, MHConvertToFitPt(44.0f));
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}


#pragma mark - 初始化
- (void)_setup{
    self.titleColorNormal = MHColorFromHexString(@"#656b76");
    self.titleColorSelected = MHColorFromHexString(@"#1ab3ef");
    self.titleSizeNormal = MHConvertToFitPt(16);
    self.titleSizeSelected = MHConvertToFitPt(16);
    self.titleNames = @[@"特色",@"心情",@"人像",@"地点",@"时间",@"天气",@"美食",@"热点"];
    [self reloadData];
}

#pragma mark - 设置导航栏
- (void)_setupNavigationItem{
    self.title = @"水印库";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem mh_systemItemWithTitle:@"关闭" titleColor:MHColorFromHexString(@"#1ab3ef") imageName:nil target:self selector:@selector(_close:) textType:YES];
}

#pragma mark - 设置子控件
- (void)_setupSubViews{
    
}

#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints{
    
}

#pragma mark - Setter & Getter

@end
