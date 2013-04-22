//
//  DetailViewController.m
//  QBCatch
//
//  Created by ello on 4/21/13.
//  Copyright (c) 2013 ello. All rights reserved.
//

#import "DetailViewController.h"
#import "common.h"
#import "Service.h"
@interface DetailViewController ()
<ReceiveDataDelegate>
@property (nonatomic, retain) Service *service;
@property (nonatomic, retain) NSMutableDictionary *dataSource;
@property (nonatomic, assign) NSInteger qbID;
@end

@implementation DetailViewController

@synthesize service = _service;
@synthesize dataSource = _dataSource;
@synthesize qbID = _qbID;

- (id)initWithStyle:(UITableViewStyle)style withQbID:(NSInteger)qbID
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _qbID = qbID;
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
    [self startService:GET_COMMENT setDelegate:self setParam:(id)_qbID];
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
    if (ID == GET_COMMENT) {
        self.dataSource = [[[NSMutableDictionary alloc] initWithDictionary:data] autorelease];
        [self.tableView reloadData];
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CommentCell";
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
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
