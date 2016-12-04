//
//  ListHistoryCommand.h
//  The Pomodoro
//
//  Created by Artur Felipe on 12/3/16.
//  Copyright © 2016 Artur Felipe. All rights reserved.
//

typedef void (^ListHistoryResponseBlock) (NSDictionary *result, NSError *error);

@protocol ListHistoryCommandDelegate <NSObject>

@required
- (void)command:(id)command didListHistories:(NSArray *) histories WithError:(NSError*)error;

@end


@interface ListHistoryCommand : NSObject

@property (nonatomic,weak) id<ListHistoryCommandDelegate> delegate;

+ (instancetype)sharedInstance;
+ (void)listHistoriesWithBlock:(ListHistoryResponseBlock)responseBlock;

- (id)initWithDelegate:(id<ListHistoryCommandDelegate>)mDelegate;

@end
