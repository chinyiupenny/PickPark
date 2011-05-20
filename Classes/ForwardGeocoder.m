//
//  ForwardGeocoder.m
//  AutoScout
//
//  Created by Chau Chin Yiu on 9/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ForwardGeocoder.h"

#import "StringUtility.h"

@interface ForwardGeocoder()
 

-(void)startGeocoding ;
-(void)startDeGeocoding;


@end

@implementation ForwardGeocoder

@synthesize searchQuery, status, results, delegate,coordinate, zipCode , country , countryID;

-(id) initWithDelegate:(id<ForwardGeocoderDelegate>)del
{
	self = [super init];
	
	if (self != nil) {
		delegate = del;
	}
	return self;
}

-(void) findLocation:(NSString *)searchString isDeGeoCode:(BOOL)isdegeo
{
	// store the query
	self.searchQuery = searchString;
	
	//[self performSelectorInBackground:@selector(startGeocoding) withObject:nil];
	if (isdegeo) {
		[self startDeGeocoding];
	}else {
		[self startGeocoding];
	
	}

}


-(void) startDeGeocoding{

	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	
	NSError *parseError = nil;
	
	
	// Create the url to Googles geocoding API, we want the response to be in XML
	NSString* mapsUrl = [[NSString alloc] initWithFormat:@"http://maps.google.com/maps/api/geocode/xml?latlng=%@&sensor=false", 
						 searchQuery];
	
	// Create the url object for our request. It's important to escape the 
	// search string to support spaces and international characters
	NSURL *url = [[NSURL alloc] initWithString:[mapsUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	// Run the KML parser
	GoogleV3KmlParser *parser = [[GoogleV3KmlParser alloc] init];
	
	[parser parseXMLFileAtURL:url parseError:&parseError ignoreAddressComponents:NO];
	
	[url release];
	[mapsUrl release];
	
	status = parser.statusCode;
	
	// If the query was successfull we store the array with results
	if(parser.statusCode == G_GEO_SUCCESS)
	{
		self.results = parser.results;
		self.coordinate =  parser.coordinate;
		self.zipCode = parser.zipCode;
		self.country = parser.country;
		self.countryID = [StringUtility localizedCountryID:parser.country];
	 
	}
	
	[parser release];
	
	
	
	
	if(parseError != nil)
	{
		if([delegate respondsToSelector:@selector(forwardGeocoderError:)])
		{
			[delegate performSelectorOnMainThread:@selector(forwardGeocoderError:) withObject:[parseError localizedDescription] waitUntilDone:NO];
		}
	}
	else {
		if([delegate respondsToSelector:@selector(forwardGeocoderFoundLocation)])
		{
			[delegate performSelectorOnMainThread:@selector(forwardGeocoderFoundLocation) withObject:nil waitUntilDone:NO];
		}		
	}
	
	
	[pool release];
	
	NSLog(@"Found placemarks: %d", [self.results count]);

}
-(void)startGeocoding
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	 
	
	NSError *parseError = nil;
	

	// Create the url to Googles geocoding API, we want the response to be in XML
	NSString* mapsUrl = [[NSString alloc] initWithFormat:@"http://maps.google.com/maps/api/geocode/xml?address=%@&sensor=false", 
						 searchQuery];
	

	
	// Create the url object for our request. It's important to escape the 
	// search string to support spaces and international characters
	NSURL *url = [[NSURL alloc] initWithString:[mapsUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	// Run the KML parser
	GoogleV3KmlParser *parser = [[GoogleV3KmlParser alloc] init];
	
	[parser parseXMLFileAtURL:url parseError:&parseError ignoreAddressComponents:NO];
	
	[url release];
	[mapsUrl release];
	
	status = parser.statusCode;
	
	// If the query was successfull we store the array with results
	if(parser.statusCode == G_GEO_SUCCESS)
	{
		self.results = parser.results;
		self.coordinate =  parser.coordinate;
	}
	
	[parser release];
	
	
	
	
	if(parseError != nil)
	{
		if([delegate respondsToSelector:@selector(forwardGeocoderError:)])
		{
			[delegate performSelectorOnMainThread:@selector(forwardGeocoderError:) withObject:[parseError localizedDescription] waitUntilDone:NO];
		}
	}
	else {
		if([delegate respondsToSelector:@selector(forwardGeocoderFoundLocation)])
		{
			[delegate performSelectorOnMainThread:@selector(forwardGeocoderFoundLocation) withObject:nil waitUntilDone:NO];
		}		
	}
	
	
	[pool release];
	
	NSLog(@"Found placemarks: %d", [self.results count]);
	
}

-(void)dealloc
{
	
	if(results != nil) {
		[results release];
	}
	
	[searchQuery release];
	[googleAPiKey release];
	
	[super dealloc];
}



@end
