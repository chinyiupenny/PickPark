//
//  GoogleV3KmlParser.m
//  AutoScout
//
//  Created by Chau Chin Yiu on 9/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

/**
 
 Kml Parser for Googles geocoding service version 3. Find out more @ Google:
 http://code.google.com/apis/maps/documentation/geocoding/index.html
 
 **/

#import "GoogleV3KmlParser.h"


@implementation GoogleV3KmlParser

@synthesize statusCode, results, coordinate, zipCode, country;

- (BOOL)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error ignoreAddressComponents:(BOOL)ignore
{
	BOOL successfull = TRUE;
	
	ignoreAddressComponents = ignore;
	
	// Create XML parser
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:URL];
    
	// Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
    [parser setDelegate:self];
	
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
	
    // Start parsing
    [parser parse];
    
    NSError *parseError = [parser parserError];
    if (parseError && error) {
        *error = parseError;
		
		successfull = FALSE;
    }
    
    [parser release];
	
	return successfull;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
	attributes:(NSDictionary *)attributeDict
{
	if (qName) {
        elementName = qName;
    }
	
	// The response could contain multiple placemarks
	if([elementName isEqualToString:@"result"])
	{
		// Set up an array to hold placemarks
		if(results == nil)
		{
			results = [[NSMutableArray alloc] init];
		}
		
		// Create a new placemark object to fill with information
		currentResult = [[KmlResult alloc] init];
		
		isLocation = NO;
 
	}
	else if(ignoreAddressComponents == FALSE && [elementName isEqualToString:@"address_component"])
	{
		// Set up an array to hold address components 
		if(addressComponents == nil)
		{
			addressComponents = [[NSMutableArray alloc] init];
		}
		
		currentAddressComponent = [[AddressComponent alloc] init];
		typesArray = [[NSMutableArray alloc] init];
	}
	else if([elementName isEqualToString:@"location"]) {
		isLocation = YES;
	}
 
	
	
	
	// These are the elements we read information from.
	if(([elementName isEqualToString:@"status"] || [elementName isEqualToString:@"formatted_address"] || 
		[elementName isEqualToString:@"lat"] || [elementName isEqualToString:@"lng"]) || 
	   (ignoreAddressComponents == FALSE && ([elementName isEqualToString:@"type"] || 
											 [elementName isEqualToString:@"long_name"] ||
											 [elementName isEqualToString:@"short_name"])
		)
	   )
	{
		// Create a mutable string to hold the contents of the elements.
        // The content is collected in parser:foundCharacters:.
        if(contentsOfCurrentProperty == nil)
		{
			contentsOfCurrentProperty = [NSMutableString string];
		}
		else 
		{
			[contentsOfCurrentProperty setString:@""];
		}
	}
	else 
	{
		// If we're not interested in the element we set the variable used 
		// to collect information to nil.
		contentsOfCurrentProperty = nil;
	}
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
{ 
	if (qName) {
        elementName = qName;
    }
	
	// If we reach the end of a placemark element we add it to our array
	if([elementName isEqualToString:@"result"])
	{
		if(currentResult != nil)
		{
			currentResult.addressComponents = addressComponents;
			[addressComponents release];
			addressComponents = nil;
			
			[results addObject:currentResult];
			[currentResult release];
			currentResult = nil;
		}
	}
	else if ([elementName isEqualToString:@"address_component"]) {
		if(currentAddressComponent != nil)
		{
			if([typesArray containsObject:@"postal_code"] && [zipCode length]<=0 ){
				zipCode = currentAddressComponent.longName;
				NSLog(@"Postcode ===: %@",currentAddressComponent.longName);
			}
			
			if([typesArray containsObject:@"country"]  && [country length]<=0){
				country = currentAddressComponent.shortName;
				NSLog(@"County ===: %@",currentAddressComponent.shortName);
			}

			currentAddressComponent.types = typesArray;
			[typesArray release];
			typesArray = nil;
			
			[addressComponents addObject:currentAddressComponent];
			[currentAddressComponent release];
		 
			currentAddressComponent = nil;
		}
	}
	else if ([elementName isEqualToString:@"location"]) {
		isLocation = NO;
	}
 
	
	// If contentsOfCurrentProperty is nil we're not interested in the
	// collected data 
	if(contentsOfCurrentProperty == nil)
		return;
	
	NSString* elementValue = [[NSString alloc] initWithString:contentsOfCurrentProperty];
	
	if ([elementName isEqualToString:@"status"]) {
		if([elementValue isEqualToString:@"OK"])
		{
			statusCode = G_GEO_SUCCESS;
		}
		else if([elementValue isEqualToString:@"ZERO_RESULTS"])
		{
			statusCode = G_GEO_UNKNOWN_ADDRESS;
		}
		else if([elementValue isEqualToString:@"OVER_QUERY_LIMIT"])
		{
			statusCode = G_GEO_TOO_MANY_QUERIES;
		}
		else if([elementValue isEqualToString:@"REQUEST_DENIED"])
		{
			statusCode = G_GEO_SERVER_ERROR;
		}
		else if([elementValue isEqualToString:@"INVALID_REQUEST"])
		{
			statusCode = G_GEO_BAD_REQUEST;
		}
		
    }
	else if ([elementName isEqualToString:@"long_name"] && currentAddressComponent != nil) {
		currentAddressComponent.longName = elementValue;
    }
	else if ([elementName isEqualToString:@"short_name"] && currentAddressComponent != nil) {
		currentAddressComponent.shortName = elementValue;
    }
	else if ([elementName isEqualToString:@"type"]) {
		if( typesArray )
			[typesArray addObject:elementValue];
    }
	else if ([elementName isEqualToString:@"formatted_address"]) {
		currentResult.address = elementValue;
		
	}
	else if ([elementName isEqualToString:@"lat"]) {
		if(isLocation) {
			currentResult.latitude = [elementValue floatValue];
		}
 
	}
	else if ([elementName isEqualToString:@"lng"]) {
		if(isLocation) {
			currentResult.longitude = [elementValue floatValue];
		}
 
	}
	
	if( currentResult )
	{
		coordinate.latitude = currentResult.latitude;
		coordinate.longitude = currentResult.longitude;
	}
	
	[elementValue release];
	contentsOfCurrentProperty = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (contentsOfCurrentProperty) {
        // If the current element is one whose content we care about, append 'string'
        // to the property that holds the content of the current element.
        [contentsOfCurrentProperty appendString:string];
    }
}

 

-(void)dealloc
{
	
	if(contentsOfCurrentProperty != nil) {
		[contentsOfCurrentProperty release];
	}
	
	if(results != nil)
	{
		[results release];
	}
	
 
	[super dealloc];
}


@end
