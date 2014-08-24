//
//  AppContext.m
//  CSMysteryChallenge
//
//  Created by Chris Wineland on 8/23/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "AppContext.h"
#import "TMAPIClient.h"

@implementation AppContext

- (id)init{
    if(self = [super init]){
        isLoading = NO;
        imageStore = [[ImageStore alloc]init];
        unfilteredScrollViewVisibleRect = CGRectZero;
        fullDataSet = [[NSMutableArray alloc]initWithCapacity:0];
        unfilteredViewableDataSet = [[NSMutableArray alloc]initWithCapacity:0];
        fullFilteredDataSet = [[NSMutableArray alloc]initWithCapacity:0];
        filteredViewableDataSet = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

+ (id)singleton{
    static AppContext *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

#pragma mark - fetch complete methods

- (void)fetchDidFailWithError:(NSError*)error{
    //show an error and let the user refetch if they like
}

- (void)fetchDidSucceedWithResult:(id)result{
    NSLog(@"Result returned from Tumblr API is: %@", result);
    NSArray* posts = [[NSArray alloc]initWithArray:[result objectForKey:@"posts"]];
    for(NSDictionary* dict in posts){
        [fullDataSet addObject:[self parseDictionaryToTumblrPost:dict]];
    }
}

#pragma mark - helper functions

- (void)clearAllDataSets{
    [fullDataSet removeAllObjects];
    [unfilteredViewableDataSet removeAllObjects];
    [self clearFilteredDataSets];
}

- (void)clearFilteredDataSets{
    [fullFilteredDataSet removeAllObjects];
    [filteredViewableDataSet removeAllObjects];
}

- (void)fetchAppData{
    if([fullDataSet count] > 0){
        [self clearAllDataSets];
    }
    [self setIsLoading:YES];
    [[TMAPIClient sharedInstance] posts:@"couchsurfing" type:nil parameters:nil callback: ^(id result, NSError *error) {
	    if(error){
            [self fetchDidFailWithError:error];
        } else {
            [self setIsLoading:NO];
            [self fetchDidSucceedWithResult:result];
        }
	}];
}

#pragma mark - parse tumbler post

- (TumblrPost*)parseDictionaryToTumblrPost:(NSDictionary*)dict{
    TumblrPost* newPost = [[TumblrPost alloc]init];
    
    [newPost setCaption:[self parseCaption:dict]];
    [newPost setDate:[self parseDate:dict]];
    [newPost setImageURL:[self parseImageURL:dict]];
    [newPost setFormattedHashTags:[self parseHashTags:dict]];
    
    return newPost;
}

- (NSString*)parseCaption:(NSDictionary*)dict{
    return [dict objectForKey:@"caption"];
}

- (NSString*)parseDate:(NSDictionary*)dict{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dict objectForKey:@"date"];
    dateStr = [dateStr substringToIndex:10];
    NSDate* date = [dateFormat dateFromString:dateStr];
    [dateFormat setDateFormat:@"MMMM d, YYYY"];
    dateStr = [dateFormat stringFromDate:date];
    return dateStr;
}

- (NSString*)parseHashTags:(NSDictionary*)dict{
    return Nil;
}

- (NSString*)parseImageURL:(NSDictionary*)dict{
    return Nil;
}

#pragma mark - Overridden Getters and Setters

- (void)setIsLoading:(BOOL)loading{
    if(isLoading == loading){
        //no change no action
        return;
    }
    isLoading = loading;
    [[NSNotificationCenter defaultCenter] postNotificationName:loadingIndicator object:self userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:loading] forKey:loadingIndicator]];
}

@end