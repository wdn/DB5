//
//  DB5AppDelegate.m
//  DB5Demo
//
//  Created by Brent Simmons on 6/26/13.
//  Copyright (c) 2013 Q Branch LLC. All rights reserved.
//

#import "DB5AppDelegate.h"
#import "DB5ViewController.h"


@implementation DB5AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
 	self.viewController = [[DB5ViewController alloc] initWithNibName:@"DB5ViewController" bundle:nil];
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
	
    return YES;
}

@end
