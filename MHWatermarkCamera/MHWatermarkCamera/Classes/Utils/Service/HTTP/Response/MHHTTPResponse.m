//
//  MHHTTPResponse.m
//  MHDevelopExample
//
//  Created by lx on 2018/6/20.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import "MHHTTPResponse.h"

@interface MHHTTPResponse ()
/// The parsed MHObject object corresponding to the API response.
/// The developer need care this data
@property (nonatomic, readwrite, strong) id parsedResult;
/// 自己服务器返回的状态码
@property (nonatomic, readwrite, assign) MHHTTPResponseCode code;
/// 自己服务器返回的信息
@property (nonatomic, readwrite, copy) NSString *msg;
@end

@implementation MHHTTPResponse

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject parsedResult:(id)parsedResult
{
    self = [super init];
    if (self) {
        self.parsedResult = parsedResult;
        self.code = [responseObject[MHHTTPServiceResponseCodeKey] integerValue];
        self.msg = responseObject[MHHTTPServiceResponseMsgKey];
    }
    return self;
}
@end
