//
//  CSViewController.m
//  CSMysteryChallenge
//
//  Created by Gemma Barlow on 1/9/13.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "CSViewController.h"
#import "TMAPIClient.h"


@interface CSViewController ()

@end


@implementation CSViewController

#pragma mark - CSViewController Life Cycle Events

- (void)viewDidLoad {
	[super viewDidLoad];
    
    [self setScreenDementions];
    
    contentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStyleGrouped];
    [contentTableView setBackgroundColor:[UIColor clearColor]];
    [contentTableView setBackgroundView:nil];
    [contentTableView setBounces:YES];
    [contentTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [contentTableView setDelegate:self];
    [contentTableView setDataSource:self];
    [contentTableView registerNib:[UINib nibWithNibName:@"TumblrPostCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"TblerCellType"];
    [[self view]addSubview:contentTableView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
	[[TMAPIClient sharedInstance] posts:@"couchsurfing" type:nil parameters:nil callback: ^(id result, NSError *error) {
	    NSLog(@"Result returned from Tumblr API is: %@", result);
	}];
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
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyIdentifier = @"TblerCellType";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MyIdentifier];
    }
    
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

@end
