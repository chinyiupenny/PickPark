//
//  StringUtility.h
//  AutoScout
//
//  Created by Chau Chin Yiu on 8/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StringUtility : NSObject {

}
+(NSArray*) parseVisualSearchResult:(NSString*) resultstring;
+(NSString*) addThousandSeparator:(NSString*) numberString;
+(BOOL) stringIsNumber:(NSString*) numberString;
//+(NSString*) findCountryValue:(NSString*) inputCountryString;
+(NSString*) getCountryName:(NSString*) shortform ;

+(NSString *)localizedCountryName:(NSString *)shortName;
+(NSString *)localizedCountryID:(NSString *)shortName;
+(NSString *)geoCountryID2GeneralCountryCode:(NSString *)shortName;
@end
