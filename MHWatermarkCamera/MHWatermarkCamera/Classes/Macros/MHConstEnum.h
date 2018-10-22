//
//  MHConstEnum.h
//  MHDevelopExample
//
//  Created by lx on 2018/5/24.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#ifndef MHConstEnum_h
#define MHConstEnum_h

/// tababr item tag
typedef NS_ENUM(NSUInteger, MHTabBarItemTagType) {
    MHTabBarItemTagTypeMainFrame = 0,    /// 消息回话
    MHTabBarItemTagTypeContacts,         /// 通讯录
    MHTabBarItemTagTypeDiscover,         /// 发现
    MHTabBarItemTagTypeProfile,          /// 我的
};


/// 水印相机页面展示模式
typedef NS_ENUM(NSUInteger, MHCameraShowMode) {
    MHCameraShowModeDefault = 0,          /// 拍照
    MHCameraShowModeCapturePhoto,         /// 获取到图片
    MHCameraShowModeWatermarkGather,      /// 水印集合
};

#endif /* MHConstEnum_h */
