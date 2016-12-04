//
//  ViewFactory.h
//  The Pomodoro
//
//  Created by Artur Felipe on 12/3/16.
//  Copyright © 2016 Artur Felipe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewFactory : NSObject

+ (instancetype)sharedInstance;

- (UIViewController*)createFirstViewController;
- (UIViewController*)createAboutViewController;

@end
