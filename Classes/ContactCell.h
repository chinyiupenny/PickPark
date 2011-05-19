//  ContactCell.h
//  AutoScout24
//  Created by BR 
//  Copyright 2009 AutoScout. All rights reserved.

#import <UIKit/UIKit.h>


@interface ContactCell : UITableViewCell {
    UILabel *type;
    UILabel *name;
    UILabel *prompt;
	UILabel *impressum;
    BOOL promptMode;
}

@property (readonly, retain) UILabel *type;
@property (readonly, retain) UILabel *name;
@property (readonly, retain) UILabel *prompt;
@property (readonly, retain) UILabel *impressum;
@property BOOL promptMode;

@end
