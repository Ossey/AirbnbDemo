//
//  HTTPRequest.m
//  Boobuz
//
//  Created by xiaoyuan on 2017/7/11.
//  Copyright © 2017年 erlinyou.com. All rights reserved.
//

#import "HTTPRequest.h"
#import <AFNetworking.h>

@interface HTTPRequest ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation HTTPRequest

////////////////////////////////////////////////////////////////////////
#pragma mark - Initialize
////////////////////////////////////////////////////////////////////////

@dynamic manager;
static HTTPRequest *_instance;

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _timeoutInterval = 30.0;
        
    }
    return self;
}


////////////////////////////////////////////////////////////////////////
#pragma mark - Public method
////////////////////////////////////////////////////////////////////////

+ (NSURLSessionDataTask *)request:(NSString *)urlString
                           method:(HTTPMethod)method
                       parameters:(NSDictionary *)parameters
                         progress:(ProgressBlock)progress
                completionHandler:(CompletionHandler)completion {
    NSURLSessionDataTask *task = nil;
    
    switch (method) {
        case GET:
            task = [self get:urlString
                  parameters:parameters
                    progress:progress
           completionHandler:completion];
            break;
        case POST:
            task = [self post:urlString
                   parameters:parameters
                     progress:progress
            completionHandler:completion];
            break;
        default:
            break;
    }
    return task;
}

+ (NSURLSessionDataTask *)request:(NSString *)urlString
                           method:(HTTPMethod)method
                       parameters:(NSDictionary *)parameters
                completionHandler:(CompletionHandler)completion {
    
    return [self request:urlString
                  method:method
              parameters:parameters
                progress:nil
       completionHandler:completion];
}

+ (NSURLSessionDataTask *)request:(NSString *)urlString
                           method:(HTTPMethod)method
                       parameters:(NSDictionary *)parameters
                          success:(SuccessBlock)success
                          failure:(FailureBlock)failure {
    
    return [self request:urlString
                  method:method
              parameters:parameters
                progress:nil
       completionHandler:^(NSURLSessionDataTask *task,
                           id responseObject,
                           NSError *error) {
           if (!error) {
               success(task, responseObject);
           } else {
               failure(task, error);
           }
       }];
}

+ (void)setRequestHeader:(NSDictionary *)headers {
    if (!headers.count) {
        return;
    }
    for (NSString *key in headers.allKeys) {
        [self.class.manager.sessionManager.requestSerializer setValue:headers[key]
                                                   forHTTPHeaderField:key];
    }
}

+ (void)cancelAllOperations {
    [self.class.manager.sessionManager.operationQueue cancelAllOperations];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Private methods
////////////////////////////////////////////////////////////////////////

+ (NSURLSessionDataTask *)get:(NSString *)urlString
                   parameters:(NSDictionary *)parameters
                     progress:(ProgressBlock)progress
            completionHandler:(CompletionHandler)completion {
    
    [self httpsURLString:urlString];
    return [self.class.manager.sessionManager GET:urlString
                                       parameters:parameters
                                         progress:progress
                                          success:[self successHandler:completion]
                                          failure:[self failureHandler:completion]];
}


+ (NSURLSessionDataTask *)post:(NSString *)urlString
                    parameters:(NSDictionary *)parameters
                      progress:(ProgressBlock)progress
             completionHandler:(CompletionHandler)completion {
    [self httpsURLString:urlString];
    return [self.class.manager.sessionManager POST:urlString
                                        parameters:parameters
                                          progress:progress
                                           success:[self successHandler:completion]
                                           failure:[self failureHandler:completion]];
}

+ (NSURLSessionDownloadTask *)download:(NSString *)urlString
                              progress:(ProgressBlock)progress
                     completionHandler:(CompletionHandler)completion {
    
    SuccessBlock successCallBack =
    ^(NSURLSessionDataTask *task, id dataObj){
        completion(task, dataObj, nil);
    };
    
    FailureBlock failureCallBack =
    ^(NSURLSessionDataTask *task, NSError *error){
        completion(task, nil, error);
    };
    
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:defaultConfig];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSessionDownloadTask *downloadTask =  [manager downloadTaskWithRequest:urlRequest progress:progress destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory
                                                                    inDomain:NSUserDomainMask
                                                           appropriateForURL:nil
                                                                      create:NO
                                                                       error:nil];
        return [documentURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            failureCallBack(nil, error);
        } else {
            successCallBack(nil, filePath);
        }
    }];
    [downloadTask resume];
    return downloadTask;
}


+ (NSURLSessionDataTask *)upload:(NSString *)urlString
                  fileConfigList:(NSArray<HTTPUploadFileConfig *> *)fileConfigList
                      parameters:(NSDictionary *)parameters
                        progress:(ProgressBlock)progress
               completionHandler:(CompletionHandler)completion {
    
    // 别把这个网页当json来处理
    self.class.manager.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return [self.class.manager.sessionManager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 多个文件上传
        if (!fileConfigList.count) {
            return;
        }
        for (HTTPUploadFileConfig *fc in fileConfigList) {
            [formData appendPartWithFileData:fc.fileData
                                        name:fc.name
                                    fileName:fc.fileName
                                    mimeType:fc.mimeType];}}
                                          progress:progress
                                           success:[self.class successHandler:completion]
                                           failure:[self.class failureHandler:completion]];
    
}

+ (SuccessBlock)successHandler:(CompletionHandler)completion {
    return ^(NSURLSessionDataTask *task, id dataObj){
        completion(task, dataObj, nil);
    };
}

+ (FailureBlock)failureHandler:(CompletionHandler)completion {
    return ^(NSURLSessionDataTask *task, NSError *error){
        completion(task, nil, error);
    };
}

+ (void)httpsURLString:(NSString *)urlString {
    if ([urlString hasPrefix:@"https://"]) {
        self.class.manager.sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        self.class.manager.sessionManager.securityPolicy.allowInvalidCertificates = YES;
        self.class.manager.sessionManager.securityPolicy.validatesDomainName = NO;
//        self.class.manager.sessionManager.session.configuration.TLSMaximumSupportedProtocol = kTLSProtocol1;
    }
}


- (AFHTTPSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                                     @"application/json",
                                                                     @"text/json",
                                                                     @"text/javascript",
                                                                     @"text/html",
                                                                     @"text/plain",
                                                                     @"image/jpeg",
                                                                     @"image/png",
                                                                     @"text/plain",
                                                                     nil];
        _sessionManager.requestSerializer.timeoutInterval = self.timeoutInterval;
    }
    
    return _sessionManager;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[[self class] allocWithZone:zone] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (void)dealloc {
    [_sessionManager invalidateSessionCancelingTasks:YES];
}


@end

@implementation HTTPUploadFileConfig

- (instancetype)initWithFormData:(NSData *)fileData
                            name:(NSString *)name
                        fileName:(NSString *)fileName
                        mimeType:(NSString *)mimeType {
    
    if (self = [super init]) {
        self.fileData = fileData;
        self.name = name;
        self.fileName = fileName;
        self.mimeType = mimeType;
    }
    return self;
}


- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end
