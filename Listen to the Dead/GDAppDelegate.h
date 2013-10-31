//
//  GDAppDelegate.h
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import <UIKit/UIKit.h>

@interface GDAppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property UINavigationController *nav;
@property UINavigationController *nowPlayingNav;

@property (nonatomic) BOOL shouldShowNowPlaying;
@property (nonatomic) BOOL isNowPlayingVisible;

- (void)toggleNowPlaying;
- (void)showNowPlaying;

@end
