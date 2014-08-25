//
//  NSString+HTML.m
//  CSMysteryChallenge
//
//  Created by Chris Wineland on 8/24/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "NSString+HTML.h"

@implementation NSString (HTML)

- (NSString*)stringByStrippingHTML{
    
    NSRange range;
    NSString* replaceString = [self copy];
    
    while ((range = [replaceString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        replaceString = [replaceString stringByReplacingCharactersInRange:range withString:@""];
    
    return replaceString;
}

- (NSString*)stringByDecodingMarkup{
    NSMutableString* replaceString = [self mutableCopy];
    //xml markup
    [replaceString replaceOccurrencesOfString:@"&amp;" withString:@"&" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&quot;" withString:@"\"" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&#x27;" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&#x39;" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&#x92;" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&#x96;" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&gt;" withString:@">" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&lt;" withString:@"<" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    
    //html markup
    [replaceString replaceOccurrencesOfString:@"&#8211;" withString:@"–" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&#8212;" withString:@"—" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&#8216;" withString:@"‘" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&#8217;" withString:@"’" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&#8218;" withString:@"‚" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&#8220;" withString:@"“" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&#8221;" withString:@"”" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&#8222;" withString:@"„" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&#8224;" withString:@"†" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&#8225;" withString:@"‡" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&#8226;" withString:@"•" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&#8230;" withString:@"…" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&#8240;" withString:@"‰" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&#8364;" withString:@"€" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&#8482;" withString:@"™" options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    [replaceString replaceOccurrencesOfString:@"&#160;" withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [replaceString length])];
    
    return replaceString;
}

@end