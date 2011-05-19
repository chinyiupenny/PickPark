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

-(void) setRegionOnMap:(CLLocationCoordinate2D ) centerpoint;
-(void)applySearchRadiusSettings;
@end


@implementation PickParkMainVC
@synthesize mapView=_mapView;
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
	[self showLocationOnMap];	
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


//- (void)showLocationOnMap{
//	
//	NSString *zipcode = _zipcodeTxtField.text;
//	
//	if( _geoService )
//	{
//		[_geoService cancelRequest];
//		[_geoService release];
//	}
//	
//	_geoService = [[SCMobileHubResource alloc] initWithServiceName:@"geo" version:@"1.0"];
//	XMOption *countryOption=[[_countryParameter selectedOptions] anyObject];
//	
//	if([zipcode length]>0){
//		_geoService.urlParameters =[NSString stringWithFormat:@"countryId=%@&zip=%@",countryOption.value,zipcode];  
//		
//	}else  {
//		_geoService.urlParameters =[NSString stringWithFormat:@"countryId=%@",countryOption.value];  
//		
//	}
//	
//	NSLog(@"URLParameter ::::::: %@",_geoService.urlParameters);
//	_geoService.delegate = self;
//	[_geoService get];
//	
//	[_zipcodeTxtField resignFirstResponder];
//}

-(void) setRegionOnMap:(CLLocationCoordinate2D ) centerpoint{
	
	if(_locAnnotation !=nil){
		[_mapView removeAnnotation:_locAnnotation];
	}
	_center = centerpoint;

	_locAnnotation = [[LocAnnotation alloc] init];
	_locAnnotation.coordinate =	centerpoint;
	[_mapView addAnnotation:_locAnnotation];

	
	
	[self applySearchRadiusSettings];
	
}

-(void)applySearchRadiusSettings {
	
	// save current ui state
	int radius= 1000 * 300;
	MKCoordinateRegion region;
	region = MKCoordinateRegionMakeWithDistance(_center, radius * 2, radius * 2);
	
	
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
	NSLog(@"found location!!!!!!!!!!");
}



- (void)dealloc {
    [super dealloc];
}


@end
