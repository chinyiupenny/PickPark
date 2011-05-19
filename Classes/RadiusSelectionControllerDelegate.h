//
//  RadiusSelectionControllerDelegate.h
//  AutoScout
//
//  Created by Chau Chin Yiu on 8/6/10.
//  Copyright 2010 Autoscout24 GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RadiusSelectionControllerDelegate

-(void)radiusInMetetersDidChange:(NSInteger)meters center:(CLLocationCoordinate2D)center;

@end

