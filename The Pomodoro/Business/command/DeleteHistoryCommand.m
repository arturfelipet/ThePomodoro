//
//  DeleteHistoryCommand.m
//  The Pomodoro
//
//  Created by Artur Felipe on 12/3/16.
//  Copyright © 2016 Artur Felipe. All rights reserved.
//

#import "DeleteHistoryCommand.h"

@implementation DeleteHistoryCommand

+ (instancetype)sharedInstance
{
    static DeleteHistoryCommand *instance = nil;
    static dispatch_once_t onceToken;
    
    if (instance) return instance;
    
    dispatch_once(&onceToken, ^{
        instance = [DeleteHistoryCommand alloc];
        instance = [instance init];
    });
    
    return instance;
}

- (id)initWithDelegate:(id<DeleteHistoryCommandDelegate>)mDelegate
{
    self = [self init];
    if (self)
    {
        self.delegate = mDelegate;
    }
    return self;
}

+ (void)deleteSearch:(HistoryVO *)aHistoryVO WithBlock:(DeleteHistoryResponseBlock)responseBlock{
    dispatch_queue_t backgroundQueue = dispatch_queue_create([[NSString stringWithFormat:@"ThePomodoro.%@", NSStringFromClass([self class])] UTF8String], NULL);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_async(backgroundQueue, ^
                   {
                       NSError *error;
                       BOOL success = NO;
                       NSMutableArray *deletedArray = [[NSMutableArray alloc] init];
                       
                       [DAOFactory configDatabaseManager];
                       
                       id result = [[DatabaseManager sharedInstance] fetchData:ENTITY_HISTORY predicate:[NSPredicate predicateWithFormat:@"ANY uid == %@ and lastUpdated == %@", aHistoryVO.uid, aHistoryVO.lastUpdated] offset:0 limit:0 sortBy:nil ascending:YES error:&error];
                       
                       if(result){
                           if([result isKindOfClass:[NSArray class]]){
                               if(((NSSet *)result).count > 0){
                                   for(History *aHistory in result){
                                       [[DatabaseManager sharedInstance] deleteObject:aHistory error:&error];
                                       
                                       [deletedArray addObject:[[HistoryVO alloc] initWith:aHistory]];
                                   }
                                   
                                   if(!error){
                                       success = YES;
                                   }
                               }
                           }
                       }
                       
                       dispatch_async(mainQueue, ^
                                      {
                                          if (responseBlock) responseBlock(@{@"result": [deletedArray copy]}, error);
                                      });
                   });
}

@end
