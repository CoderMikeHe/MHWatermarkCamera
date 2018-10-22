//
//  YYCache+MHHelper.m
//  MHDevelopExample
//
//  Created by lx on 2018/6/8.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "YYCache+MHHelper.h"

/// 获取缓存的key
NSString * const MHSearchFarmsHistoryCacheKey = @"MHSearchFarmsHistoryCacheKey";

/// 第六个Demo中缓存网络图片 获取缓存的key
NSString * _Nullable const MHExample06RemoteImageCacheKey = @"MHExample06RemoteImageCacheKey";

/// 整个应用的利用YYCache来做磁盘和内存缓存的文件名称，切记该文件只能使用YYCache来做处理 具有相同名称的多个实例将缓存不稳定
static NSString *const MHApplicationYYCacheName = @"com.yy.cache";
/// 整个应用的利用YYCache来做磁盘和内存缓存的文件目录，切记该文件只能使用YYCache来做处理
static inline NSString * MHApplicationYYCachePath(){
    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:MHApplicationYYCacheName];
    return cachePath;
}

@implementation YYCache (MHHelper)
+ (instancetype)sharedCache {
    static YYCache *sharedCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCache = [[YYCache alloc] initWithPath:MHApplicationYYCachePath()];
    });
    return sharedCache;
}
@end
