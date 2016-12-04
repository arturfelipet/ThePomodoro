//
//  ListHistoryCommand.m
//  The Pomodoro
//
//  Created by Artur Felipe on 12/3/16.
//  Copyright © 2016 Artur Felipe. All rights reserved.
//

#import "ListHistoryCommand.h"

@implementation ListHistoryCommand

+ (instancetype)sharedInstance
{
    static ListHistoryCommand *instance = nil;
    static dispatch_once_t onceToken;
    
    if (instance) return instance;
    
    dispatch_once(&onceToken, ^{
        instance = [ListHistoryCommand alloc];
        instance = [instance init];
    });
    
    return instance;
}

- (id)initWithDelegate:(id<ListHistoryCommandDelegate>)mDelegate
{
    self = [self init];
    if (self)
    {
        self.delegate = mDelegate;
    }
    return self;
}

+ (void)listHistoriesWithBlock:(ListHistoryResponseBlock)responseBlock{
        
    dispatch_queue_t backgroundQueue = dispatch_queue_create([[NSString stringWithFormat:@"Pomodoro.%@", NSStringFromClass([self class])] UTF8String], NULL);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_async(backgroundQueue, ^
                   {
                       NSError *error = nil;
                       
                       [DAOFactory configDatabaseManager];
                       
                       id result = [[DatabaseManager sharedInstance] fetchData:ENTITY_HISTORY predicate:[NSPredicate predicateWithFormat:@"uid != nil"] offset:0 limit:0 sortBy:@"lastUpdated" ascending:NO error:&error];
                       
                       NSMutableArray* vos = [NSMutableArray array];
                       
                       if ([result isKindOfClass:[NSArray class]])
                           for (History *aHistory in result){
                               [vos addObject:[[HistoryVO alloc] initWith:aHistory]];
                           }
                       
                       dispatch_async(mainQueue, ^
                                      {                                                                              
                                          if (responseBlock) responseBlock(@{@"result": [vos copy]}, error);
                                      });
                   });
    
}

@end
