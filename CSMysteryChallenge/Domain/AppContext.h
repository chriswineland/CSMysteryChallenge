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

@interface AppContext : NSObject{
    ImageStore* imageStore;
    CGRect unfilteredScrollViewVisibleRect;
    NSMutableArray* fullDataSet;
    NSMutableArray* unfilteredViewableDataSet;
    NSMutableArray* fullFilteredDataSet;
    NSMutableArray* filteredViewableDataSet;
    BOOL isLoading;
}

+ (id)singleton;
- (void)clearFilteredDataSets;
- (void)fetchAppData;

@end
