//
//  MHCommonController.m
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/18.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "MHCommonController.h"
#import "MHCommonHeaderView.h"
#import "MHCommonFooterView.h"
#import "MHCommonCell.h"

@interface MHCommonController ()

@end

@implementation MHCommonController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.style = UITableViewStyleGrouped;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark - Override
- (UIEdgeInsets)contentInset{
    return UIEdgeInsetsMake(MH_APPLICATION_TOP_BAR_HEIGHT, 0, 0, 0);
}
- (void)configureCell:(MHCommonCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    [cell configureModel:object];
}
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [MHCommonCell cellWithTableView:tableView];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MHCommonGroup *group = self.dataSource[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /// fetch cell
    MHCommonCell *cell = (MHCommonCell *)[self tableView:tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    MHCommonGroup *group = self.dataSource[indexPath.section];
    id object = group.items[indexPath.row];
    /// bind model
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    [cell setIndexPath:indexPath rowsInSection:group.items.count];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    MHCommonFooterView *footerView = [MHCommonFooterView footerViewWithTableView:tableView];
    MHCommonGroup *group = self.dataSource[section];
    return footerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MHCommonHeaderView *headerView = [MHCommonHeaderView headerViewWithTableView:tableView];
    MHCommonGroup *group = self.dataSource[section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MHCommonGroup *group = self.dataSource[indexPath.section];
    MHCommonItem *item = group.items[indexPath.row];
    return item.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    MHCommonGroup *group = self.dataSource[section];
    return group.headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    MHCommonGroup *group = self.dataSource[section];
    return group.footerHeight;
}

/// 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MHCommonGroup *group = self.dataSource[indexPath.section] ;
    MHCommonItem *item = group.items[indexPath.row];
    
    if (item.operation) {
        /// 有操作执行操作
        item.operation();
    }else if(item.destClass){
        /// 没有操作就跳转VC
        Class Class = item.destClass;
        MHViewController *vc = [[Class alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
