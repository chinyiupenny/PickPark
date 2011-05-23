//
//  PickParkMainVC.m
//  PickPark
//
//  Created by Chau Chin Yiu on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PickParkMainVC.h"
@interface PickParkMainVC()
-(void) convertCoordinate2Address: (CLLocationCoordinate2D) location;
-(void) convertAddress2Coordinate:(NSString *) address;
-(void) setRegionOnMap:(CLLocationCoordinate2D ) centerpoint;
-(void)applySearchRadiusSettings;
@end


@implementation PickParkMainVC
@synthesize mapView=_mapView , searchBar = _searchBar , searchController = _searchController;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(IBAction) clickParkButton:(id)sender{

#if TARGET_IPHONE_SIMULATOR
	//*********For Simulation of Localization ****************  	
	CLLocation *location = [[[CLLocation alloc] initWithLatitude:50.51 longitude:4.21] autorelease];
#else
	CLLocationManager *locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
	locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
	[locationManager startUpdatingLocation];
	CLLocation *location =[locationManager location];
	[locationManager release];
#endif
    [self convertCoordinate2Address:location.coordinate];
	//_center= location.coordinate;
//	[self setRegionOnMap:_center];
}


-(IBAction) clickPickButton:(id)sender{
	
}
/***
 *  convert coordinate to zip code and country name
 **/
-(void) convertCoordinate2Address: (CLLocationCoordinate2D) location{
	
	
	if(_forwardGeocoder == nil)
	{
		_forwardGeocoder = [[ForwardGeocoder alloc] initWithDelegate:self];
	}
	
	NSString *searchquery =[NSString stringWithFormat:@"%f,%f",location.latitude,location.longitude];
	
	// Forward degeocode!
	[_forwardGeocoder findLocation:searchquery isDeGeoCode:YES];

}


/****
 * Convert address to coordinate
 ***/
-(void) convertAddress2Coordinate:(NSString *) address{
	if(_forwardGeocoder == nil)
	{
		_forwardGeocoder = [[ForwardGeocoder alloc] initWithDelegate:self];
	}
	NSString *searchquery =[NSString stringWithFormat:@"%@",address];	
	// Forward degeocode!
	[_forwardGeocoder findLocation:searchquery isDeGeoCode:NO];
}

-(void) setRegionOnMap:(CLLocationCoordinate2D ) centerpoint{
	
//	if(_locAnnotation !=nil){
//		[_mapView removeAnnotation:_locAnnotation];
//	}
	_center = centerpoint;
	_locAnnotation = [[LocAnnotation alloc] init];
	_locAnnotation.coordinate =	centerpoint;
	[_mapView addAnnotation:_locAnnotation];	
	[self applySearchRadiusSettings];
	
}



-(void)applySearchRadiusSettings {
	
	// save current ui state
	int radius= 1000;
	MKCoordinateRegion region;
	region = MKCoordinateRegionMakeWithDistance(_center, radius *15, radius * 15);
		
	if((_mapView != nil)) {
		
        [_mapView setRegion:region animated:NO];
		[_mapView setNeedsDisplay];
		//[_delegate radiusInMetetersDidChange:_radiusSlider.value * 1000 center:_center];
	} 
	
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
	static NSString* LocAnnotationIdentifier = @"currentAnnotationIdentifier";
	MKPinAnnotationView* pinView = (MKPinAnnotationView *)
	[_mapView dequeueReusableAnnotationViewWithIdentifier:LocAnnotationIdentifier];
	if (!pinView)
	{
		// if an existing pin view was not available, create one
		MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
											   initWithAnnotation:annotation reuseIdentifier:LocAnnotationIdentifier] autorelease];
		customPinView.pinColor = MKPinAnnotationColorPurple;
		customPinView.animatesDrop = YES;
		customPinView.canShowCallout = YES;
		
		// add a detail disclosure button to the callout which will open a new view controller page
		//
		// note: you can assign a specific call out accessory view, or as MKMapViewDelegate you can implement:
		//  - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
		
		UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		[rightButton addTarget:self action:@selector(showDetails)
			  forControlEvents:UIControlEventTouchUpInside];
		customPinView.rightCalloutAccessoryView = rightButton;
		
		return customPinView;
	}
	return nil;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void) forwardGeocoderFoundLocation{
	NSLog(@"found location:::: %@ , %@ ",_forwardGeocoder.zipCode, _forwardGeocoder.country );
	_center= _forwardGeocoder.coordinate;
	[self setRegionOnMap:_center];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)thesearchBar{
	[_searchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)thesearchBar{
	NSString *addresstring =[_searchBar text];
	addresstring=[addresstring stringByReplacingOccurrencesOfString:@" " withString:@"+"];
	addresstring=[addresstring stringByReplacingOccurrencesOfString:@"," withString:@"+"];
	[self convertAddress2Coordinate:addresstring];
}

- (void)dealloc {
    [super dealloc];
}


@end
