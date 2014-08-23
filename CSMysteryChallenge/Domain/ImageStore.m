//
//  ImageStore.m
//  CSMysteryChallenge
//
//  Created by Chris Wineland on 8/23/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "ImageStore.h"

@implementation ImageStore

- (id)init{
    if(self = [super init]){
        
    }
    return self;
}

+ (id)singleton{
    static ImageStore *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

@end
