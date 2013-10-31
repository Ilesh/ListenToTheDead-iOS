//
//  GDAppDelegate.m
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import "GDAppDelegate.h"
#import "GDYearsViewController.h"

#import <LastFm/LastFm.h>

#import <Crashlytics/Crashlytics.h>

@implementation GDAppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[Crashlytics startWithAPIKey:@"bbdd6a4df81e6b1498130a0f1fbf72d14e334fb4"];
	
	[self setupFlurry];
	[self setupLastFM];
	[self setupCaching];
//	[self setupAppearance];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	self.shouldShowNowPlaying = NO;
    
	self.window.backgroundColor = [UIColor whiteColor];
	
	GDYearsViewController *years = [[GDYearsViewController alloc] initWithStyle:UITableViewStyleGrouped];
	self.nav = [[UINavigationController alloc] initWithRootViewController:years];
	self.nav.delegate = self;
	self.nav.navigationBar.translucent = NO;
	self.window.rootViewController = self.nav;
	
    [self.window makeKeyAndVisible];
	[self setupNowPlaying];
    
    return YES;
}

- (void)setupAppearance {
	UIColor *gd = [UIColor colorWithRed:252.0f/255.0f
								  green:196.0f/255.0f
								   blue:7.0f/255.0f
								  alpha:0];
	UIColor *brown = [UIColor colorWithRed:119.0f/255.0f
									 green:65.0f/255.0f
									  blue:23.0f/255.0f
									 alpha:0];
	
	if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
		[UINavigationBar appearance].barTintColor = gd;
		self.window.tintColor = brown;
//		[UINavigationBar appearance].tintColor = brown;
	}
	else {
		[UINavigationBar appearance].tintColor = gd;
		[UINavigationBar appearance].titleTextAttributes = @{UITextAttributeTextColor: brown};
		[UIBarButtonItem appearance].tintColor = brown;
	}
}

- (void)setupFlurry {
	[Flurry setBackgroundSessionEnabled:NO];
	[Flurry startSession:@"4RGRH573MCY85Z5RJC2X"];
}

- (void)setShouldShowNowPlaying:(BOOL)s {
	_shouldShowNowPlaying = s;
	if(!s) return;
	[self navigationController:self.nav
		willShowViewController:self.nav.visibleViewController
					  animated:YES];
}

- (void)setupCaching {
	[[NSURLCache sharedURLCache] setMemoryCapacity:1024 * 1024 * 10];
	[[NSURLCache sharedURLCache] setDiskCapacity:1024 * 1024 * 256];
}

- (void)setupLastFM {
    [LastFm sharedInstance].apiKey = @"ebe91b42403e54b1713e8be22c274153";
    [LastFm sharedInstance].apiSecret = @"ea6441545657ca4a90b7363af7cb92d5";
    [LastFm sharedInstance].session = [[NSUserDefaults standardUserDefaults] stringForKey:@"lastfm_session_key"];
    [LastFm sharedInstance].username = [[NSUserDefaults standardUserDefaults] stringForKey:@"lastfm_username_key"];
}

- (void)navigationController:(UINavigationController *)navigationController
	  willShowViewController:(UIViewController *)viewController
					animated:(BOOL)animated {
	if(!self.shouldShowNowPlaying) return;
	UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Player"
															   style:UIBarButtonItemStyleDone
															  target:self
															  action:@selector(nowPlaying)];
	
    viewController.navigationItem.rightBarButtonItem = button;
}

- (void)setupNowPlaying {
	StreamingMusicViewController *nowPlaying = [StreamingMusicViewController sharedInstance];
	self.nowPlayingNav = [[UINavigationController alloc] initWithRootViewController:nowPlaying];
}


- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"RemoteControlEventReceived"
														object:event];
}

- (void)nowPlaying {
	[self.nav presentViewController:self.nowPlayingNav
						   animated:YES
						 completion:^{}];
}

- (void)toggleNowPlaying {
	[self nowPlaying];
}

- (void)showNowPlaying {
	self.isNowPlayingVisible = NO;
	[self nowPlaying];
}

@end
