//
//  NSDate+Help.h
//  Infrastructure
//
//  Created by Artur Felipe on 06/09/13.
//  Copyright (c) 2013 Artur Felipe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(Help)

+ (NSDate *)tomorrowDate;
+ (NSDate *)nextHourDate;
+ (NSDate *)dateWithTimeIntervalSinceNowInHours:(NSInteger)hours;

+ (NSDate *)datePlusNDays:(NSInteger)days withDate:(NSDate *) date;
+ (NSDate *)dateFromString:(NSString *)date withFormat:(NSString *)format;

+ (NSString *)parseDateToString:(NSDate*) date;


@end
