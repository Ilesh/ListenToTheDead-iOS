//
//  GDRecordingInfoController.m
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import "GDRecordingInfoController.h"

@implementation GDRecordingInfoController

- (instancetype)initWithShow:(GDShow *)show {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		self.show = show;
		self.title = @"Recording Info";
		
		[self.tableView registerClass:[UITableViewCell class]
			   forCellReuseIdentifier:@"Cell"];
	}
	return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
	if(section == 0) {
		return @"Notes";
	}
	return @"Source";
}

-  (NSInteger)tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
															forIndexPath:indexPath];
	
	NSString *text = @"";
	if(indexPath.section == 0) {
		if(self.show.notes.count > 0) {
			text = self.show.notes[0];
		}
	}
	else {
		if(self.show.sources.count > 0) {
			text = self.show.sources[0];
		}
	}
	
	cell.textLabel.text = text;
	cell.textLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
	cell.textLabel.numberOfLines = 0;
	
    CGSize constraintSize = CGSizeMake(self.tableView.bounds.size.width, MAXFLOAT);
    CGSize labelSize = [cell.textLabel.text sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]
									   constrainedToSize:constraintSize
										   lineBreakMode:NSLineBreakByWordWrapping];
	
	cell.textLabel.frame = CGRectMake(cell.textLabel.frame.origin.x, cell.textLabel.frame.origin.y,
											labelSize.width, labelSize.height);
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *text = @"";
	if(indexPath.section == 0) {
		if(self.show.notes.count > 0) {
			text = self.show.notes[0];
		}
	}
	else {
		if(self.show.sources.count > 0) {
			text = self.show.sources[0];
		}
	}
	
    CGSize labelSize = [text sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]
						constrainedToSize:CGSizeMake(self.tableView.bounds.size.width, MAXFLOAT)
							lineBreakMode:NSLineBreakByWordWrapping];
	
	return labelSize.height + tableView.rowHeight;
}

@end
