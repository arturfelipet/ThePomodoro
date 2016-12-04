//
//  Config.h
//  The Pomodoro
//
//  Created by Artur Felipe on 12/3/16.
//  Copyright © 2016 Artur Felipe. All rights reserved.
//

typedef enum{
    stateReady = 0,
    stateRunning,
    stateStopped,
    stateFinished
} PomodoroStateType;

#define kAPP_NAME                   @"The Pomodoro"
#define kAPP_ID                     @"950765891"
#define kAppstoreUrl                [NSString stringWithFormat:@"%@%@%@",@"itms-apps://itunes.apple.com/app/id",kAPP_ID,@"?mt=8"]
#define kAppStoreSearchUrl          @"http://itunes.apple.com/lookup?id="

#define kSTORYBOARD_MAIN            @"MainStoryboard"

#define kdefaultThemeFont(asize) [UIFont fontWithName:@"Lato-Regular" size:asize]
#define kdefaultThemeFontBold(asize) [UIFont fontWithName:@"Lato-Bold" size:asize]
#define kdefaultThemeFontItalic(asize) [UIFont fontWithName:@"Lato-Italic" size:asize]
#define kdefaultThemeFontLight(asize) [UIFont fontWithName:@"Lato-Light" size:asize]


//Colors
#define COLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//UIColorFromRGB(0x184fa2)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromImg(img) [UIColor colorWithPatternImage: [UIImage imageNamed: img]]
#define UIColorFromImgAndAlpha(img, alpha) [UIColorFromImg(img) colorWithAlphaComponent:alpha]


#define kColorBGViews                       UIColorFromImgAndAlpha(@"bg_views", 1.0)
#define kColorMainTheme                     UIColorFromImgAndAlpha(@"bg_theme_color", 1.0)


#define USE_TEST_STORYBOARD         0
#define STORYBOARD_NAME             @"MainStoryboard"

#define kAlreadyLogged                      0
#define kDebugMode                          1
#define kShowDebugMessages                  0
#define kDemoMode                           1





