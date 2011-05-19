//
//  LocAnnotation.h
//  AutoScout
//
//  Created by Chau Chin Yiu on 8/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import <MapKit/MapKit.h>


@interface LocAnnotation : NSObject<MKAnnotation> {

	CLLocationCoordinate2D coordinate;
	NSString *mTitle;
	NSString *mSubTitle;
}

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) NSString *mTitle;
@property (nonatomic,retain) NSString *mSubTitle;

@end
