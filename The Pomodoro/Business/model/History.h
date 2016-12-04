//
//  History.h
//  The Pomodoro
//
//  Created by Artur Felipe on 12/3/16.
//  Copyright © 2016 Artur Felipe. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface History : NSManagedObject

@property (nonatomic, retain) NSDate * finishedDate;
@property (nonatomic, retain) NSDate * lastUpdated;
@property (nonatomic, retain) NSNumber * state;
@property (nonatomic, retain) NSString * timer;
@property (nonatomic, retain) NSString * uid;

@end
