//
//  DeleteHistoryCommand.h
//  The Pomodoro
//
//  Created by Artur Felipe on 12/3/16.
//  Copyright © 2016 Artur Felipe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DeleteHistoryResponseBlock) (NSDictionary *result, NSError *error);

@protocol DeleteHistoryCommandDelegate <NSObject>

@required
- (void)command:(id)command didDeleteHistory:(NSArray *)histories WithError:(NSError*)error;

@end

@interface DeleteHistoryCommand : NSObject

@property (nonatomic,weak) id<DeleteHistoryCommandDelegate> delegate;

+ (instancetype)sharedInstance;
+ (void)deleteSearch:(HistoryVO *)aHistoryVO WithBlock:(DeleteHistoryResponseBlock)responseBlock;

- (id)initWithDelegate:(id<DeleteHistoryCommandDelegate>)mDelegate;

@end
