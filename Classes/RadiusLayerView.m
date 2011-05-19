    //
//  RadiusLayerView.m
//  AutoScout
//
//  Created by Chau Chin Yiu on 8/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RadiusLayerView.h"


@implementation RadiusLayerView
@synthesize _radius,_center;

 

- (id)initWithMapView:(MKMapView*)mapView mapViewDelegate:(id)mapViewDelegate {
	if(self = [super initWithFrame:CGRectMake(0, 0, mapView.frame.size.width, mapView.frame.size.height)]) {
		_mapView = mapView;
		[self setBackgroundColor:[UIColor clearColor]];
		//[_mapView setDelegate:self];
		[_mapView setDelegate:mapViewDelegate];
		[_mapView addSubview:self];
		_radius = 50000;
		self.userInteractionEnabled = NO;
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetRGBFillColor(context, 255, 0, 0, 0.165);
	CGContextSetRGBStrokeColor(context, 255, 0, 0, 1);
	
	// Compute circle region based on center coordinate and radius in meters
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(_center, _radius * 2, _radius * 2);
	
	// Draw filled circle
	CGContextFillEllipseInRect(context, [_mapView convertRegion:region toRectToView:self]);
	
	// Draw circle border
	CGContextStrokeEllipseInRect(context, [_mapView convertRegion:region toRectToView:self]);
}

#pragma mark -
#pragma mark RadiusSelectionControllerDelegate Methods

-(void)radiusInMetetersDidChange:(NSInteger)meters center:(CLLocationCoordinate2D)center {
	_radius = meters;
	_center = center;
	[self setNeedsLayout];
	[self setNeedsDisplay];	
}


#pragma mark -
#pragma mark MapView delegate methods

-(void)mapView:(MKMapView *)aMapView regionWillChangeAnimated:(BOOL)animated {
	if(!_isAnimating) {
		_isAnimating = YES;
		[UIView beginAnimations:@"fade out" context:nil];
		[UIView setAnimationDuration:0.02];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		self.alpha = 0.0;
		[UIView commitAnimations];
		[self setNeedsLayout];
		[self setNeedsDisplay];
	}
}

-(void)mapView:(MKMapView *)aMapView regionDidChangeAnimated:(BOOL)animated {
	[UIView beginAnimations:@"fade in" context:nil];
	[UIView setAnimationDuration:0.02];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	self.alpha = 1.0;
	[UIView commitAnimations];
	_isAnimating = NO;
	[self setNeedsLayout];
	[self setNeedsDisplay];
}

- (void)dealloc {
    [super dealloc];
}


@end
