//
//  MHShareView.h
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/10.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//  分享View

#import "MHView.h"

typedef NS_ENUM(NSUInteger, MHShareViewType) {
    MHShareViewTypeWechatTimeLine = 0,   /// 微信朋友圈
    MHShareViewTypeTencentWeibo,         /// 腾讯微博
    MHShareViewTypeQQ,                   /// QQ好友
    MHShareViewTypeWechatSession,        /// 微信好友
    MHShareViewTypeSinaWeibo,            /// 新浪微博
    MHShareViewTypeQZone,                /// QQ好友
};

@interface MHShareView : MHView
/// 构造函数
///
/// @param completed 完成回调
///
/// @return 撰写类型视图
- (instancetype)initWithSelectedShareType:(void (^)(MHShareViewType type))completed;
/// 显示在指定视图中
- (void)showInView:(UIView *)view;
@end
