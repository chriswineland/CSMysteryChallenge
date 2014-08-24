//
//  TumblrPostCell.h
//  CSMysteryChallenge
//
//  Created by Chris Wineland on 8/23/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TumblrPost.h"

@interface TumblrPostCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *cellItemMessageLabel;
@property (nonatomic, strong) IBOutlet UIImageView *cellItemImageView;
@property (nonatomic, strong) IBOutlet UILabel *cellItemHashTagLabel;
@property (nonatomic, strong) IBOutlet UILabel *cellItemDateLabel;

- (void)clearDisplayData;
- (void)setCellValuesWithTumblrPost:(TumblrPost*)post;

@end
