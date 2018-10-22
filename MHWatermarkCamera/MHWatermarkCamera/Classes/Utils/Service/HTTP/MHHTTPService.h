//
//  MHHTTPService.h
//  MHDevelopExample
//
//  Created by lx on 2018/6/20.
//  Copyright © 2018年 CoderMikeHe. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "MHHTTPRequest.h"

// The domain for all errors originating in MHHTTPService.
FOUNDATION_EXTERN NSString *const MHHTTPServiceErrorDomain ;

/// 连接服务器失败 default
FOUNDATION_EXTERN NSInteger const MHHTTPServiceErrorConnectionFailed ;
/// 解析数据出错
FOUNDATION_EXTERN NSInteger const MHHTTPServiceErrorJSONParsingFailed ;
// The request was invalid (HTTP error 400).
FOUNDATION_EXTERN NSInteger const MHHTTPServiceErrorBadRequest;
// The server is refusing to process the request because of an
// authentication-related issue (HTTP error 403).
//
// Often, this means that there have been too many failed attempts to
// authenticate. Even a successful authentication will not work while this error
// code is being returned. The only recourse is to stop trying and wait for
// a bit.
FOUNDATION_EXTERN NSInteger const MHHTTPServiceErrorRequestForbidden ;
// The server refused to process the request (HTTP error 422)
FOUNDATION_EXTERN NSInteger const MHHTTPServiceErrorServiceRequestFailed ;
// There was a problem establishing a secure connection, although the server is
// reachable.
FOUNDATION_EXTERN NSInteger const MHHTTPServiceErrorSecureConnectionFailed;




/// URL key
FOUNDATION_EXTERN NSString * const MHHTTPServiceErrorRequestURLKey ;
/// HttpStatusCode key
FOUNDATION_EXTERN NSString * const MHHTTPServiceErrorHTTPStatusCodeKey ;
/// error desc key
FOUNDATION_EXTERN NSString * const MHHTTPServiceErrorDescriptionKey ;


@interface MHHTTPService : AFHTTPSessionManager
/// 单例
+(instancetype) sharedInstance;

@end


/// 请求类
@interface MHHTTPService (Request)

/// 1. 使用须知：后台返回数据的保证为👇固定格式 且`data:{}`必须为`字典`或者`NSNull`;
/// {
///    code：0,
///    msg: "",
///    data:{
///    }
/// }
/**
- (void)tableViewDidTriggerFooterRefresh{
    /// 下拉加载事件 子类重写
    /// 1. 配置参数
    MHKeyedSubscript *subscript = [MHKeyedSubscript subscript];
    subscript[@"useridx"] = @"61856069";
    subscript[@"type"] = @(1);
    subscript[@"page"] = @(self.page + 1);
    subscript[@"lat"] = @(22.54192103514200);
    subscript[@"lon"] = @(113.96939828211362);
    subscript[@"province"] = @"广东省";
    
    /// 2. 配置参数模型 #define MH_GET_LIVE_ROOM_LIST  @"Room/GetHotLive_v2"
    MHURLParameters *paramters = [MHURLParameters urlParametersWithMethod:MH_HTTTP_METHOD_GET path:MH_GET_LIVE_ROOM_LIST parameters:subscript.dictionary];
    
    /// 3. 发起请求
    [[MHHTTPRequest requestWithParameters:paramters] enqueueResultClass:MHLiveRoom.class parsedResult:YES success:^(NSURLSessionDataTask *task, NSArray <MHLiveRoom *> * responseObject) {
        /// 数据请求成功
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        /// 数据请求失败
    }];
}
*/


/**
 从服务器那里获取数据
 @param request 请求配置类
 @param resultClass 可以传`nil`，则成功`success`回调的 `responseObject` 为 `MHHTTPResponse`对象；若传`Class`，则必须是 `MHObject` 的子类，否则会`Crash`,则成功`success`回调的 `responseObject` 为 `MHHTTPResponse`对象，且 `MHHTTPResponse`对象的`parsedResult`属性，则对应 `resultClass`模型
 @param parsedResult 是否要解析`MHHTTPResponse`对象的`parsedResult`属性，如果为 YES , 则成功`success`回调的 `responseObject` 为 `MHHTTPResponse`对象的`parsedResult`属性所对应的模型 ， 如果为NO,则成功`success`回调的 `responseObject` 为 `MHHTTPResponse`对象；
 @param success 成功的回调
 @param failure 失败的回调
 @return 返回一个 dataTask
 */
-(NSURLSessionDataTask *)enqueueRequest:(MHHTTPRequest *) request
                            resultClass:(Class /*subclass of MHObject*/) resultClass
                           parsedResult:(BOOL)parsedResult
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;


/**
 用来上传多个文件流，也可以上传单个文件  MH TODO
 
 @param request MHHTTPRequest
 @param resultClass 要转化出来的请求结果且必须是 `MHObject`的子类，否则Crash
 @param fileDatas 要上传的 文件数据，数组里面必须是装着` NSData ` 否则Crash
 @param name  这个是服务器的`资源文件名`，这个服务器会给出具体的数值，不能传nil 否则 Crach
 @param mimeType http://www.jianshu.com/p/a3e77751d37c 如果传nil ，则会传递 application/octet-stream
 @return Returns a signal which will send an instance of `MHHTTPResponse` for each parsed
 JSON object, then complete. If an error occurs at any point,
 the returned signal will send it immediately, then terminate.
 */
//- (RACSignal *)enqueueUploadRequest:(MHHTTPRequest *) request
//                        resultClass:(Class /*subclass of MHObject*/) resultClass
//                          fileDatas:(NSArray <NSData *> *)fileDatas
//                               name:(NSString *)name
//                           mimeType:(NSString *)mimeType;
@end
