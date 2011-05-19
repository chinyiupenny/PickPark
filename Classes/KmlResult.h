//
//  KmlResult.h
//  AutoScout
//
//  Created by Chau Chin Yiu on 9/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "AddressComponent.h"

@interface KmlResult : NSObject {
	NSString *address;
	NSString *countryNameCode;
	NSString *countryName;
	NSString *subAdministrativeAreaName;
	NSString *localityName;
	NSString *zipcode;
	float viewportSouthWestLat;
	float viewportSouthWestLon;
	float viewportNorthEastLat;
	float viewportNorthEastLon;
	float boundsSouthWestLat;
	float boundsSouthWestLon;
	float boundsNorthEastLat;
	float boundsNorthEastLon;
	float latitude;
	float longitude;
	float height;
	NSInteger accuracy;
	NSArray *addressComponents;
}

@property (nonatomic, retain) NSString *address;
@property (nonatomic, assign) NSInteger accuracy;
@property (nonatomic, retain) NSString *countryNameCode;
@property (nonatomic, retain) NSString *countryName;
@property (nonatomic, retain) NSString *subAdministrativeAreaName;
@property (nonatomic, retain) NSString *localityName;
@property (nonatomic, retain) NSArray *addressComponents;
@property (nonatomic, retain) NSString *zipcode;
@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;


@property (nonatomic, assign) float viewportSouthWestLat;
@property (nonatomic, assign) float viewportSouthWestLon;
@property (nonatomic, assign) float viewportNorthEastLat;
@property (nonatomic, assign) float viewportNorthEastLon;
@property (nonatomic, assign) float boundsSouthWestLat;
@property (nonatomic, assign) float boundsSouthWestLon;
@property (nonatomic, assign) float boundsNorthEastLat;
@property (nonatomic, assign) float boundsNorthEastLon;



@property (readonly) CLLocationCoordinate2D coordinate;
@property (readonly) MKCoordinateSpan coordinateSpan;
@property (readonly) MKCoordinateRegion coordinateRegion;

-(NSArray*)findAddressComponent:(NSString*)typeName;

@end

