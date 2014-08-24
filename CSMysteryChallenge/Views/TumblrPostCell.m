//
//  TumblrPostCell.m
//  CSMysteryChallenge
//
//  Created by Chris Wineland on 8/23/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "TumblrPostCell.h"
#import "AppContext.h"

@implementation TumblrPostCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initializasion code
        displayedTumblrPost = [[TumblrPost alloc]init];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - helper functions

- (void)setCellValuesWithTumblrPost:(TumblrPost*)post atIndexPath:(NSIndexPath *)indexPath{
    displayedTumblrPost = post;
    [self setCaptionText:[post caption]];
    [[self cellItemHashTagLabel] setText:[self truncatedHashtagsFromFormattedHashtags:[post formattedHashTags]]];
    [[self cellItemDateLabel] setText:[post date]];
    [[self cellItemImageView]setImage:[[[AppContext singleton] imageStore] getImageFromURLString:[[post imageURLs] objectAtIndex:0] atIndexPath:indexPath]];
}

- (void)setCaptionText:(NSString*)htmlString{
    NSError *err = nil;
    [[self cellItemMessageLabel] setAttributedText:[[NSAttributedString alloc]initWithData:[htmlString dataUsingEncoding:NSUTF8StringEncoding]
                                                                                   options: @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType } 
                                                                        documentAttributes: nil 
                                                                                     error: &err]];
    if(err){
       [[self cellItemMessageLabel] setText:@"Error Reading HTML Formated Text"];
    }
}

- (NSString*)truncatedHashtagsFromFormattedHashtags:(NSString*)hashTags{
    int acceptableHashTagLength = 85;
    if([hashTags length] < acceptableHashTagLength){
        return hashTags;
    } else {
        //cut sting down to a displayable length
        NSString* returnString = [hashTags substringToIndex:acceptableHashTagLength];
        int droppedHashtagCount = [[[hashTags substringFromIndex:acceptableHashTagLength] componentsSeparatedByString:@"#"] count]+1;
        NSArray* displayedHashtagList = [[NSArray alloc]initWithArray:[returnString componentsSeparatedByString:@"#"]];
        
        
        returnString = @"";
        for(int i = 0; i < [displayedHashtagList count] - 1; i++){
            returnString = [returnString stringByAppendingString:@"#"];
            returnString = [returnString stringByAppendingString:[displayedHashtagList objectAtIndex:i]];
        }
        returnString = [returnString stringByAppendingString:@" "];
        if(droppedHashtagCount == 1){
             returnString = [returnString stringByAppendingString:[NSString stringWithFormat:@"And 1 other..."]];
        } else {
            returnString = [returnString stringByAppendingString:[NSString stringWithFormat:@"And %i others...",droppedHashtagCount]];
        }
        returnString = [returnString substringFromIndex:1];
        return returnString;
    }
}

@end
