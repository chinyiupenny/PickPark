//  ContactCell.m
//  AutoScout24
//  Created by BR 
//  Copyright 2009 AutoScout. All rights reserved.

#import "ContactCell.h"


@implementation ContactCell

@synthesize type, name, prompt, impressum, promptMode;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

		type = [[UILabel alloc] initWithFrame:CGRectZero];
        type.font = [UIFont boldSystemFontOfSize:12];
		type.textColor = [UIColor blackColor];
		type.highlightedTextColor = [UIColor whiteColor];
        type.textAlignment = UITextAlignmentLeft;
        type.backgroundColor = [UIColor clearColor];
		
        name = [[UILabel alloc] initWithFrame:CGRectZero];
        name.font = [UIFont systemFontOfSize:12];
		name.textColor = [UIColor blackColor];
		name.highlightedTextColor = [UIColor whiteColor];
        name.backgroundColor = [UIColor clearColor];
		name.textAlignment = UITextAlignmentLeft;
		
        prompt = [[UILabel alloc] initWithFrame:CGRectZero];
        prompt.font = [UIFont systemFontOfSize:12];
        prompt.textColor = [UIColor blackColor];
		prompt.highlightedTextColor = [UIColor whiteColor];
        prompt.backgroundColor = [UIColor clearColor];
		prompt.numberOfLines = 3;
		prompt.textAlignment = UITextAlignmentLeft;
        
		impressum = [[UILabel alloc] initWithFrame:CGRectZero];
        impressum.font = [UIFont systemFontOfSize:12];
        impressum.textColor = [UIColor blackColor];
		impressum.highlightedTextColor = [UIColor whiteColor];
        impressum.backgroundColor = [UIColor clearColor];
		impressum.textAlignment = UITextAlignmentLeft;
			
		[self.contentView addSubview:type];
        [self.contentView addSubview:name];
        [self.contentView addSubview:prompt];
		[self.contentView addSubview:impressum];
		
		self.autoresizesSubviews = YES;
    }
    return self;
}

- (void)dealloc {
    [type release];
    [name release];
    [prompt release];
	[impressum release];
    [super dealloc];
}

// Setting the prompt mode to YES hides the type/name labels and shows the prompt label.
- (void)setPromptMode:(BOOL)flag {
    if (flag) {
        type.hidden = YES;
        name.hidden = YES;
        prompt.hidden = NO;
    } else {
        type.hidden = NO;
        name.hidden = NO;
        prompt.hidden = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // Start with a rect that is inset from the content view by 10 pixels on all sides.
    CGRect baseRect = CGRectInset(self.contentView.bounds, 10, 10);
    CGRect rect = baseRect;
	
	rect.size.width = baseRect.size.width - 30;
	rect.size.height = 15;
    type.frame = rect;
    
	rect.origin.y += 15;
    rect.size.width = baseRect.size.width; //- 80;
    name.frame = rect;

    rect.origin.y += 5;
	rect.size.height = 50;
    // Position each label with a modified version of the base rect.
    prompt.frame = rect;
	
	
}

@end
