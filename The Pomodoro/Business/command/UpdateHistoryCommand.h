//
//  UpdateHistoryCommand.h
//  The Pomodoro
//
//  Created by Artur Felipe on 12/3/16.
//  Copyright © 2016 Artur Felipe. All rights reserved.
//


typedef void (^UpdateHistoryResponseBlock) (NSDictionary *result, NSError *error);

@protocol UpdateHistoryCommandDelegate <NSObject>

@required
- (void)command:(id)command didUpdateHistory:(NSArray *)histories WithError:(NSError*)error;

@end

@interface UpdateHistoryCommand : NSObject

@property (nonatomic,weak) id<UpdateHistoryCommandDelegate> delegate;

+ (instancetype)sharedInstance;
+ (void)updateSearch:(HistoryVO *)aHistoryVO WithBlock:(UpdateHistoryResponseBlock)responseBlock;

- (id)initWithDelegate:(id<UpdateHistoryCommandDelegate>)mDelegate;

@end
