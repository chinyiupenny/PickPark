//
//  PickParkMainVC.h
//  PickPark
//
//  Created by Chau Chin Yiu on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ForwardGeocoder.h"
#import "LocAnnotation.h"


@interface PickParkMainVC : UIViewController <MKMapViewDelegate,ForwardGeocoderDelegate,CLLocationManagerDelegate>{
	MKMapView *_mapView;
	CLLocationCoordinate2D _center;
	ForwardGeocoder *_forwardGeocoder;
    LocAnnotation *_locAnnotation;
	
}
@property (nonatomic,assign) IBOutlet MKMapView *mapView;
-(IBAction) clickParkButton:(id)sender;
-(IBAction) clickPickButton:(id)sender;
@end
