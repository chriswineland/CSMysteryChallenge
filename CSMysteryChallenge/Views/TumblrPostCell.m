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
        curDisplayedImageIndex = 0;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - helper functions

- (void)setCellItemImage:(UIImage *)image{
    [[self cellItemImageView]setImage:image];
}

- (void)setCellValuesWithTumblrPost:(TumblrPost*)post atIndexPath:(NSIndexPath *)indexPath{
    displayedTumblrPost = post;
    [[self cellItemMessageLabel]setText:[displayedTumblrPost caption]];
    [[self cellItemHashTagLabel] setText:[self truncatedHashtagsFromFormattedHashtags:[displayedTumblrPost formattedHashTags]]];
    [[self cellItemDateLabel] setText:[displayedTumblrPost date]];
    [[self cellItemImageView]setImage:[[[AppContext singleton] imageStore] getImageFromURLString:[[displayedTumblrPost imageURLs] objectAtIndex:0] atIndexPath:indexPath]];
}

//this function takes advantage of the fact i delineated the hashtags by "#" earlyer
//another option would have to just put them into an aray untill this point but I found myself
//woirried about length more then anything so a contatinated string worked
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

-(void)laodNextImageForPostAtIndexPath:(NSIndexPath*)indexPath{
    [self moveCounterToNextImage];
    //once we have moved the pointer go ahead an notify any one listening that a new image is ready for consumption 
    [self setImageToDisplayImageIndexForIndexPath:indexPath];
}

- (void)moveCounterToNextImage{
    //this creates a loop of avalible images
    if(curDisplayedImageIndex >= [[displayedTumblrPost imageURLs]count]-1){
        curDisplayedImageIndex = 0;
    } else {
        curDisplayedImageIndex++;
    }
}

- (void)setImageToDisplayImageIndexForIndexPath:(NSIndexPath*)indexPath{
    [[self cellItemImageView]setImage:[[[AppContext singleton] imageStore] getImageFromURLString:[[displayedTumblrPost imageURLs] objectAtIndex:curDisplayedImageIndex] atIndexPath:indexPath]];
}


@end