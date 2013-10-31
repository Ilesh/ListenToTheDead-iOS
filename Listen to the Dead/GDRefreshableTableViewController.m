//
//  GDRefreshableTableViewController.m
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import "GDRefreshableTableViewController.h"

@implementation GDRefreshableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIRefreshControl *c = [[UIRefreshControl alloc] init];
	[c addTarget:self
		  action:@selector(refresh:)
forControlEvents:UIControlEventValueChanged];
	self.refreshControl = c;
	[self beginRefreshingTableView];
	
	[self refresh: self.refreshControl];
}

- (void)refresh:(id)sender {
	[sender endRefreshing];
}

- (void)beginRefreshingTableView {
	
    [self.refreshControl beginRefreshing];
	
    if (self.tableView.contentOffset.y == 0) {
		
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^(void){
			
            self.tableView.contentOffset = CGPointMake(0, -self.refreshControl.frame.size.height);
			
        } completion:^(BOOL finished){
			
        }];
		
    }
}

@end
