//
//  CSViewController.m
//  CSMysteryChallenge
//
//  Created by Gemma Barlow on 1/9/13.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "CSViewController.h"
#import "AppContext.h"


@interface CSViewController ()

@end


@implementation CSViewController

#pragma mark - CSViewController Life Cycle Events

- (void)viewDidLoad {
	[super viewDidLoad];

    [self setUpApContextListeners];
    [[AppContext singleton]fetchAppData];
    [self setScreenDementions];
    
    contentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStyleGrouped];
    [contentTableView setBackgroundColor:[UIColor clearColor]];
    [contentTableView setBackgroundView:nil];
    [contentTableView setBounces:YES];
    [contentTableView setRowHeight:150.0f];
    [contentTableView setDelegate:self];
    [contentTableView setDataSource:self];
    [contentTableView registerNib:[UINib nibWithNibName:@"TumblrPostCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"TblerCellType"];
    [[self view]addSubview:contentTableView];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
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
    [cell setCellValuesWithTumblrPost:[[[AppContext singleton] fullDataSet] objectAtIndex:indexPath.row]];

    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Helper Methods

- (void)setScreenDementions{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenHeight = screenRect.size.height;
    screenWidth = screenRect.size.width;
}


- (void)showLoading{
    
}

- (void)hideLoading{
    
}

#pragma mark - AppContext Event Listeners

- (void)setUpApContextListeners{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleLoading:) name:loadingIndicator object:[AppContext singleton]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchCompleted) name:fetchCompletedSuccesfuly object:[AppContext singleton]];
}

- (void)toggleLoading:(NSNotification*)notification{
    if([(NSNumber*)[[notification userInfo]objectForKey:loadingIndicator] boolValue]){
        [self showLoading];
    } else {
        [self hideLoading];
    }
}

- (void)fetchCompleted{
    [contentTableView reloadData];
}

@end
