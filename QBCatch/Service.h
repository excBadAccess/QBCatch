//
//  Service.h
//  QBCatch
//
//  Created by ello on 13-4-16.
//  Copyright (c) 2013年 ello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@protocol ReceiveDataDelegate <NSObject>
@optional
- (void)receiveData:(NSDictionary *)data;

@end

@interface Service : NSObject<ASIHTTPRequestDelegate>

@property (nonatomic, assign) id <ReceiveDataDelegate> receiveDelegate;
@property (nonatomic, retain) ASIHTTPRequest *request;

- (void)sendServiceRequest:(int)requestID;

@end
