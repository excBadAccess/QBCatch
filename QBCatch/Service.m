//
//  Service.m
//  QBCatch
//
//  Created by ello on 13-4-16.
//  Copyright (c) 2013年 ello. All rights reserved.
//

#import "Service.h"
#import "common.h"
@implementation Service

@synthesize receiveDelegate = _receiveDelegate;
@synthesize request = _request;

- (void)sendServiceRequest:(int)requestID setParam:(id)param
{
    switch (requestID) {
        case GET_8H_HOT:
        {
            [self send8HotRequest];
            break;
        }
        case GET_COMMENT:
        {
            int qbID = (int)param;
            [self sendCommentRequest:qbID];
        }
        default:
            break;
    }
    
}

//获取8小时热门列表
- (void)send8HotRequest
{
    NSURL *url = [NSURL URLWithString:@"http://m2.qiushibaike.com/article/list/week?count=30&page=1"];
    _request = [ASIHTTPRequest requestWithURL:url];
    _request.tag = GET_8H_HOT;
    [_request setDelegate:self];
    [_request startAsynchronous];
}

- (void)sendCommentRequest:(int)qbID
{
    NSString *urlStr = @"http://m2.qiushibaike.com/article/";
    NSString *qbIDStr = [[[NSString alloc] initWithFormat:@"%d",qbID] autorelease];
    urlStr = [urlStr stringByAppendingString:qbIDStr];
    urlStr = [urlStr stringByAppendingString:@"/comments?count=50&page=1"];
    NSURL *url = [NSURL URLWithString:urlStr];
    _request = [ASIHTTPRequest requestWithURL:url];
    _request.tag = GET_COMMENT;
    [_request setDelegate:self];
    [_request startAsynchronous];
}

- (void)parseJasonData:(ASIHTTPRequest *)request
{
    NSData *responseData = request.responseData;
    
    NSDictionary *parserDic = nil;
    parserDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    if (parserDic == nil || ![parserDic isKindOfClass:[NSDictionary class]]) {//Json解析失败或结果非字典
        NSLog(@"json error");
        return;
    }
    [_receiveDelegate receiveData:parserDic serviceID:request.tag];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
//    NSLog(@"requestFinished");
//    NSLog(@"responseHeaders:%@",request.responseHeaders);
//    NSLog(@"responseData:%@",request.responseData);
    switch (request.tag) {
        case GET_8H_HOT:
        case GET_COMMENT:
        {
            [self parseJasonData:request];
        }
            break;
        default:
            break;
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"requestFailed");
}

- (void)dealloc
{
    self.request = nil;
    [super dealloc];
}

@end
