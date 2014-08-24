//
//  ImageStore.h
//  CSMysteryChallenge
//
//  Created by Chris Wineland on 8/23/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageStoreDelegate;

@interface ImageStore : NSObject{
    id <ImageStoreDelegate> __weak delegate;
    NSMutableDictionary* cachedImages;
}

@property (nonatomic, weak)id <ImageStoreDelegate> delegate;

- (UIImage*)getImageFromURLString:(NSString*)urlString atIndexPath:(NSIndexPath*)indexPath;

@end

@protocol ImageStoreDelegate <NSObject>

-(void)imageWasFetched:(UIImage*)image forIndexPath:(NSIndexPath*)indexPath;

@end