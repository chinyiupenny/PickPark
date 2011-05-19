//
//  RadiusLayerView.h
//  AutoScout24_V2
//
//  Created by Patrick Lachat on 08/06/10.
//  Copyright 2010 http://www.AutoScout24.de. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "RadiusSelectionControllerDelegate.h"

@interface RadiusLayerView : UIView <MKMapViewDelegate, RadiusSelectionControllerDelegate> {
	MKMapView *_mapView;
	CLLocationCoordinate2D _center;
	int _radius;	
	bool _isAnimating;
}
@property (nonatomic) int _radius;
@property (nonatomic) CLLocationCoordinate2D _center;
- (id)initWithMapView:(MKMapView*)mapView mapViewDelegate:(id)mapViewDelegate;

@end
