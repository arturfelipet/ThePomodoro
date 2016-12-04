//
//  InsertHistoryCommand.h
//  The Pomodoro
//
//  Created by Artur Felipe on 12/3/16.
//  Copyright © 2016 Artur Felipe. All rights reserved.
//

typedef void (^InsertHistoryResponseBlock) (NSDictionary *result, NSError *error);

@protocol InsertHistoryCommandDelegate <NSObject>

@required
- (void)command:(id)command didInsertSearch:(History *)aHistory WithError:(NSError*)error;

@end


@interface InsertHistoryCommand : NSObject

@property (nonatomic,weak) id<InsertHistoryCommandDelegate> delegate;

+ (instancetype)sharedInstance;
+ (void)createHistoryWithTitle:(NSString *)timer withState:(NSNumber *)state withBlock:(InsertHistoryResponseBlock)responseBlock;

- (id)initWithDelegate:(id<InsertHistoryCommandDelegate>)mDelegate;

@end
