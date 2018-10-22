//
//  MHConstInline.h
//  MHDevelopExample
//
//  Created by lx on 2018/6/5.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#ifndef MHConstInline_h
#define MHConstInline_h

/// 适配 iPhone X 距离顶部的距离
static inline CGFloat MHTopMargin(CGFloat pt){
    return MH_IS_IPHONE_X ? (pt + 24) : (pt);
}

/// 适配 iPhone X 距离底部的距离
static inline CGFloat MHBottomMargin(CGFloat pt){
    return MH_IS_IPHONE_X ? (pt + 34) : (pt);
}

/// 适配屏幕
static inline CGFloat MHConvertToFitPt(CGFloat pt){
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return ceil(pt * screenWidth/320.0f);
}


#endif /* MHConstInline_h */
