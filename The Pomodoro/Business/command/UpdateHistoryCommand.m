//
//  UpdateHistoryCommand.m
//  The Pomodoro
//
//  Created by Artur Felipe on 12/3/16.
//  Copyright © 2016 Artur Felipe. All rights reserved.
//

#import "UpdateHistoryCommand.h"

@implementation UpdateHistoryCommand

+ (instancetype)sharedInstance
{
    static UpdateHistoryCommand *instance = nil;
    static dispatch_once_t onceToken;
    
    if (instance) return instance;
    
    dispatch_once(&onceToken, ^{
        instance = [UpdateHistoryCommand alloc];
        instance = [instance init];
    });
    
    return instance;
}

- (id)initWithDelegate:(id<UpdateHistoryCommandDelegate>)mDelegate
{
    self = [self init];
    if (self)
    {
        self.delegate = mDelegate;
    }
    return self;
}

+ (void)updateSearch:(HistoryVO *)aHistoryVO WithBlock:(UpdateHistoryResponseBlock)responseBlock{
    dispatch_queue_t backgroundQueue = dispatch_queue_create([[NSString stringWithFormat:@"ThePomodoro.%@", NSStringFromClass([self class])] UTF8String], NULL);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_async(backgroundQueue, ^
                   {
                       
                       NSError *error;
                       BOOL success = NO;
                       NSMutableArray *updatedArray = [[NSMutableArray alloc] init];
                       
                       [DAOFactory configDatabaseManager];
                       
                       id result = [[DatabaseManager sharedInstance] fetchData:ENTITY_HISTORY
                                                                     predicate:[NSPredicate predicateWithFormat:@"ANY uid == %@ and lastUpdated == %@", aHistoryVO.uid, aHistoryVO.lastUpdated] offset:0 limit:0 sortBy:nil ascending:YES error:&error];
                       
                       if(result){
                           if([result isKindOfClass:[NSArray class]]){
                               if(((NSArray *)result).count > 0){
                                   for(History *aHistory in result){
                                       aHistory.timer = aHistoryVO.timer;
                                       aHistory.lastUpdated = [NSDate date];
                                       aHistory.finishedDate = aHistoryVO.finishedDate;
                                       aHistory.state = aHistoryVO.state;
                                       aHistory.uid = aHistoryVO.uid;
                                       
                                       [[DatabaseManager sharedInstance] saveContext:&error];
                                       
                                       id result = [[DatabaseManager sharedInstance] fetchData:ENTITY_HISTORY predicate:[NSPredicate predicateWithFormat:@"ANY uid == %@ and lastUpdated == %@", aHistory.uid, aHistory.lastUpdated] offset:0 limit:0 sortBy:nil ascending:YES error:&error];
                                       
                                       if(result){
                                           if([result isKindOfClass:[NSArray class]]){
                                               if(((NSArray *)result).count > 0){
                                                   for(History *aHistory in result){
                                                       [updatedArray addObject:[[HistoryVO alloc] initWith:aHistory]];
                                                   }
                                               }
                                           }
                                       }
                                   }
                                   
                                   if(!error){
                                       success = YES;
                                   }
                               }
                           }
                           
                           dispatch_async(mainQueue, ^
                                          {
                                              if (responseBlock) responseBlock(@{@"result": [updatedArray copy]}, error);
                                          });
                       }
                       else{
                           dispatch_async(mainQueue, ^
                                          {
                                              if (responseBlock) responseBlock(nil, error);
                                          });
                       }
                   });

}

@end
