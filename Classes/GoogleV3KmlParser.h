//
//  GoogleV3KmlParser.h
//  AutoScout
//
//  Created by Chau Chin Yiu on 9/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KmlResult.h"
#import "AddressComponent.h"
#import "ForwardGeocoder.h"

@interface GoogleV3KmlParser : NSObject <NSXMLParserDelegate> {
	NSMutableString *contentsOfCurrentProperty;
	int statusCode;
	
	NSMutableArray *results;
	NSMutableArray *addressComponents;
	NSMutableArray *typesArray;
	KmlResult *currentResult;
	AddressComponent *currentAddressComponent;
	CLLocationCoordinate2D coordinate;
	NSString *zipCode;
	NSString *country; 
	BOOL ignoreAddressComponents;
	BOOL isLocation;
	BOOL isViewPort;
	BOOL isBounds;
	BOOL isSouthWest;
}

@property (nonatomic, readonly) int statusCode;
@property (nonatomic, readonly) NSMutableArray *results;
@property (nonatomic, readonly)	CLLocationCoordinate2D coordinate;
@property (nonatomic,readonly) NSString *zipCode;
@property (nonatomic,readonly) NSString *country;
 
- (BOOL)parseXMLFileAtURL:(NSURL *)URL 
			   parseError:(NSError **)error 
  ignoreAddressComponents:(BOOL)ignore;


@end