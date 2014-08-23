//
//  CSViewController.h
//  CSMysteryChallenge
//
//  Created by Gemma Barlow on 1/9/13.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TumblrPostCell.h"

@interface CSViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    CGFloat screenWidth;
    CGFloat screenHeight;
    UITableView* contentTableView;
}

@end
