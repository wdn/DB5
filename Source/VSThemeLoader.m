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
	
	self.themeSource = @"file:///DB5";
//	self.themeSource = @"file:///DB5-alt";
//	self.themeSource = @"https://host/DB5.json";
	[self reloadThemes];
	
	return self;
}

- (void) loadThemesFromURL:(NSURL*)url
{
	NSDictionary *themesDictionary;
	NSString* scheme = [url scheme];
	if ([scheme isEqualToString:@"file"])
	{
		NSString* filename = [url path];
		NSString* themesFilePath = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
		if (themesFilePath != nil) {
			themesDictionary = [NSDictionary dictionaryWithContentsOfFile:themesFilePath];
		} else {
			themesFilePath = [[NSBundle mainBundle] pathForResource:filename ofType:@"json"];
			NSInputStream *stream = [NSInputStream inputStreamWithFileAtPath:themesFilePath];
			[stream open];
			themesDictionary = [NSJSONSerialization JSONObjectWithStream:stream options:0 error:nil];
			[stream close];
		}
	}
	else if ([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"])
	{
		if ([[url pathExtension] isEqualToString:@"plist"])
			themesDictionary = [NSDictionary dictionaryWithContentsOfURL:url];
		else if ([[url pathExtension] isEqualToString:@"json"])
		{
			NSData* data = [NSData dataWithContentsOfURL:url];
			themesDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
		}
	}
	else
		return;
	
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
	NSURL* url = [NSURL URLWithString:self.themeSource];
	[self loadThemesFromURL:url];
}

- (VSTheme *)themeNamed:(NSString *)themeName {
	
	for (VSTheme *oneTheme in self.themes) {
		if ([themeName isEqualToString:oneTheme.name])
			return oneTheme;
	}
	
	return nil;
}

@end

