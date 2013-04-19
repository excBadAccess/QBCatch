//
//  HomeViewController.h
//  QBCatch
//
//  Created by ello on 13-4-16.
//  Copyright (c) 2013年 ello. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"

@interface HomeViewController : UITableViewController<ReceiveDataDelegate>

@property (nonatomic, retain) Service *service;

@end