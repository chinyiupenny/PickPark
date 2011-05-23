//
//  LocAnnotation.m
//  AutoScout
//
//  Created by Chau Chin Yiu on 8/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LocAnnotation.h"


@implementation LocAnnotation
@synthesize coordinate;
@synthesize mTitle, mSubTitle;

- (CLLocationCoordinate2D)coordinate;
{

     return  coordinate; 
}

// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
- (NSString *)title
{
    return mTitle;
}

// optional
- (NSString *)subtitle
{
    return mSubTitle;
}

- (void)dealloc
{
    [super dealloc];
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	NSLog(@"I am in LocAnnotation %f,%f",c.latitude,c.longitude);
	return self;
}


@end
