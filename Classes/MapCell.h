//
//  MapCell.h
//  AutoScout
//
//  Created by Chau Chin Yiu on 8/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "LocAnnotation.h"

@interface MapCell : UITableViewCell<MKMapViewDelegate> {
	MKMapView *mapView;   
	LocAnnotation *locAnnotation;
}
@property(nonatomic, retain) MKMapView *mapView;
@property(nonatomic, retain) LocAnnotation *locAnnotation; 
@end
