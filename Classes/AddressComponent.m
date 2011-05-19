//
//  AddressComponent.m
//  AutoScout
//
//  Created by Chau Chin Yiu on 9/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import "AddressComponent.h"


@implementation AddressComponent
@synthesize shortName, longName, types;


-(void)dealloc
{
	[shortName release];
	[longName release];
	[types release];
	[super dealloc];
}
@end
