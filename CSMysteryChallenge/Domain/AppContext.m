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
        fullFilteredDataSet = [[NSMutableArray alloc]initWithCapacity:0];
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
    [self clearFilteredDataSets];
}

- (void)clearFilteredDataSets{
    [fullFilteredDataSet removeAllObjects];
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
    [newPost setImageURLs:[self parseImageURLs:dict]];
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
    NSString* formattedHashTags = @"";
    for(NSString* tag in [dict objectForKey:@"tags"]){
        formattedHashTags = [formattedHashTags stringByAppendingString:@"#"];
        formattedHashTags = [formattedHashTags stringByAppendingString:tag];
        formattedHashTags = [formattedHashTags stringByAppendingString:@" "];
    }
    //remove the last @" "
    formattedHashTags = [formattedHashTags substringToIndex:[formattedHashTags length]-1];
    return formattedHashTags;
}

- (NSArray*)parseImageURLs:(NSDictionary*)dict{
    NSMutableArray* imageURLs = [[NSMutableArray alloc]initWithCapacity:0];
    NSArray* allPhotos = [[NSArray alloc]initWithArray:[dict objectForKey:@"photos"]];
    for(NSDictionary* imageOptions in allPhotos){
        [imageURLs addObject:[self getBestFitImageFromOptions:[imageOptions objectForKey:@"alt_sizes"]]];
    }
    return imageURLs;
}

- (NSString*)getBestFitImageFromOptions:(NSArray*)options{
    NSString* bestFitImage = @"";
    if([options count] == 0){
        //bail out, no actual options to choose from
        return bestFitImage;
    }
    //70x105 is the display size
    int height = 70;
    int width = 105;
    for(NSDictionary* image in options){
        //this takes advantage and assumes that the images are passed to me largest to smallest, 
        //if this assumption is incorrec this will need to be refactored
        if([[image objectForKey:@"height"]integerValue] > height && [[image objectForKey:@"width"] integerValue] > width){
            bestFitImage = [image objectForKey:@"url"];
        }
    }

    return bestFitImage;
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