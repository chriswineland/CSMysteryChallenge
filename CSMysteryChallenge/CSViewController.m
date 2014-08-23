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

- (void)viewDidLoad {
	[super viewDidLoad];
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

@end
