//
//  PickParkAppDelegate.h
//  PickPark
//
//  Created by Chau Chin Yiu on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickParkMainVC.h"

@interface PickParkAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	PickParkMainVC *_pickParkMainVC;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet PickParkMainVC *pickParkMainVC;
@end

