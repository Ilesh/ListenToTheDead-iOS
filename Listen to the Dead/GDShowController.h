//
//  GDShowController.h
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import "GDRefreshableTableViewController.h"
#import "GDAppDelegate.h"

@interface GDShowController : GDRefreshableTableViewController

- (instancetype)initWithPartialShow:(GDPartialShow*)show;

@property (nonatomic) GDPartialShow *partialShow;
@property (nonatomic) GDShow *show;

@end
