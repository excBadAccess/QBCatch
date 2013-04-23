//
//  HomeViewController.m
//  QBCatch
//
//  Created by ello on 13-4-16.
//  Copyright (c) 2013年 ello. All rights reserved.
//

#import "ListViewController.h"
#import "common.h"
#import "Service.h"
#import "DetailViewController.h"
@interface ListViewController ()
<ReceiveDataDelegate>
@property (nonatomic, retain) Service *service;
@property (nonatomic, retain) DetailViewController *detailController;
@property (nonatomic, retain) NSMutableDictionary *dataSource;
@property (nonatomic, assign) NSInteger serviceID;
@end

@implementation ListViewController

@synthesize service = _service;
@synthesize detailController = _detailController;
@synthesize dataSource = _dataSource;
@synthesize serviceID = _serviceID;

- (id)initWithServiceID:(NSInteger)serviceID
{
    self = [super init];
    if (self) {
        // Custom initialization
        _serviceID = serviceID;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self startService:_serviceID setDelegate:self setParam:nil];
    _detailController = [[DetailViewController alloc] init];
}

- (void)startService:(int)serviceID setDelegate:(id)delegate setParam:(id)param
{
    _service = [[Service alloc] init];
    _service.receiveDelegate = delegate;
    [_service sendServiceRequest:serviceID setParam:param];
}

- (void)receiveData:(id)data serviceID:(int)ID
{
//    NSLog(@"receiveData");
//    self.service = nil;
    if (ID == _serviceID) {
        self.dataSource = [[[NSMutableDictionary alloc] initWithDictionary:data] autorelease];
        [self.tableView reloadData];
    }
}

- (void)dealloc
{
    self.detailController = nil;
    _service = nil;
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (_dataSource != nil) {
        NSArray *items = [_dataSource valueForKey:@"items"];
        return items.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (_dataSource != nil) {
        NSArray *items = [_dataSource valueForKey:@"items"];
        NSDictionary *item = [items objectAtIndex:indexPath.row];
        NSString *text = [item valueForKey:@"content"];
        UIFont *font = [UIFont systemFontOfSize:17.0];
        CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(
                        [[UIScreen mainScreen] bounds].size.width, 1000) lineBreakMode:UILineBreakModeWordWrap];
        return size.height+50; // 10即消息上下的空间，可自由调整
    }
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%@",indexPath);
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if (_dataSource != nil) {
        NSArray *items = [_dataSource valueForKey:@"items"];
        NSDictionary *item = [items objectAtIndex:indexPath.row];
        NSString *text = [item valueForKey:@"content"];
        cell.textLabel.text = text;
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:17.0];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    NSArray *items = [_dataSource valueForKey:@"items"];
    NSDictionary *item = [items objectAtIndex:indexPath.row];
    DetailViewController *detailViewController = [[DetailViewController alloc]
                                                  initWithStyle:UITableViewStylePlain
                                                  withQbID:[[item valueForKey:@"id"] intValue]];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

@end
