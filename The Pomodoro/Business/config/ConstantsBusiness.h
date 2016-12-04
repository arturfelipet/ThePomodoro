//
//  Constants.h
//  Infrastructure
//
//  Created by Artur Felipe on 27/09/13.
//  Copyright (c) 2013 Artur Felipe. All rights reserved.
//

#define kErrorConection @"kErrorConection"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


//-------------------------------------------------------------------
//        Database
#define DOCPATHURL [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]
#define DOCPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define ENTITY_HISTORY             @"History"

#define DB_MODEL_URL                 [[NSBundle mainBundle] URLForResource:@"DatabaseModel" withExtension:@"momd"]
#define DB_STOREPATH_URL             [DOCPATHURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", kAPP_NAME, @".sqlite"]]
#define DB_STOREPATH_LIGHT_URL             [DOCPATHURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@%@%@", kAPP_NAME, @"_light", @".sqlite"]]

#define DB_STOREPATH_WATCH_URL        [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.m4sys.thepomodoro.documents"].path, @"NetWorthModel"]];


#define DB_STOREPATH                [NSString stringWithFormat:@"%@/%@%@", DOCPATH, kAPP_NAME, @".sqlite"]
#define DB_STOREPATH_SHM            [NSString stringWithFormat:@"%@/%@%@", DOCPATH, kAPP_NAME, @".sqlite-shm"]
#define DB_STOREPATH_WAL            [NSString stringWithFormat:@"%@/%@%@", DOCPATH, kAPP_NAME, @".sqlite-wal"]


#define DB_STOREPATH_BUNDLE_DB [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", kAPP_NAME, @".sqlite"]]
#define DB_STOREPATH_LIGHT_BUNDLE_DB [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@%@", kAPP_NAME, @"_light", @".sqlite"]]



#define DB_STOREPATH_DESKTOP_USER_EXISTS [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/Users/arturteixeira"]]

#define DB_STOREPATH_DESKTOP_TEST DB_STOREPATH_DESKTOP_USER_EXISTS ? [NSURL fileURLWithPath:[NSString stringWithFormat:@"/Users/arturteixeira/Desktop/%@%@", kAPP_NAME, @".sqlite"] isDirectory:NO] : [NSURL fileURLWithPath:[NSString stringWithFormat:@"/Users/arturfelipe/Desktop/%@%@", kAPP_NAME, @".sqlite"] isDirectory:NO]
#define DB_STOREPATH_DESKTOP_TEST_SHM DB_STOREPATH_DESKTOP_USER_EXISTS ? [NSString stringWithFormat:@"/Users/arturteixeira/Desktop/%@%@", kAPP_NAME, @".sqlite-shm"] : [NSString stringWithFormat:@"/Users/arturfelipe/Desktop/%@%@", kAPP_NAME, @".sqlite-shm"]
#define DB_STOREPATH_DESKTOP_TEST_WAL DB_STOREPATH_DESKTOP_USER_EXISTS ? [NSString stringWithFormat:@"/Users/arturteixeira/Desktop/%@%@", kAPP_NAME, @".sqlite-wal"] : [NSString stringWithFormat:@"/Users/arturfelipe/Desktop/%@%@", kAPP_NAME, @".sqlite-wal"]



//-------------------------------------------------------------------
//       Webservers
//-------------------------------------------------------------------
#define URL_TEST_POST                               [NSURL URLWithString:@"http://httpbin.org/post"]
//-------------------------------------------------------------------

//-------------------------------------------------------------------
//        APIs
//-------------------------------------------------------------------
