//
//  TumblrPostCell.m
//  CSMysteryChallenge
//
//  Created by Chris Wineland on 8/23/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "TumblrPostCell.h"

@implementation TumblrPostCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initializasion code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - helper functions

- (void)setCellValuesWithTumblrPost:(TumblrPost*)post{
    [[self cellItemMessageLabel]setText:[post caption]];
    [[self cellItemHashTagLabel] setText:[self truncatedHashtagsFromFormattedHashtags:[post formattedHashTags]]];
    [[self cellItemDateLabel] setText:[post date]];
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

- (void)clearDisplayData{
    [[self cellItemMessageLabel]setText:@""];
    [[self cellItemImageView]setImage:[UIImage imageNamed:@""]];
}

@end
