//
//  CSViewController.m
//  CSMysteryChallenge
//
//  Created by Gemma Barlow on 1/9/13.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "CSViewController.h"
#import "AppContext.h"
#import "TumblrPostCell.h"

@interface CSViewController ()

@end


@implementation CSViewController

#pragma mark - CSViewController Life Cycle Events

- (void)viewDidLoad {
	[super viewDidLoad];

    [self setScreenDementions];
    [self setUpApContextListeners];
    [[AppContext singleton]fetchAppData];
    
    
    contentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStyleGrouped];
    [contentTableView setBackgroundColor:[UIColor clearColor]];
    [contentTableView setBackgroundView:nil];
    [contentTableView setBounces:YES];
    [contentTableView setRowHeight:175.0f];
    [contentTableView setDelegate:self];
    [contentTableView setDataSource:self];
    [contentTableView registerNib:[UINib nibWithNibName:@"TumblrPostCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"TblerCellType"];
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setTintColor:[UIColor darkGrayColor]];
    [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    [contentTableView addSubview:refreshControl];
    
    [[self view]addSubview:contentTableView];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
    [[AppContext singleton]purgeAllEntries];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[AppContext singleton] fullDataSet]count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MyIdentifier = @"TblerCellType";
    TumblrPostCell* cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    [cell setCellValuesWithTumblrPost:[[[AppContext singleton] fullDataSet] objectAtIndex:indexPath.row] atIndexPath:indexPath];

    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [(TumblrPostCell*)[tableView cellForRowAtIndexPath:indexPath] laodNextImageForPostAtIndexPath:indexPath];
}

#pragma mark - Helper Methods

- (void)setScreenDementions{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenHeight = screenRect.size.height;
    screenWidth = screenRect.size.width;
}

- (void)refreshData{
    [[AppContext singleton]clearDataSet];
    [contentTableView reloadData];
    [[AppContext singleton]fetchAppData];
}



#pragma mark - AppContext Event Listeners

- (void)setUpApContextListeners{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchCompleted) name:fetchCompletedSuccesfuly object:[AppContext singleton]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(asyncImageFetchComplete:) name:asyncImageReturned object:[AppContext singleton]];
}



- (void)fetchCompleted{
    [contentTableView reloadData];
    [refreshControl endRefreshing];
}

- (void)asyncImageFetchComplete:(NSNotification*)notification{
    [(TumblrPostCell*)[contentTableView cellForRowAtIndexPath:[[notification userInfo] objectForKey:indexPathKey]] setCellItemImage:[[notification userInfo] objectForKey:imageKey]];
}

@end
