//
//  MHCommonGroup.m
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/18.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "MHCommonGroup.h"

@implementation MHCommonGroup
+ (instancetype)group{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _footerHeight = CGFLOAT_MIN;
        _headerHeight = CGFLOAT_MIN;
    }
    return self;
}
@end
