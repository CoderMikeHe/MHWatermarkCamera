//
//  MHCommonItem.h
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/18.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHCommonItem : NSObject

/// 图标
@property (nonatomic, readwrite, copy) NSString *icon;
/// 标题
@property (nonatomic, readwrite, copy) NSString *title;
/// 子标题
@property (nonatomic, readwrite, copy) NSString *subtitle;


/// rowHeight , default is 44.0f
@property (nonatomic, readwrite, assign) CGFloat rowHeight;

// default is UITableViewCellSelectionStyleGray.
@property (nonatomic, readwrite, assign) UITableViewCellSelectionStyle selectionStyle;

/// 右边显示的数字标记
@property (nonatomic, readwrite, copy) NSString *badgeValue;

/// 点击这行cell，需要调转到哪个控制器的视图控制器
@property (nonatomic, readwrite, assign) Class destClass;
/// 封装点击这行cell想做的事情
@property (nonatomic, readwrite, copy) void (^operation)(void);

/// init title or icon
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
/// init title
+ (instancetype)itemWithTitle:(NSString *)title;
@end
