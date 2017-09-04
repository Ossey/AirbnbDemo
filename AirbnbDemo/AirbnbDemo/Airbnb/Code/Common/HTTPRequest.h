//
//  HTTPRequest.h
//  Boobuz
//
//  Created by xiaoyuan on 2017/7/11.
//  Copyright © 2017年 erlinyou.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSProgress *Progress;
typedef void (^ProgressBlock)(Progress progress);
typedef void(^CompletionHandler)(NSURLSessionDataTask *task, id responseObject, NSError *error);
typedef void(^SuccessBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void(^FailureBlock)(NSURLSessionDataTask *task, NSError *error);

typedef NS_ENUM(NSUInteger, HTTPMethod) {
    GET,
    POST,
};

@class HTTPUploadFileConfig;

@interface HTTPRequest : NSObject

@property (nonatomic, strong, class) HTTPRequest *manager;

@property (nonatomic, assign) NSTimeInterval timeoutInterval;

+ (NSURLSessionDataTask *)request:(NSString *)urlString
                       method:(HTTPMethod)method
                   parameters:(NSDictionary *)parameters
            completionHandler:(CompletionHandler)completion;

+ (NSURLSessionDataTask *)request:(NSString *)urlString
                           method:(HTTPMethod)method
                       parameters:(NSDictionary *)parameters
                          success:(SuccessBlock)success
                          failure:(FailureBlock)failure;

+ (NSURLSessionDataTask *)upload:(NSString *)urlString
              fileConfigList:(NSArray<HTTPUploadFileConfig *> *)fileConfigList
                  parameters:(NSDictionary *)parameters
                    progress:(ProgressBlock)progress
           completionHandler:(CompletionHandler)completion;

+ (NSURLSessionDownloadTask *)download:(NSString *)urlString
                      progress:(ProgressBlock)progress
             completionHandler:(CompletionHandler)completion;

/// 设置请求头信息
+ (void)setRequestHeader:(NSDictionary *)headers;

+ (void)cancelAllOperations;

@end

#pragma mark *** Upload file config ***

@interface HTTPUploadFileConfig : NSObject<NSCopying>

/// 服务器接收的 类似input标签type为file的name值
/// 此参数用于获取文件上传对象 Part part = request.getPart("f"); 这个f就是name的值
/*
 web端，可以这么写，name属性，就是相当于type="file"的name
 <form action="/FileUploadDemo/upload1" method="post" enctype="multipart/form-data">
 <input type="text" name="username"/><br/>
 <input type="file" name="f"/><br/>
 <input type="submit" value="提交"/>
 </form>
 */
@property (nonatomic, copy) NSString *name;
/// 文件全名，要带上后缀，比如1.png
@property (nonatomic, copy) NSString *fileName;
/// 文件类型
@property (nonatomic, copy) NSString *mimeType;
/// 文件二进制数据
@property (nonatomic, strong) NSData *fileData;

- (instancetype)initWithFormData:(NSData *)fileData
                            name:(NSString *)name
                        fileName:(NSString *)fileName
                        mimeType:(NSString *)mimeType;

@end
