//
//  HistoryViewController.m
//  The Pomodoro
//
//  Created by Artur Felipe on 12/3/16.
//  Copyright © 2016 Artur Felipe. All rights reserved.
//

#import "HistoryViewController.h"
#import "NSDate+Helpers.h"

@interface HistoryViewController ()<UITableViewDelegate, UITableViewDataSource>{
    
    NSArray *history;
}

@property (strong, nonatomic) NSMutableDictionary *sections;
@property (strong, nonatomic) NSArray *sortedDays;
@property (strong, nonatomic) NSDateFormatter *sectionDateFormatter;
@property (strong, nonatomic) NSDateFormatter *cellDateFormatter;

- (NSDate *)dateAtBeginningOfDayForDate:(NSDate *)inputDate;
- (NSDate *)dateByAddingYears:(NSInteger)numberOfYears toDate:(NSDate *)inputDate;

@property (weak, nonatomic) IBOutlet UITableView *tableViewHistory;

@end

@implementation HistoryViewController

@synthesize sections;
@synthesize sortedDays;
@synthesize sectionDateFormatter;
@synthesize cellDateFormatter;

+(void)load
{
    [super load];
}

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DLog(@"viewDidLoad: %@", NSStringFromClass([self class]));
    
    [self.tableViewHistory setDelegate:self];
    [self.tableViewHistory setDataSource:self];
    
    self.sectionDateFormatter = [[NSDateFormatter alloc] init];
    [self.sectionDateFormatter setDateStyle:NSDateFormatterLongStyle];
    [self.sectionDateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    self.cellDateFormatter = [[NSDateFormatter alloc] init];
    [self.cellDateFormatter setDateStyle:NSDateFormatterNoStyle];
    [self.cellDateFormatter setTimeStyle:NSDateFormatterShortStyle];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    DLog(@"viewDidUnload: %@", NSStringFromClass([self class]));
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    DLog(@"viewWillAppear: %@", NSStringFromClass([self class]));
    
    [self updateHistory];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    DLog(@"viewDidAppear: %@", NSStringFromClass([self class]));
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    DLog(@"viewWillDisappear: %@", NSStringFromClass([self class]));
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    DLog(@"viewDidDisappear: %@", NSStringFromClass([self class]));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - History logic

- (void)updateHistory{
    [ListHistoryCommand listHistoriesWithBlock:^(NSDictionary *result, NSError *error) {
        
        if(result){
            NSArray *listHistories = [result objectForKey:@"result"];
            
            history = [listHistories copy];
            
            [self devideBySections];
        }
    }];
}

- (void)devideBySections{
    self.sections = [NSMutableDictionary dictionary];
    for (HistoryVO *aHistoryVO in history)
    {
        NSDate *dateRepresentingThisDay = [self dateAtBeginningOfDayForDate:aHistoryVO.lastUpdated];
        
        NSMutableArray *eventsOnThisDay = [self.sections objectForKey:dateRepresentingThisDay];
        if (eventsOnThisDay == nil) {
            eventsOnThisDay = [NSMutableArray array];
            
            [self.sections setObject:eventsOnThisDay forKey:dateRepresentingThisDay];
        }
        
        [eventsOnThisDay addObject:aHistoryVO];
    }
    
    self.sortedDays = [self.sections allKeys];
    
    [self.tableViewHistory reloadData];
}

#pragma mark - UITableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDate *dateRepresentingThisDay = [self.sortedDays objectAtIndex:section];
    NSArray *eventsOnThisDay = [self.sections objectForKey:dateRepresentingThisDay];
    return [eventsOnThisDay count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDate *dateRepresentingThisDay = [self.sortedDays objectAtIndex:section];
    NSString *headerText = nil;
    
    if([dateRepresentingThisDay isToday]){
        headerText = NSLocalizedStringFromTableInBundle(@"DATE_TODAY", nil, currentLanguageBundle, @"");
    }
    else if([dateRepresentingThisDay daysSinceDate:[NSDate date]] < 2 ){
        headerText = NSLocalizedStringFromTableInBundle(@"DATE_YESTERDAy", nil, currentLanguageBundle, @"");
    }
    else{
        headerText = [self.sectionDateFormatter stringFromDate:dateRepresentingThisDay];
    }
    
    return headerText;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    [header.textLabel setTextAlignment:NSTextAlignmentCenter];
    
    header.contentView.backgroundColor = [UIColor redColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellModelHistoryDefault = @"CellModelHistoryDefault";
    
    UITableViewCell *cell = [self.tableViewHistory dequeueReusableCellWithIdentifier:CellModelHistoryDefault forIndexPath:indexPath];
    
//    HistoryVO *aHistoryVO = history[indexPath.row];
    NSDate *dateRepresentingThisDay = [self.sortedDays objectAtIndex:indexPath.section];
    NSArray *eventsOnThisDay = [self.sections objectForKey:dateRepresentingThisDay];
    HistoryVO *aHistoryVO = [eventsOnThisDay objectAtIndex:indexPath.row];
    
    
    UILabel *labelTimer = (UILabel*)[cell.contentView viewWithTag:1];
    labelTimer.text = aHistoryVO.timer;
    
    UILabel *labelState = (UILabel*)[cell.contentView viewWithTag:2];
    switch (aHistoryVO.state.intValue) {
        case stateStopped:
            labelState.text = NSLocalizedStringFromTableInBundle(@"STATE_STOPPED", nil, currentLanguageBundle, @"");
            break;
        case stateFinished:
        default:
            labelState.text = NSLocalizedStringFromTableInBundle(@"STATE_FINISHED", nil, currentLanguageBundle, @"");
            break;
    }
    
    NSString *localeIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0];
//    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
    
    NSString *formatedDate = [aHistoryVO.lastUpdated feedDateTimeWithLocale: localeIdentifier
                                     andDateFormat:@"M/d/yy"
                                     andHourFormat:@"h:mm a"
                                    andShortFormat:YES];
    
    UILabel *labelFinishedTime = (UILabel*)[cell.contentView viewWithTag:3];
    labelFinishedTime.text = formatedDate;
    
    return cell;
}

#pragma mark - Date Calculations

- (NSDate *)dateAtBeginningOfDayForDate:(NSDate *)inputDate
{
    // Use the user's current calendar and time zone
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [calendar setTimeZone:timeZone];
    
    // Selectively convert the date components (year, month, day) of the input date
    NSDateComponents *dateComps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:inputDate];
    
    // Set the time components manually
    [dateComps setHour:0];
    [dateComps setMinute:0];
    [dateComps setSecond:0];
    
    // Convert back
    NSDate *beginningOfDay = [calendar dateFromComponents:dateComps];
    return beginningOfDay;
}

- (NSDate *)dateByAddingYears:(NSInteger)numberOfYears toDate:(NSDate *)inputDate
{
    // Use the user's current calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setYear:numberOfYears];
    
    NSDate *newDate = [calendar dateByAddingComponents:dateComps toDate:inputDate options:0];
    return newDate;
}

@end
