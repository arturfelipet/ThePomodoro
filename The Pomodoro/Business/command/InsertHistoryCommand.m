//
//  InsertHistoryCommand.m
//  The Pomodoro
//
//  Created by Artur Felipe on 12/3/16.
//  Copyright © 2016 Artur Felipe. All rights reserved.
//

#import "InsertHistoryCommand.h"

@implementation InsertHistoryCommand

+ (instancetype)sharedInstance
{
    static InsertHistoryCommand *instance = nil;
    static dispatch_once_t onceToken;
    
    if (instance) return instance;
    
    dispatch_once(&onceToken, ^{
        instance = [InsertHistoryCommand alloc];
        instance = [instance init];
    });
    
    return instance;
}

- (id)initWithDelegate:(id<InsertHistoryCommandDelegate>)mDelegate
{
    self = [self init];
    if (self)
    {
        self.delegate = mDelegate;
    }
    return self;
}

+ (void)createHistoryWithTitle:(NSString *)timer withState:(NSNumber *)state withBlock:(InsertHistoryResponseBlock)responseBlock{
    dispatch_queue_t backgroundQueue = dispatch_queue_create([[NSString stringWithFormat:@"ThePomodoro.%@", NSStringFromClass([self class])] UTF8String], NULL);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_async(backgroundQueue, ^
                   {
                       NSError *error;
                       BOOL success = NO;
                       
                       [DAOFactory configDatabaseManager];
                       
                       History *aHistory = [[DatabaseManager sharedInstance] createObject:ENTITY_HISTORY error:&error];
                       aHistory.timer = timer;
                       aHistory.state = state;
                       aHistory.lastUpdated = [NSDate date];
                       aHistory.finishedDate = [NSDate date];
                       aHistory.uid = [NSString stringWithFormat:@"%@ %d%d%d", aHistory.timer, arc4random_uniform(999999999), arc4random_uniform(999999999), arc4random_uniform(999999999)];
                       
                       [[DatabaseManager sharedInstance] saveContext:&error];
                       
                       if(!error){
                           success = YES;
                       }
                       
                       dispatch_async(mainQueue, ^
                                      {
                                          responseBlock(@{@"result": [[HistoryVO alloc] initWith:aHistory]}, error);
                                      });
                   });
}

@end
