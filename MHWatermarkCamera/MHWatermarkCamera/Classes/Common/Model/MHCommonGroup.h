//
//  MHCommonGroup.h
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/18.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHCommonGroup : NSObject
/// 组头
@property (nonatomic, readwrite, copy) NSString *header;
/// headerHeight defalult is CGFLOAT_MIN
@property (nonatomic, readwrite, assign) CGFloat headerHeight;
/// 组尾
@property (nonatomic, readwrite, copy) NSString *footer;
/// footerHeight defalult is CGFLOAT_MIN
@property (nonatomic, readwrite, assign) CGFloat footerHeight;
/// 里面装着都是 MHCommonItem 以及其子类
@property (nonatomic, readwrite, copy) NSArray *items;

+ (instancetype)group;
@end
