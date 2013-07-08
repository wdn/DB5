//
//  VSThemeLoader.m
//  Q Branch LLC
//
//  Created by Brent Simmons on 6/26/13.
//  Copyright (c) 2012 Q Branch LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@class VSTheme;

@interface VSThemeLoader : NSObject

@property (nonatomic, strong) NSString* themeSource;
@property (nonatomic, strong, readonly) VSTheme *defaultTheme;
@property (nonatomic, strong, readonly) NSArray *themes;

+ (VSThemeLoader *)sharedInstance;

- (void) loadThemesFromURL:(NSURL*)url;
- (void) reloadThemes;
- (VSTheme *)themeNamed:(NSString *)themeName;

@end
