//
//  HistoryVO.m
//  The Pomodoro
//
//  Created by Artur Felipe on 12/3/16.
//  Copyright © 2016 Artur Felipe. All rights reserved.
//

#import "HistoryVO.h"
#import "History.h"

@implementation HistoryVO

- (id)initWith:(History*)model
{
    self = [super init];
    
    if (self)
    {
        self.finishedDate = model.finishedDate;
        self.lastUpdated = model.lastUpdated;
        self.state = model.state;
        self.timer = model.timer;
        self.uid = model.uid;
    }
    
    return self;
}

+ (NSDictionary *)initWith:(History*)model
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:model.lastUpdated forKey:@"lastUpdated"];
    [dict setObject:model.finishedDate forKey:@"finishedDate"];
    [dict setObject:model.state forKey:@"state"];
    [dict setObject:model.timer forKey:@"timer"];
    [dict setObject:model.uid forKey:@"uid"];
    
    return dict;
}

@end
