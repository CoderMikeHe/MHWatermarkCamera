//
//  MHCommonSwitchItem.m
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/18.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "MHCommonSwitchItem.h"
#import "MHPreferenceSettingHelper.h"
@implementation MHCommonSwitchItem
- (void)setOff:(BOOL)off
{
    _off = off;
    
    [MHPreferenceSettingHelper setBool:off forKey:self.key];
}

- (void)setKey:(NSString *)key
{
    [super setKey:key];
    
    _off = [MHPreferenceSettingHelper boolForKey:key];
}
@end
