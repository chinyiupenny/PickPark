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


@interface PickParkMainVC : UIViewController <MKMapViewDelegate,ForwardGeocoderDelegate,CLLocationManagerDelegate,UISearchDisplayDelegate, UISearchBarDelegate>{
	MKMapView *_mapView;
	CLLocationCoordinate2D _center;
	ForwardGeocoder *_forwardGeocoder;
    LocAnnotation *_locAnnotation;
	UISearchBar *_searchBar;
	UISearchDisplayController *_searchController;
	
}
@property (nonatomic,retain) IBOutlet MKMapView *mapView;
@property (nonatomic,retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic,retain) IBOutlet UISearchDisplayController *searchController;

-(IBAction) clickParkButton:(id)sender;
-(IBAction) clickPickButton:(id)sender;
@end
