//
//  Constants.h
//  The Pomodoro
//
//  Created by Artur Felipe on 12/3/16.
//  Copyright © 2016 Artur Felipe. All rights reserved.
//

#define kAPP_NAME_Bundle    [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey]

#define kAppName [[NSBundle bundleWithIdentifier:@"BundleIdentifier"] objectForInfoDictionaryKey:@"CFBundleExecutable"]
#define kAppVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)@"CFBundleShortVersionString"]
#define kAppBuildNumber [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey]

#define currentLanguageBundle [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSLocale preferredLanguages] objectAtIndex:0] ofType:@"lproj"]]

//NSLocalizedStringFromTableInBundleFromTableInBundle(@"GalleryTitleKey", nil, currentLanguageBundle, @"")


#if kDebugMode
    #define kShowLogs 1
    #define kUseDCIntrospect 1

    #define	DNSLog(...);	NSLog(__VA_ARGS__);
    #define DNSLogMethod	NSLog(@"[%s] %@", class_getName([self class]), NSStringFromSelector(_cmd));
    #define DNSLogPoint(p)	NSLog(@"%f,%f", p.x, p.y);
    #define DNSLogSize(p)	NSLog(@"%f,%f", p.width, p.height);
    #define DNSLogRect(p)	NSLog(@"%f,%f %f,%f", p.origin.x, p.origin.y, p.size.width, p.size.height);

    //CFAbsoluteTime startTime;
    #define D_START			//startTime=CFAbsoluteTimeGetCurrent();
    #define D_END			//DNSLog(@"[%s] %@ %f seconds", class_getName([self class]), NSStringFromSelector(_cmd), CFAbsoluteTimeGetCurrent() - startTime );


    #define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
    #define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }

#else
    #define BACKEND_URL @"http://live.myserver.com"
    #define kShowLogs 0

    #define DNSLog(...);    //NSLog(__VA_ARGS__);
    #define DNSLogMethod    //NSLog(@"[%s] %@", class_getName([self class]), NSStringFromSelector(_cmd) );
    #define DNSLogPoint(p)  //NSLog(@"%f,%f", p.x, p.y);
    #define DNSLogSize(p)   //NSLog(@"%f,%f", p.width, p.height);
    #define DNSLogRect(p)   //NSLog(@"%f,%f %f,%f", p.origin.x, p.origin.y, p.size.width, p.size.height);

    #define D_START         //CFAbsoluteTime startTime=CFAbsoluteTimeGetCurrent();
    #define D_END			//DNSLog(@"New %f seconds", CFAbsoluteTimeGetCurrent() - startTime );

    #define DLog(...)
    #define ULog(...)
#endif

// ALog always displays output regardless of the DEBUG setting
#define ALog(fmt, ...) DLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#define SAFE_FREE(p) { if(p) { free(p); (p)=NULL; } }


#define kStatusBarHeight MIN([[UIApplication sharedApplication] statusBarFrame].size.width, [[UIApplication sharedApplication] statusBarFrame].size.height)
#define kNavigationBarHeight 40 + kStatusBarHeight


#define INTERFACE_IS_PAD     ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define INTERFACE_IS_PHONE   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

#define INTERFACE_IS_IPHONE5() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].scale == 2.0f && [[UIScreen mainScreen] bounds].size.height == 568 ? true:false)

#define INTERFACE_IS_IPHONE6() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].scale == 2.0f && [[UIScreen mainScreen] bounds].size.width == 375 && [[UIScreen mainScreen] bounds].size.height == 667 ? true:false)

#define INTERFACE_IS_IPHONE6_Plus() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].scale == 3.0f && [[UIScreen mainScreen] bounds].size.width == 414 && [[UIScreen mainScreen] bounds].size.height == 736 ? true:false)

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

