//
//  AppContext.h
//  CSMysteryChallenge
//
//  Created by Chris Wineland on 8/23/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageStore.h"
#import "TumblrPost.h"

//pointer to constant nsstring
static NSString* loadingIndicator = @"loadingNotificationName";
static NSString* fetchCompletedSuccesfuly = @"FetchCompletedSuccesfulyName";

@interface AppContext : NSObject{
    ImageStore* imageStore;
    CGRect unfilteredScrollViewVisibleRect;
    NSMutableArray* fullDataSet;
    NSMutableArray* fullFilteredDataSet;
    BOOL isLoading;
}

@property (nonatomic, strong)NSMutableArray* fullDataSet;
@property (nonatomic, strong)NSMutableArray* fullFilteredDataSet;
@property (nonatomic, strong)ImageStore* imageStore;

+ (id)singleton;
- (void)clearFilteredDataSets;
- (void)fetchAppData;

@end
