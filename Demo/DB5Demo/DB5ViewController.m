//
//  DB5ViewController.m
//  DB5Demo
//
//  Created by Brent Simmons on 6/26/13.
//  Copyright (c) 2013 Q Branch LLC. All rights reserved.
//

#import "DB5ViewController.h"
#import "VSTheme.h"
#import "VSThemeLoader.h"


@interface DB5ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *label;

@end


@implementation DB5ViewController

- (void)viewDidLoad {

	self.view.backgroundColor = [[VSThemeLoader sharedInstance].defaultTheme colorForKey:@"backgroundColor"];
	self.label.textColor = [[VSThemeLoader sharedInstance].defaultTheme colorForKey:@"labelTextColor"];
	self.label.font = [[VSThemeLoader sharedInstance].defaultTheme fontForKey:@"labelFont"];

	[[VSThemeLoader sharedInstance].defaultTheme animateWithAnimationSpecifierKey:@"labelAnimation" animations:^{

		CGRect rLabel = self.label.frame;
		rLabel.origin = [[VSThemeLoader sharedInstance].defaultTheme pointForKey:@"label"];

		self.label.frame = rLabel;
		
	} completion:^(BOOL finished) {
		NSLog(@"Ran an animation.");
	}];
}



@end
