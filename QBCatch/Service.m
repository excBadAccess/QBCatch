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
    NSURL *url = nil;
    switch (requestID) {
        case GET_8H_HOT:
        {
            url = [NSURL URLWithString:@"http://m2.qiushibaike.com/article/list/week?count=30&page=1"];
        }
            break;
        case GET_COMMENT:
        {
            int qbID = (int)param;
            NSString *urlStr = @"http://m2.qiushibaike.com/article/";
            NSString *qbIDStr = [[[NSString alloc] initWithFormat:@"%d",qbID] autorelease];
            urlStr = [urlStr stringByAppendingString:qbIDStr];
            urlStr = [urlStr stringByAppendingString:@"/comments?count=50&page=1"];
            url = [NSURL URLWithString:urlStr];
        }
            break;
        case GET_TRUTH:
        {
            url = [NSURL URLWithString:@"http://m2.qiushibaike.com/article/list/imgrank?count=30&page=1"];
        }
            break;
        case GET_TRAVELTIME:
        {
            NSString *urlStr = @"http://m2.qiushibaike.com/article/history/";
            NSDate *curDate = [NSDate date];//获取当前日期
            curDate = [NSDate dateWithTimeIntervalSince1970:[curDate timeIntervalSince1970]-365*24*3600];
            NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
            [formater setDateFormat:@"yyyy-MM-dd"];//这里去掉 具体时间 保留日期 
            NSString * curTime = [formater stringFromDate:curDate];
            urlStr = [urlStr stringByAppendingString:curTime];
            urlStr = [urlStr stringByAppendingString:@"?count=30&page=1"];
            url = [NSURL URLWithString:urlStr];
        }
            break;
        default:
            break;
    }
    [self sendRequest:url withRequestID:requestID];
}

- (void)sendRequest:(NSURL *)url withRequestID:(NSInteger)requestID
{
    self.request = [ASIHTTPRequest requestWithURL:url];
    _request.tag = requestID;
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
        case GET_TRAVELTIME:
        case GET_TRUTH:
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
    _request.delegate = nil;
    self.request = nil;
    [super dealloc];
}

@end
