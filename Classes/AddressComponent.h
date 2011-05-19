//
//  AddressComponent.h
//  AutoScout
//
//  Created by Chau Chin Yiu on 9/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface AddressComponent : NSObject {
	NSString *longName;
	NSString *shortName;
	NSArray *types;
}

@property (nonatomic, retain) NSString *longName;
@property (nonatomic, retain) NSString *shortName;
@property (nonatomic, retain) NSArray *types;

@end

