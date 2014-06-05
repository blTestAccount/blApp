//
//  AppTableViewController.m
//  BlStreamApp
//
//  Created by Admin on 05/06/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "AppTableViewController.h"
#import "DataModel.h"
#import "Downloader.h"
#import "AppViewCell.h"
#import "App.h"

#define kURLAddress @"https://itunes.apple.com/us/rss/toppaidapplications/limit=100/json"

@interface AppTableViewController () <DownloaderDelegate, UIScrollViewDelegate> {
    DataModel *_dataModel;
    Downloader *_downloader;
}
@end

@implementation AppTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _downloader = [[Downloader alloc] initWithDelegate:self]; 
    [_downloader downloadDataFrom:kURLAddress];
    _dataModel = [[DataModel alloc] init];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor blueColor];
    [refreshControl addTarget:self action:@selector(refreshFeed) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AppViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AppCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && self.view.window == nil) {
        [_downloader clean];
        [_downloader release];
        [_dataModel clean];
        [_dataModel release];
    }
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataModel.apps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppCell" forIndexPath:indexPath];
 
    
    App *app = _dataModel.apps[indexPath.row];
        
    cell.appNumber.text = app.appNumber; 
    cell.appName.text = app.appName;
        
    if (app.image == nil) {
        cell.appImage.image = nil;
        if (self.tableView.dragging == NO && self.tableView.decelerating == NO) {
            [_downloader downloadImageDataFrom:app.url dataHandler:^(NSData* data) {                    if (data!= nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        app.image = [UIImage imageWithData:data];
                        cell.appImage.image = app.image;
                    });
                }
            }];
        }
    }
    else {
            cell.appImage.image = app.image;
    }
    
    return cell;
}

- (void) refreshFeed {
    for (App *app in _dataModel.apps) {
        [app clear];
    }
    [self.tableView reloadData];
    [self performSelector:@selector(download) withObject:nil
               afterDelay:1];
}

- (void) download {
    [_dataModel.apps removeAllObjects];
    [_downloader downloadDataFrom:kURLAddress];
}

#pragma mark - Downloader Delegate
- (void)downloadCompletedWithData:(NSData *)data {
    if ([_dataModel parseData:data]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        });
    }
}

#pragma mark - Scroll View Delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.tableView reloadData];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.tableView reloadData];
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 70)];
    


    

    UILabel* headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(10, 15, tableView.frame.size.width - 10, 45);
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor blueColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:22.0];
    headerLabel.text = @"Top paid apps";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:headerLabel];

    return headerView;
}
@end
