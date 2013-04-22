//
//  HomeViewController.m
//  QBCatch
//
//  Created by ello on 13-4-16.
//  Copyright (c) 2013年 ello. All rights reserved.
//

#import "HomeViewController.h"
#import "common.h"
#import "Service.h"
@interface HomeViewController ()
<ReceiveDataDelegate>
@property (nonatomic, retain) Service *service;
@property (nonatomic, retain) NSMutableArray *detailControllers;
@property (nonatomic, retain) NSMutableArray *dataSource;
@end

@implementation HomeViewController

@synthesize service = _service;
@synthesize detailControllers = _detailControllers;
@synthesize dataSource = _dataSource;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _service = [[Service alloc] init];
    _service.receiveDelegate = self;
    [_service sendServiceRequest:GET_8H_HOT];
    
    self.title = @"糗事百科-8小时精华";
    _dataSource = [[NSMutableArray alloc] init];
   _detailControllers = [[NSMutableArray alloc] init];
}


- (void)receiveData:(NSDictionary *)data
{
    NSLog(@"receiveData");
    NSArray *items = [data valueForKey:@"items"];
    self.dataSource = [[[NSMutableArray alloc] initWithArray:items] autorelease];
    
//    NSString *content = [[data valueForKey:@"items"] valueForKey:@"content"];
//    DeleteMeController *deleteController = [[DeleteMeController alloc]
//                                            initWithStyle:UITableViewStylePlain];
//    deleteController.title = @"Delete Me";
//    deleteController.rowImage = [UIImage imageNamed:@"1.jpg"];
//    [_detailControllers addObject:deleteController];
}

- (void)dealloc
{
//    [_detailControllers release];
    self.detailControllers = nil;
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
    NSLog(@">>%u",_dataSource.count);
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
    static NSString *CellIdentifier = @"HomePageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *item = [_dataSource objectAtIndex:indexPath.row];
    NSString *text = [item valueForKey:@"content"];
    cell.textLabel.text = text;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
