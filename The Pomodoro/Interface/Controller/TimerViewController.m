//
//  TimerViewController.m
//  The Pomodoro
//
//  Created by Artur Felipe on 12/3/16.
//  Copyright © 2016 Artur Felipe. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController (){
    int state;
    
    NSTimer *timer;
    
    int duration;
    int runtimer;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageViewTomato;
@property (weak, nonatomic) IBOutlet UILabel *labelTimer;
@property (weak, nonatomic) IBOutlet UIButton *buttonStartStop;

@end

@implementation TimerViewController

+(void)load
{
    [super load];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self loadDefaultValues];
    [self resetInterface];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DLog(@"viewDidLoad: %@", NSStringFromClass([self class]));
    
    [self.buttonStartStop setBackgroundImage:[UIImage imageNamed:@"button_default"] forState:UIControlStateNormal];
    [self.buttonStartStop setBackgroundImage:[UIImage imageNamed:@"button_default"] forState:UIControlStateFocused];
    [self.buttonStartStop setBackgroundImage:[UIImage imageNamed:@"button_default"] forState:UIControlStateDisabled];
    [self.buttonStartStop setBackgroundImage:[UIImage imageNamed:@"button_default_selected"] forState:UIControlStateSelected];
    [self.buttonStartStop setBackgroundImage:[UIImage imageNamed:@"button_default_selected"] forState:UIControlStateHighlighted];
    
    [self.buttonStartStop setTitle:NSLocalizedStringFromTableInBundle(@"TIMER_BUTTON_START", nil, currentLanguageBundle, @"") forState:UIControlStateNormal];
    [self.buttonStartStop setTitle:NSLocalizedStringFromTableInBundle(@"TIMER_BUTTON_STOP", nil, currentLanguageBundle, @"") forState:UIControlStateSelected];
    
    
    [self.labelTimer setTextColor:[UIColor lightGrayColor]];
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

-(void)resetInterface{
    [self.imageViewTomato setImage:[UIImage imageNamed:@"tomato_off"]];
    [self.buttonStartStop setSelected:NO];
    [self.labelTimer setTextColor:[UIColor lightGrayColor]];
    self.labelTimer.text = [NSString stringWithFormat:@"%02d:%02d",duration / 60, duration % 60];
}

#pragma mark - Timer Logic

-(void)loadDefaultValues{
    runtimer = 25; //Controls the min duration
    duration = runtimer * 60;
    state = stateReady;
}

-(void)resetTimer{
    if(timer)
        [timer invalidate];
    timer = nil;
    
    [self loadDefaultValues];
}

- (IBAction)startStopTimer:(id)sender {
    if(state == stateReady)
    {
        [self.imageViewTomato setImage:[UIImage imageNamed:@"tomato_on"]];
        self.labelTimer.text = [NSString stringWithFormat:@"%02d:%02d",duration / 60, duration % 60];
        [self.labelTimer setTextColor:[UIColor redColor]];
        [self.buttonStartStop setSelected:YES];
        
        state = stateRunning;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    else{//User Stopped the timer
        state = stateStopped;
        [self recordToHistory];
        [self resetInterface];
        [self resetTimer];
    }
}

- (void)updateTimer{
    self.labelTimer.text = [NSString stringWithFormat:@"%02d:%02d",duration / 60, duration % 60];
    
    if (duration>0) {
        duration--;
    } else { //Timer runned out by itself
        state = stateFinished;
        [self recordToHistory];
        [self resetInterface];
        [self resetTimer];
    }
}

-(void)recordToHistory{
    NSString *elapsedTime = [self calculateElapsedTime];
    [self showNotification];
    
    [InsertHistoryCommand createHistoryWithTitle:elapsedTime withState:[NSNumber numberWithInt:state] withBlock:^(NSDictionary *result, NSError *error) {
        DLog(@"viewDidLoad: %@", NSStringFromClass([self class]));
    }];
}

#pragma mark - Push Notification Logic

-(void)showNotification{
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    notification.repeatInterval = NSCalendarUnitDay;
    [notification setAlertBody:NSLocalizedStringFromTableInBundle(@"LOCAL_PUSH_MESSAGE", nil, currentLanguageBundle, @"")];
    [notification setFireDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    [notification setTimeZone:[NSTimeZone defaultTimeZone]];
    [[UIApplication sharedApplication] setScheduledLocalNotifications:[NSArray arrayWithObject:notification]];
}

#pragma mark - Elapsed Time Logic

-(NSString *)calculateElapsedTime{
    NSString *runnedTime = self.labelTimer.text;
    
    NSString *str = [NSString stringWithFormat:@"3/15/2012 9:%@ PM", runnedTime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [formatter setTimeZone:gmt];
    
    int runtime = runtimer * 60;
    
    NSString *str2 = [NSString stringWithFormat:@"3/15/2012 9:%02d:%02d PM", runtime / 60, runtime % 60];
    
    NSDate *startDate = [formatter dateFromString:str];
    NSDate *endDate = [formatter dateFromString:str2];
    
    NSTimeInterval secondsBetween = [endDate timeIntervalSinceDate:startDate];
    
    
    int min = (int)secondsBetween / 60;
    int sec = (int)secondsBetween % 60;
    NSString *elapsedTime = [NSString stringWithFormat:@"%02d:%02d", min, sec];
    
    return elapsedTime;
}


@end
