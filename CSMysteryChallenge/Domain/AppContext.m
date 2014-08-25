//
//  AppContext.m
//  CSMysteryChallenge
//
//  Created by Chris Wineland on 8/23/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "AppContext.h"
#import "TMAPIClient.h"
#import "NSString+HTML.h"
#import "TumblrPostCell.h"
#import "TumblrPost.h"

@implementation AppContext

@synthesize fullDataSet, imageStore;

- (id)init{
    if(self = [super init]){
        imageStore = [[ImageStore alloc]init];
        [imageStore setDelegate:self];
        fullDataSet = [[NSMutableArray alloc]initWithCapacity:0];
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fetch Failed" 
                                                    message:@"Failure to fetch data from Tumblr API" 
                                                   delegate:self 
                                          cancelButtonTitle:@"Refetch" 
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)fetchDidSucceedWithResult:(id)result{
    NSLog(@"Result returned from Tumblr API is: %@", result);
    NSArray* posts = [[NSArray alloc]initWithArray:[result objectForKey:@"posts"]];
    for(NSDictionary* dict in posts){
        [fullDataSet addObject:[self parseDictionaryToTumblrPost:dict]];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:fetchCompletedSuccesfuly object:self userInfo:Nil];
}

#pragma mark - helper functions

- (void)clearDataSet{
    [fullDataSet removeAllObjects];
}


- (void)fetchAppData{
    //purge existing data before refetching
    if([fullDataSet count] > 0){
        [self clearDataSet];
    }
    [[TMAPIClient sharedInstance] posts:@"couchsurfing" type:nil parameters:nil callback: ^(id result, NSError *error) {
	    if(error){
            [self fetchDidFailWithError:error];
        } else {
            [self fetchDidSucceedWithResult:result];
        }
	}];
}

- (void)purgeImageStore{
    [imageStore purgeAllEntries];
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
    //remove html and markup from the string in the domain layer so 
    return [[[dict objectForKey:@"caption"] stringByStrippingHTML] stringByDecodingMarkup];
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
    //this function used the # as a delimiter between the actual "#s"
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
    //dementions of the image displayed
    const CGFloat tumblrPostImageWidth = 105;
    const CGFloat tumblrPostImageHeight = 70;
    if([options count] == 0){
        //bail out, no actual options to choose from
        return bestFitImage;
    }
    for(NSDictionary* image in options){
        //this takes advantage and assumes that the images are passed to me largest to smallest, 
        //if this assumption is incorrec this will need to be refactored
        if([[image objectForKey:@"height"]integerValue] > tumblrPostImageHeight && [[image objectForKey:@"width"] integerValue] > tumblrPostImageWidth){
            bestFitImage = [image objectForKey:@"url"];
        }
    }

    return bestFitImage;
}

#pragma mark - ImageStoreDelegate methods

- (void)imageWasFetched:(UIImage *)image forIndexPath:(NSIndexPath *)indexPath{
    [[NSNotificationCenter defaultCenter] postNotificationName:asyncImageReturned object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:image, imageKey, indexPath, indexPathKey, nil]];
}

#pragma mark - alertView Delegate methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 0) {
        [[AppContext singleton]fetchAppData];
    }
}

@end