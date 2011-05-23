//
//  StringUtility.m
//  AutoScout
//
//  Created by Chau Chin Yiu on 8/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StringUtility.h"


@implementation StringUtility
+(NSArray*) parseVisualSearchResult:(NSString*) resultstring{
	NSMutableArray *result = [[[NSMutableArray alloc] init] autorelease];
	NSArray *listItems = [resultstring componentsSeparatedByString:@";"];
	if ([listItems count]!=6) {
		return result;
	}
	NSString *one=[listItems objectAtIndex:0] ;
	NSString *two=[listItems objectAtIndex:2];
	NSString *three=[listItems objectAtIndex:4];
	

	NSArray *listone = [one componentsSeparatedByString:@","];
	NSString *tempstring1 = [listone objectAtIndex:0];
	NSString *tempstring2 = [listone objectAtIndex:1];
	NSString *tmp1 = [NSString stringWithFormat:@"%@,%@",tempstring1,tempstring2 ];
	
	

	NSArray *listtwo = [two componentsSeparatedByString:@","];
	tempstring1 = [listtwo objectAtIndex:0];
	tempstring2 = [listtwo objectAtIndex:1];
	NSString *tmp2 = [NSString stringWithFormat:@"%@,%@",tempstring1,tempstring2];
	
	

	NSArray *listthree = [three componentsSeparatedByString:@","];
	tempstring1 = [listthree objectAtIndex:0];
	tempstring2 = [listthree objectAtIndex:1];
	NSString *tmp3 = [NSString stringWithFormat:@"%@,%@",tempstring1, tempstring2];
	
	[result addObject:tmp1];
	[result addObject:tmp2];
	[result addObject:tmp3];
	
	return result;
}

+(NSString*) addThousandSeparator:(NSString*) numberString {
 
	
	NSNumberFormatter * format = [[NSNumberFormatter alloc] init];
	[format setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber * myNumber = [format numberFromString:numberString];
 	
	NSNumberFormatter* mFormatter = [[NSNumberFormatter alloc] init];
 
 
	[mFormatter setLocale:[NSLocale currentLocale]];
 	NSString *locale = [[NSLocale currentLocale] localeIdentifier];
	if(([locale isEqualToString:@"de_DE"])||([locale isEqualToString:@"fr_FR"])||([locale isEqualToString:@"es_ES"])){
		[mFormatter setNumberStyle:NSNumberFormatterBehavior10_4];	
	}else{
	    [mFormatter setPositiveFormat:@"#,##0"];
		
	}
	

 	NSString *outputstring = [mFormatter stringFromNumber:myNumber];
	 
	NSLog(@"output is =%@, locale = %@",outputstring, [[NSLocale currentLocale] localeIdentifier] );
	
	[format release];
	[mFormatter release];
	return outputstring;
}

+(BOOL) stringIsNumber:(NSString* )numberString
{
	NSString *regex = @"^*[0-9]*$";
	NSPredicate *regextest = [NSPredicate  predicateWithFormat:@"SELF MATCHES %@", regex];
	if ([regextest evaluateWithObject:numberString] == YES) {
		NSLog(@"Match!");
		return YES;
	} 
	else
	{
		NSLog(@"No match!");
		return NO;
	}
}


+(NSString *)localizedCountryID:(NSString *)shortName
{
	if( [shortName isEqualToString:@"AT"] )
		return @"A";
	else if( [shortName isEqualToString:@"BE"] )
		return @"B";
	else if( [shortName isEqualToString:@"DE"] )
		return @"D";
	else if( [shortName isEqualToString:@"ES"] )
		return @"E";
	else if( [shortName isEqualToString:@"FR"] )
		return @"F";
	else if( [shortName isEqualToString:@"IT"] )
		return @"I";
	else if( [shortName isEqualToString:@"LU"] )
		return @"L";
	else if( [shortName isEqualToString:@"NL"] )
		return @"NL";
	else if( [shortName isEqualToString:@"PL"] )
		return  @"PL";
	else if( [shortName isEqualToString:@"RU"] )
		return  @"RUS" ;
	else if( [shortName isEqualToString:@"SE"] )
		return  @"S";
	else if( [shortName isEqualToString:@"SI"] )
		return  @"SLO";
	else if( [shortName isEqualToString:@"LV"] )
		return @"LV";
	else if( [shortName isEqualToString:@"LT"] )
		return   @"LT" ;
	else
		return @"";
}

+(NSString *)geoCountryID2GeneralCountryCode:(NSString *)shortName
{
	if( [shortName isEqualToString:@"A"] )
		return @"AT";
	else if( [shortName isEqualToString:@"B"] )
		return @"BE";
	else if( [shortName isEqualToString:@"D"] )
		return @"DE";
	else if( [shortName isEqualToString:@"E"] )
		return @"ES";
	else if( [shortName isEqualToString:@"F"] )
		return @"FR";
	else if( [shortName isEqualToString:@"I"] )
		return @"IT";
	else if( [shortName isEqualToString:@"L"] )
		return @"LU";
	else if( [shortName isEqualToString:@"NL"] )
		return @"NL";
	else if( [shortName isEqualToString:@"PL"] )
		return  @"PL";
	else if( [shortName isEqualToString:@"RUS"] )
		return  @"RU" ;
	else if( [shortName isEqualToString:@"S"] )
		return  @"SE";
	else if( [shortName isEqualToString:@"SLO"] )
		return  @"SI";
	else if( [shortName isEqualToString:@"LV"] )
		return @"LV";
	else if( [shortName isEqualToString:@"LT"] )
		return   @"LT" ;
	else
		return @"";
}

+(NSString*) getCountryName:(NSString*) shortform {
	
	 
	if ([shortform isEqualToString:@"A"]) {
		return @"Austria";
	} else if ([shortform isEqualToString:@"D"]) {
		return @"Germany";
	} else if ([shortform isEqualToString:@"B"]) {
		return @"Belgium";
	} else if ([shortform isEqualToString:@"E"]) {
		return @"Spain";
	} else if ([shortform isEqualToString:@"F"]) {
		return @"France";
	} else if ([shortform isEqualToString:@"I"]){
		return @"Italy";
	} else if ([shortform isEqualToString:@"L"]){
		return @"Luxembourg";
	} else if ([shortform isEqualToString:@"NL"]) {
		return @"Netherlands";
	}
	return @"Germany";
}

@end
