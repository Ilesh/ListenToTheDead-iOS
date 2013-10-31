//
//  GDYearViewController.m
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import "GDYearViewController.h"
#import "GDShowController.h"

@implementation GDYearViewController

- (instancetype)initWithYear:(NSString *)year {
	if (self = [super initWithStyle:UITableViewStylePlain]) {
		self.title = year;
		self.showYear = year;
	}
	return self;
}

- (void)refresh:(id)sender {
	[[GDAPI sharedAPI] showsForYear:self.showYear
							success:^(GDYear *year) {
								self.year = year;
								
								[super refresh:sender];
								[self.tableView reloadData];
							}];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return self.year == nil ? 0 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
	return self.year.shows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	
	if(!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									  reuseIdentifier:@"Cell"];
	}
	
	GDPartialShow *show = self.year.shows[indexPath.row];
	
	cell.textLabel.text = show.shortAlbumName;
	cell.detailTextLabel.text = show.venue;
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath
							 animated:YES];
	
	GDPartialShow *partial = self.year.shows[indexPath.row];
	
	GDShowController *showvc = [[GDShowController alloc] initWithPartialShow:partial];
	[self.navigationController pushViewController:showvc
										 animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return tableView.rowHeight * 1.2;
}

@end
