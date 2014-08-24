//
//  ImageStore.m
//  CSMysteryChallenge
//
//  Created by Chris Wineland on 8/23/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "ImageStore.h"

@implementation ImageStore

@synthesize delegate;

- (id)init{
    if(self = [super init]){
        cachedImages = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (UIImage*)getImageFromURLString:(NSString*)urlString atIndexPath:(NSIndexPath*)indexPath{
    if([cachedImages valueForKey:urlString] != Nil){
        //horay its cached, lets return it
        return [cachedImages valueForKey:urlString];
    } else {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^(void) {
            NSURL *url = [NSURL URLWithString:urlString];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage* image = [[UIImage alloc] initWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                //tell the cell to try again, we now have it
                [cachedImages setObject:image forKey:urlString];
                [delegate imageWasFetched:image forIndexPath:indexPath];
            });
        });
        return [UIImage imageNamed:@"add_image_filled-128.png"];
    }
}

@end
