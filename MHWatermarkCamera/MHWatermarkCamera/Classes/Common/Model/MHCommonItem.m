//
//  MHCommonItem.m
//  MHWatermarkCamera
//
//  Created by lx on 2018/10/18.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "MHCommonItem.h"

@implementation MHCommonItem
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon{
    MHCommonItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title{
    return [self itemWithTitle:title icon:nil];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _selectionStyle = UITableViewCellSelectionStyleGray;
        _rowHeight = MHConvertToFitPt(44.0f);
    }
    return self;
}
@end
