//
//  VSThemeLoader.m
//  Q Branch LLC
//
//  Created by Brent Simmons on 6/26/13.
//  Copyright (c) 2012 Q Branch LLC. All rights reserved.
//

#import "VSThemeLoader.h"
#import "VSTheme.h"

@interface VSThemeLoader ()

@property (nonatomic, strong, readwrite) VSTheme *defaultTheme;
@property (nonatomic, strong, readwrite) NSArray *themes;
@end


@implementation VSThemeLoader

+ (VSThemeLoader *)sharedInstance
{
    static VSThemeLoader *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
	
	self = [super init];
	if (self == nil)
		return nil;
	
	[self reloadThemes];
	
	return self;
}

- (void) loadThemesFromFilename:(NSString*)filename
{
	NSDictionary *themesDictionary;
	NSString *themesFilePath = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
	if (themesFilePath != nil) {
		themesDictionary = [NSDictionary dictionaryWithContentsOfFile:themesFilePath];
	} else {
		themesFilePath = [[NSBundle mainBundle] pathForResource:filename ofType:@"json"];
		NSInputStream *stream = [NSInputStream inputStreamWithFileAtPath:themesFilePath];
		[stream open];
		themesDictionary = [NSJSONSerialization JSONObjectWithStream:stream options:0 error:nil];
		[stream close];
	}
	
	NSMutableArray *themes = [NSMutableArray array];
	for (NSString *oneKey in themesDictionary) {
		
		VSTheme *theme = [[VSTheme alloc] initWithDictionary:themesDictionary[oneKey]];
		if ([[oneKey lowercaseString] isEqualToString:@"default"])
			_defaultTheme = theme;
		theme.name = oneKey;
		[themes addObject:theme];
	}
	
	for (VSTheme *oneTheme in themes) { /*All themes inherit from the default theme.*/
		if (oneTheme != _defaultTheme)
			oneTheme.parentTheme = _defaultTheme;
	}
	
	_themes = themes;
}

- (void) reloadThemes
{
	NSString *filename = @"DB5";
	[self loadThemesFromFilename:filename];
}

- (VSTheme *)themeNamed:(NSString *)themeName {
	
	for (VSTheme *oneTheme in self.themes) {
		if ([themeName isEqualToString:oneTheme.name])
			return oneTheme;
	}
	
	return nil;
}

@end

