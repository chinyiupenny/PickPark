//
//  MapCell.m
//  AutoScout
//
//  Created by Chau Chin Yiu on 8/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapCell.h"
#import "QuartzCore/QuartzCore.h"

@implementation MapCell
@synthesize mapView,locAnnotation;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		
		
		mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0,0,300,200)]; 
	    mapView.mapType = MKMapTypeStandard;
		[mapView.layer setMasksToBounds:YES];
		[mapView.layer setCornerRadius:10];		
		[self.contentView addSubview:mapView];
		self.autoresizesSubviews = YES;
    }
    return self;
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
    MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
    annView.pinColor = MKPinAnnotationColorGreen;
    annView.animatesDrop=FALSE;
    annView.canShowCallout = YES;
    annView.calloutOffset = CGPointMake(-5, 5);
    return [annView autorelease];
 
}

- (void)dealloc
{
	mapView.delegate = nil;
	[mapView release];
	
	[super dealloc];
}

@end
