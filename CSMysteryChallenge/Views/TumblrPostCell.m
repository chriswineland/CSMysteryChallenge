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

- (void)clearDisplayData{
    [[self cellItemMessageLabel]setText:@""];
    [[self cellItemImageView]setImage:[UIImage imageNamed:@""]];
}

@end
