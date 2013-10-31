//
//  GDYearsViewController.m
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import "GDYearsViewController.h"
#import "GDYearViewController.h"

#import <LastFm/LastFm.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <SVWebViewController/SVWebViewController.h>

#define kAlertLastFm 0
#define kAlertLastFmLogout 0
#define kAlertLastFmLogin 1

@implementation GDYearsViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"Grateful Dead";
	
	[self.tableView registerClass:[UITableViewCell class]
		   forCellReuseIdentifier:@"Cell"];
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Last.FM"
																			 style:UIBarButtonItemStyleDone
																			target:self
																			action:@selector(lastfm)];
}

- (void)lastfm {
	if ([LastFm sharedInstance].username) {
		UIAlertView *a = [[UIAlertView alloc] initWithTitle:[@"You are currently signed into Last.FM as " stringByAppendingString:[LastFm sharedInstance].username]
													message:nil
												   delegate:self
										  cancelButtonTitle:@"Cancel"
										  otherButtonTitles:@"Sign Out", nil];
		a.tag = kAlertLastFmLogout;
		[a show];
	}
	else {
		UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"Sign into your Last.FM account"
													message:nil
												   delegate:self
										  cancelButtonTitle:@"Cancel"
										  otherButtonTitles:@"Sign In", nil];
		a.tag = kAlertLastFmLogin;
		a.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
		[a show];
	}
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
	if(buttonIndex == 0) return;
	
	if(alertView.tag == kAlertLastFmLogout) {
		[[LastFm sharedInstance] logout];
	}
	else if(alertView.tag == kAlertLastFmLogin) {
		UITextField *username = [alertView textFieldAtIndex:0];
		UITextField *password = [alertView textFieldAtIndex:1];
		[SVProgressHUD show];
		[[LastFm sharedInstance] getSessionForUser:username.text
										  password:password.text
									successHandler:^(NSDictionary *result) {
										[SVProgressHUD dismiss];
										// Save the session into NSUserDefaults. It is loaded on app start up in AppDelegate.
										[[NSUserDefaults standardUserDefaults] setObject:result[@"key"] forKey:@"lastfm_session_key"];
										[[NSUserDefaults standardUserDefaults] setObject:result[@"name"] forKey:@"lastfm_username_key"];
										[[NSUserDefaults standardUserDefaults] synchronize];
										
										// Also set the session of the LastFm object
										[LastFm sharedInstance].session = result[@"key"];
										[LastFm sharedInstance].username = result[@"name"];
										
										[SVProgressHUD showSuccessWithStatus:@"Signed in!"];
										
										double delayInSeconds = 3.0;
										dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
										dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
											[SVProgressHUD dismiss];
										});
									}
									failureHandler:^(NSError *error) {
										[SVProgressHUD dismiss];
										UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"Error"
																					message:[error localizedDescription]
																				   delegate:nil
																		  cancelButtonTitle:@"OK"
																		  otherButtonTitles:nil];
										[a show];
									}];

	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
	if(section == 1) {
		return 1;
	}
	
	return [GDAPI sharedAPI].years.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
															forIndexPath:indexPath];
	
	if(indexPath.section == 1) {
		cell.textLabel.text = @"About";
	}
	else {
		cell.textLabel.text = [GDAPI sharedAPI].years[indexPath.row];
	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath
							 animated:YES];
	
	if(indexPath.section == 1) {
		SVModalWebViewController *vc = [[SVModalWebViewController alloc] initWithAddress:@"http://alecgorge.com/dead/#about"];
		[self.navigationController presentViewController:vc
												animated:YES
											  completion:nil];
		return;
	}
	
	NSString *year = [GDAPI sharedAPI].years[indexPath.row];
	GDYearViewController *yearvc = [[GDYearViewController alloc] initWithYear:year];
	
	[self.navigationController pushViewController:yearvc
										 animated:YES];
}

@end
