//
//  ForwardGeocoder.h
//  AutoScout
//
//  Created by Chau Chin Yiu on 9/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "GoogleV3KmlParser.h"


// Enum for geocoding status responses
enum {
	G_GEO_SUCCESS = 200,
	G_GEO_BAD_REQUEST = 400,
	G_GEO_SERVER_ERROR = 500,
	G_GEO_MISSING_QUERY = 601,
	G_GEO_UNKNOWN_ADDRESS = 602,
	G_GEO_UNAVAILABLE_ADDRESS = 603,
	G_GEO_UNKNOWN_DIRECTIONS = 604,
	G_GEO_BAD_KEY = 610,
	G_GEO_TOO_MANY_QUERIES = 620	
};

@protocol ForwardGeocoderDelegate<NSObject>
@required
-(void)forwardGeocoderFoundLocation;
@optional
-(void)forwardGeocoderError:(NSString *)errorMessage;
@end

@interface ForwardGeocoder : NSObject {
	NSString *searchQuery;
	NSString *googleAPiKey;
	int status;
	NSArray *results;
	CLLocationCoordinate2D coordinate; 
	NSString *zipCode;
	NSString *country; 
	NSString *countryID;
	id delegate;
}
-(id) initWithDelegate:(id<ForwardGeocoderDelegate, NSObject>)del;
-(void) findLocation:(NSString *)searchString isDeGeoCode:(BOOL)isdegeo;

@property (assign) id delegate;
@property (nonatomic, retain) NSString *searchQuery;
@property (nonatomic, readonly) int status;
@property (nonatomic, retain) NSArray *results;
@property CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) NSString *zipCode;
@property (nonatomic,retain) NSString *country;
@property (nonatomic,retain) NSString *countryID;
@end
