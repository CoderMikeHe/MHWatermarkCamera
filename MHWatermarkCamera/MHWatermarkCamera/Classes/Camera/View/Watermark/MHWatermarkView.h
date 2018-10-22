//
//  MHWatermarkView.h
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/9.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//  水印View -- 单个水印集合

#import "MHView.h"

@interface MHWatermarkView : MHView
/// dataSource
@property (nonatomic , readwrite , copy) NSArray *dataSource;

@end
