//
//  HistoryVO.h
//  The Pomodoro
//
//  Created by Artur Felipe on 12/3/16.
//  Copyright © 2016 Artur Felipe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseVO.h"

@interface HistoryVO : BaseVO

@property (nonatomic, retain) NSDate * finishedDate;
@property (nonatomic, retain) NSNumber * state;
@property (nonatomic, retain) NSString * timer;
@property (nonatomic, retain) NSString * uid;

+ (NSDictionary *)initWith:(History*)model;

- (id)initWith:(History*)model;

@end
