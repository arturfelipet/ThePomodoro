//
//  NSDate+Help.m
//  Infrastructure
//
//  Created by Artur Felipe on 06/09/13.
//  Copyright (c) 2013 Artur Felipe. All rights reserved.
//


//    Date Formats
//    a: AM/PM
//    A: 0~86399999 (Millisecond of Day)
//
//    c/cc: 1~7 (Day of Week)
//    ccc: Sun/Mon/Tue/Wed/Thu/Fri/Sat
//    cccc: Sunday/Monday/Tuesday/Wednesday/Thursday/Friday/Saturday
//
//    d: 1~31 (0 padded Day of Month)
//    D: 1~366 (0 padded Day of Year)
//
//    e: 1~7 (0 padded Day of Week)
//    E~EEE: Sun/Mon/Tue/Wed/Thu/Fri/Sat
//    EEEE: Sunday/Monday/Tuesday/Wednesday/Thursday/Friday/Saturday
//
//    F: 1~5 (0 padded Week of Month, first day of week = Monday)
//
//    g: Julian Day Number (number of days since 4713 BC January 1)
//    G~GGG: BC/AD (Era Designator Abbreviated)
//    GGGG: Before Christ/Anno Domini
//
//    h: 1~12 (0 padded Hour (12hr))
//    H: 0~23 (0 padded Hour (24hr))
//
//    k: 1~24 (0 padded Hour (24hr)
//    K: 0~11 (0 padded Hour (12hr))
//
//    L/LL: 1~12 (0 padded Month)
//    LLL: Jan/Feb/Mar/Apr/May/Jun/Jul/Aug/Sep/Oct/Nov/Dec
//    LLLL: January/February/March/April/May/June/July/August/September/October/November/December
//
//    m: 0~59 (0 padded Minute)
//    M/MM: 1~12 (0 padded Month)
//    MMM: Jan/Feb/Mar/Apr/May/Jun/Jul/Aug/Sep/Oct/Nov/Dec
//    MMMM: January/February/March/April/May/June/July/August/September/October/November/December
//
//    q/qq: 1~4 (0 padded Quarter)
//    qqq: Q1/Q2/Q3/Q4
//    qqqq: 1st quarter/2nd quarter/3rd quarter/4th quarter
//    Q/QQ: 1~4 (0 padded Quarter)
//    QQQ: Q1/Q2/Q3/Q4
//    QQQQ: 1st quarter/2nd quarter/3rd quarter/4th quarter
//
//    s: 0~59 (0 padded Second)
//    S: (rounded Sub-Second)
//
//    u: (0 padded Year)
//
//    v~vvv: (General GMT Timezone Abbreviation)
//    vvvv: (General GMT Timezone Name)
//
//    w: 1~53 (0 padded Week of Year, 1st day of week = Sunday, NB: 1st week of year starts from the last Sunday of last year)
//    W: 1~5 (0 padded Week of Month, 1st day of week = Sunday)
//
//    y/yyyy: (Full Year)
//    yy/yyy: (2 Digits Year)
//    Y/YYYY: (Full Year, starting from the Sunday of the 1st week of year)
//    YY/YYY: (2 Digits Year, starting from the Sunday of the 1st week of year)
//
//    z~zzz: (Specific GMT Timezone Abbreviation)
//    zzzz: (Specific GMT Timezone Name)
//    Z: +0000 (RFC 822 Timezone)
//
//    How to Use:
//
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm:ss a"];
//    NSLog(@"%@", [dateFormatter dateFromString:@"12/12/2012 12:12:12 AM"]);
//

#import "NSDate+Help.h"

@implementation NSDate(Help)

+ (NSDate *)tomorrowDate{
    return [self datePlusNDays:1 withDate:[NSDate date]];
}

+ (NSDate *)nextHourDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSDateComponents *comps = [calendar components: NSEraCalendarUnit|NSYearCalendarUnit| NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit fromDate: [NSDate date]];
    [comps setHour: [comps hour]+2]; // Here you may also need to check if it's the last hour of the day
#pragma clang diagnostic pop
    return [calendar dateFromComponents:comps];
}

+ (NSDate *)dateWithTimeIntervalSinceNowInHours:(NSInteger)hours{
    // start by retrieving day, weekday, month and year components for yourDate
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *todayComponents = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:[NSDate date]];
#pragma clang diagnostic pop
    NSInteger theDay = [todayComponents day];
    NSInteger theMonth = [todayComponents month];
    NSInteger theYear = [todayComponents year];
    
    NSInteger theHours = [todayComponents hour];
    NSInteger theMinutes = [todayComponents minute];
    NSInteger theSeconds = [todayComponents second];
    
    // now build a NSDate object for yourDate using these components
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:theDay];
    [components setMonth:theMonth];
    [components setYear:theYear];
    [components setHour:theHours];
    [components setMinute:theMinutes];
    [components setSecond:theSeconds];
    
    NSDate *thisDate = [gregorian dateFromComponents:components];
    
    // now build a NSDate object for the next day
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:hours];
    NSDate *nextDate = [gregorian dateByAddingComponents:offsetComponents toDate:thisDate options:0];
    
    return nextDate;
}

+ (NSDate *)datePlusNDays:(NSInteger)days withDate:(NSDate *) date{
    // start by retrieving day, weekday, month and year components for yourDate
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *todayComponents = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:date];
#pragma clang diagnostic pop
    NSInteger theDay = [todayComponents day];
    NSInteger theMonth = [todayComponents month];
    NSInteger theYear = [todayComponents year];
    
    // now build a NSDate object for yourDate using these components
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:theDay];
    [components setMonth:theMonth];
    [components setYear:theYear];
    NSDate *thisDate = [gregorian dateFromComponents:components];
    
    // now build a NSDate object for the next day
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:days];
    NSDate *nextDate = [gregorian dateByAddingComponents:offsetComponents toDate:thisDate options:0];
    
    return nextDate;
}

+ (NSDate *) dateFromString:(NSString *)date withFormat:(NSString *)format{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //    NSString *cookie = @"Tuesday, 15-Jul-2014 10:55:34 GMT";
    //    [dateFormat setDateFormat:@"EEEE, dd-MMM-yyyy HH:mm:ss z"];
    //  2014-04-18T01:35:20+0000
    //    [dateFormatGVT setDateFormat:@"yyyy-MM-ddTHH:mm:ss zz"];
    
    //2014-10-10, 12:00:00 -0003
    //@"yyyy-MM-dd, HH:mm:ss zz"
    
    [dateFormat setDateFormat:format];
    
    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSString *localeIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0];
    
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier]];
    
    
    NSDate *dtResult = [dateFormat dateFromString:date];
    
    return dtResult;
}

//+ (NSString *) getDefaultUserMail{
//    NSURL *emailAppURL = [[NSWorkspace sharedWorkspace] URLForApplicationToOpenURL:[NSURL URLWithString:@"mailto:"]];
//
//
//}

+(NSString *)parseDateToString:(NSDate*) date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    //        [formatter setDateFormat:@"dd-MM-yyyy h:mm:ss a zzz"];
    
    //Optionally for time zone converstions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"America/Sao_Paulo"]];
    
    return [formatter stringFromDate:date];
}

@end
