//
//  NSString+HTML.h
//  CSMysteryChallenge
//
//  Created by Chris Wineland on 8/24/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString_HTML)

- (NSString*)stringByStrippingHTML;
- (NSString*)stringByDecodingMarkup;

@end