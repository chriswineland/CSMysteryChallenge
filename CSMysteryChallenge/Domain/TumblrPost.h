//
//  TumblrPost.h
//  CSMysteryChallenge
//
//  Created by Chris Wineland on 8/23/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TumblrPost : NSObject{
    NSString* caption;
    NSArray* imageURLs;
    NSString* formattedHashTags;
    NSString* date;
}

@property (nonatomic, strong)NSString* caption;
@property (nonatomic, strong)NSArray* imageURLs;
@property (nonatomic, strong)NSString* formattedHashTags;
@property (nonatomic, strong)NSString* date;

@end
