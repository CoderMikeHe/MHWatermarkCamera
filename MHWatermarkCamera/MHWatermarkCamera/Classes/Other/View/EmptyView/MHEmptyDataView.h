//
//  MHEmptyDataView.h
//  MHDevelopExample
//
//  Created by lx on 2018/6/19.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//  数据为空的占位View <PS：这个完全可以根据自身产品去设计一套属于自身产品的空白页，嘻嘻>

#import <UIKit/UIKit.h>
/// 这些类型聚根据自身产品去定义
typedef NS_ENUM(NSUInteger, MHEmptyDataViewType) {
    MHEmptyDataViewTypeDefault = 0,               /// 默认空数据显示
    MHEmptyDataViewTypeBuyGoods ,                 /// 买到的商品
    MHEmptyDataViewTypeSoldGoods ,                /// 卖出的商品
    MHEmptyDataViewTypePublishGoods ,             /// 发布的商品
    MHEmptyDataViewTypeCollectGoods ,             /// 收藏的商品
    MHEmptyDataViewTypeGoodsDetail ,              /// 商品的详情
    MHEmptyDataViewTypeSearchGoods ,              /// 搜索的商品
    MHEmptyDataViewTypeOrderDetail ,              /// 订单的详情
    MHEmptyDataViewTypeAddress ,                  /// 地址信息
    MHEmptyDataViewTypeRedPocket ,                /// 可用红包
};


@interface MHEmptyDataView : UIView

/**
 无数据显示友好文本提示视图
 @param type 显示类型
 @param emptyInfo 无数据时提示文字信息，不传则为默认；
 @param errorInfo 无数据且请求错误时提示文字信息，不传则为默认；
 @param offsetTop 显示的图片的中心点Y值距离其父类视图的顶部的距离
 @param hasData  是否存在数据
 @param hasError 是否存在错误
 @param reloadBlock 如果有加载按钮点击的回调
 */
- (void)configEmptyViewWithType:(MHEmptyDataViewType)type emptyInfo:(NSString *)emptyInfo errorInfo:(NSString *)errorInfo offsetTop:(CGFloat)offsetTop hasData:(BOOL)hasData hasError:(BOOL)hasError reloadBlock:(void(^)(void))reloadBlock;
@end
