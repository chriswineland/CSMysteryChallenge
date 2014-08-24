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

//notification stings
static NSString* loadingIndicator = @"loadingNotificationName";
static NSString* fetchCompletedSuccesfuly = @"fetchCompletedSuccesfulyName";
static NSString* asyncImageReturned = @"asyncImageReturnedName";

//notification info keys
static NSString* imageKey = @"imageKey";
static NSString* indexPathKey = @"indexPathKey";

@interface AppContext : NSObject<ImageStoreDelegate>{
    ImageStore* imageStore;
    NSMutableArray* fullDataSet;
}

@property (nonatomic, strong)NSMutableArray* fullDataSet;
@property (nonatomic, strong)ImageStore* imageStore;

+ (id)singleton;
- (void)clearDataSet;
- (void)fetchAppData;

@end
