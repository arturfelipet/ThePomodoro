//
//  ViewFactory.m
//  The Pomodoro
//
//  Created by Artur Felipe on 12/3/16.
//  Copyright © 2016 Artur Felipe. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewFactory.h"


@interface ViewFactory(){
    
}

@property (nonatomic, strong) UIStoryboard *sb;
@property (nonatomic, strong) UIViewController *homeViewController;

@end


@implementation ViewFactory

@synthesize sb;

+ (instancetype)sharedInstance
{
    static ViewFactory *instance = nil;
    static dispatch_once_t onceToken;
    
    if (instance) return instance;
    
    dispatch_once(&onceToken, ^{
        instance = [ViewFactory alloc];
        instance = [instance init];
    });
    
    return instance;
}

//This method would create the first view controller that at some cases could be a login, a home or others.
- (UIViewController*)createFirstViewController
{
    sb = [UIStoryboard storyboardWithName:kSTORYBOARD_MAIN bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"AboutViewController"];
    return vc;
}

- (UIViewController*)createAboutViewController
{
    sb = [UIStoryboard storyboardWithName:kSTORYBOARD_MAIN bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"AboutViewController"];
    return vc;
}

- (void)dealloc{
    DLog(@"%@ dealloced !!!" , NSStringFromClass([self class]));
}

@end
