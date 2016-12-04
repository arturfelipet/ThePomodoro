//
//  NSDate+Helpers.m
//  PMCalendar
//
//  Created by Pavel Mazurin on 7/14/12.
//  Copyright (c) 2012 Pavel Mazurin. All rights reserved.
//

#import "NSDate+Helpers.h"
#import "NSDate+Help.h"

@implementation NSDate (Helpers)

- (NSDate *)dateWithoutTime
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit
                                                         | NSMonthCalendarUnit
                                                         | NSDayCalendarUnit )
                                               fromDate:self];
#pragma clang diagnostic pop
	return [calendar dateFromComponents:components];
}

- (NSDate *) dateByAddingDays:(NSInteger) days months:(NSInteger) months years:(NSInteger) years
{
	NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
	dateComponents.day = days;
	dateComponents.month = months;
	dateComponents.year = years;
	
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents
                                                         toDate:self
                                                        options:0];    
}

- (NSDate *) dateByAddingDays:(NSInteger) days
{
    return [self dateByAddingDays:days months:0 years:0];
}

- (NSDate *) dateByAddingMonths:(NSInteger) months
{
    return [self dateByAddingDays:0 months:months years:0];
}

- (NSDate *) dateByAddingYears:(NSInteger) years
{
    return [self dateByAddingDays:0 months:0 years:years];
}

- (NSDate *) monthStartDate 
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSDate *monthStartDate = nil;
    [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit
                                    startDate:&monthStartDate
                                     interval:NULL
                                      forDate:self];
#pragma clang diagnostic pop
    
	return monthStartDate;
}

- (NSDate *) midnightDate
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSDate *midnightDate = nil;
    [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit
                                    startDate:&midnightDate
                                     interval:NULL
                                      forDate:self];
#pragma clang diagnostic pop
	return midnightDate;
}

- (NSUInteger) numberOfDaysInMonth
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit
                                              inUnit:NSMonthCalendarUnit
                                             forDate:self].length;
#pragma clang diagnostic pop
}

- (NSUInteger) weekday
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:self];
    
#pragma clang diagnostic pop
    
    return [weekdayComponents weekday];
}

- (NSString *) dateStringWithFormat:(NSString *) format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
		
	return [formatter stringFromDate:self];
}

- (NSString *) dateStringWithFormat:(NSString *) format andLocale:(NSString *) locale
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:locale]];
    
	return [formatter stringFromDate:self];
}

- (NSInteger) daysSinceDate:(NSDate *) date
{
    return round([self timeIntervalSinceDate:date] / (60 * 60 * 24));
}

- (BOOL) isBefore:(NSDate *) date
{
	return [self timeIntervalSinceDate:date] < 0;
}

- (BOOL) isAfter:(NSDate *) date
{
	return [self timeIntervalSinceDate:date] > 0;
}

- (BOOL) isToday
{
    NSCalendarUnit units = NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |
    NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units
                                                                   fromDate:self
                                                                     toDate:[NSDate date]
                                                                    options:0];
    
    if (components.day == 0 &&
        components.month == 0 &&
        components.year == 0) {
        return YES;
    }
    else{
        return NO;
    }
}

- (BOOL) isLastHour
{
    NSCalendarUnit units = NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |
    NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units
                                                                   fromDate:self
                                                                     toDate:[NSDate date]
                                                                    options:0];
    
    if (components.hour == 0 &&
        components.day == 0 &&
        components.month == 0 &&
        components.year == 0) {
        return YES;
    }
    else{
        return NO;
    }
}

- (BOOL) isLast24Hours
{
    NSCalendarUnit units = NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |
    NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units
                                                                   fromDate:self
                                                                     toDate:[NSDate date]
                                                                    options:0];
    
    if (components.hour < 24 &&
        components.day == 0 &&
        components.month == 0 &&
        components.year == 0) {
        return YES;
    }
    else{
        return NO;
    }
}

- (BOOL) isLast48Hours
{
    NSCalendarUnit units = NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |
    NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units
                                                                   fromDate:self
                                                                     toDate:[NSDate date]
                                                                    options:0];
    
    if (components.hour < 48 &&
        components.day == 0 &&
        components.month == 0 &&
        components.year == 0) {
        return YES;
    }
    else{
        return NO;
    }
}

- (NSInteger) MinutesFromDate
{
    NSCalendarUnit units = NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |
    NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units
                                                                   fromDate:self
                                                                     toDate:[NSDate date]
                                                                    options:0];
    
    return components.minute;
}

- (NSInteger) hoursFromDate
{
    NSCalendarUnit units = NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |
    NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units
                                                                   fromDate:self
                                                                     toDate:[NSDate date]
                                                                    options:0];
    
    return components.hour;
}

+ (NSString *) randomDateTimeWithLocale:(NSString *) locale andHourFormat:(NSString *) hourFormat{
#define ARC4RANDOM_MAX 0x100000000
    NSTimeInterval timeBetweenDates = [[NSDate date] timeIntervalSinceDate:[NSDate dateWithTimeIntervalSinceNowInHours:arc4random_uniform(900) ]];
    NSTimeInterval randomInterval = ((NSTimeInterval)arc4random() / ARC4RANDOM_MAX) * timeBetweenDates;
    
    NSDate *randomDate = [[NSDate date] dateByAddingTimeInterval:randomInterval];
    
//    NSString *dateFormat = [[LanguageManager getCurrentLanguageDict] objectForKey:@"hourformat"];
    //    NSDate *tempDate= [NSDate dateFromString:tempDateStr withFormat:@"yyyy-MM-dd, HH:mm:ss zz"];
    
    NSString *randomHourStr = [randomDate dateStringWithFormat:hourFormat  andLocale:locale];
    
    return randomHourStr;
}

- (NSString *) feedDateTimeWithLocale:(NSString *) locale andDateFormat:(NSString *) dateFormat andHourFormat:(NSString *) hourFormat andShortFormat:(BOOL) shortFormat{
    
    NSString *hourStr = [self dateStringWithFormat:[NSString stringWithFormat:@"%@", dateFormat] andLocale:locale];
    
    if(!shortFormat){
        if(hourFormat){
            hourStr = [self dateStringWithFormat:[NSString stringWithFormat:@"%@ %@", dateFormat, hourFormat] andLocale:locale];
        }
    }
    
    if(shortFormat){
        if([self isLastHour]){
            hourStr = [NSString stringWithFormat:@"%ldm", (long)[self MinutesFromDate]];
        }
        else if([self isLast24Hours]){
            hourStr = [NSString stringWithFormat:@"%ldh", (long)[self hoursFromDate]];
        }
    //    else if([self isLast48Hours]){
    //        hourStr = [NSString stringWithFormat:@"%@ %ldh", NSLocalizedStringFromTableInBundle(@"DATE_YESTERDAY", nil, currentLanguageBundle, @""), (long)[self hoursFromDate]];
    //    }
    }
    
    return hourStr;
}

@end
