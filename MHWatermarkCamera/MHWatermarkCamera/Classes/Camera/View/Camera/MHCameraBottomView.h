//
//  MHCameraBottomView.h
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/8.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "MHView.h"

@interface MHCameraBottomView : MHView
/// init
+ (instancetype)bottomView;

/// 显示模式
@property (nonatomic , readonly , assign) MHCameraShowMode showModel;

@end
