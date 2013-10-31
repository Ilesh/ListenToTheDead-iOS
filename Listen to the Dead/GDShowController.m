//
//  GDShowController.m
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import "GDShowController.h"
#import "GDRecordingInfoController.h"
#import "GDStreamingPlaylistItem.h"

typedef enum showInfoRow {
	kShowVenueRow		  = 0,
	kShowRatingRow		  = 1,
	kShowSourceRow		  = 2,
	kShowRecordingInfoRow = 3
} ShowInfoRow;

typedef enum showSection {
	kShowInfoSection	  = 0,
	kShowTracksSection	  = 1
} ShowSection;

@implementation GDShowController

- (instancetype)initWithPartialShow:(GDPartialShow *)show {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		self.partialShow = show;
		self.title = show.shortAlbumName;
	}
	return self;
}

- (void)refresh:(id)sender {
	[[GDAPI sharedAPI] showDetailsForPartialShow:self.partialShow
										 success:^(GDShow *show) {
											 self.show = show;
											 
											 [super refresh:sender];
											 [self.tableView reloadData];
										 }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return self.show == nil ? 0 : 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
	if (section == kShowInfoSection) {
		return 4;
	}
	return self.show.tracks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	
	if(!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
									  reuseIdentifier:@"Cell"];
	}
	
	if(indexPath.section == kShowInfoSection) {
		if(indexPath.row == kShowVenueRow) {
			cell.textLabel.text = self.show.venue;
			cell.detailTextLabel.text = @"";
			cell.accessoryType = UITableViewCellAccessoryNone;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
		else if(indexPath.row == kShowRatingRow) {
			cell.textLabel.text = @"Rating";
			
			NSString *revStr = [NSString stringWithFormat:@"%.2f/5.00, %ld review(s)", self.show.reviewAverage, (long)self.show.numberOfReviews];
			
			cell.detailTextLabel.text = revStr;
			
			cell.accessoryType = UITableViewCellAccessoryNone;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
		else if(indexPath.row == kShowSourceRow) {
			cell.textLabel.text = @"Source";
			cell.detailTextLabel.text = self.show.sources.count > 0 ? self.show.sources[0] : @"";
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			cell.selectionStyle = UITableViewCellSelectionStyleDefault;
		}
		else if(indexPath.row == kShowRecordingInfoRow) {
			cell.textLabel.text = @"Recording Info";
			cell.detailTextLabel.text = @"";
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			cell.selectionStyle = UITableViewCellSelectionStyleDefault;
		}
		
		return cell;
	}
	
	GDTrack *track = self.show.tracks[indexPath.row];
	
	cell.textLabel.text = track.title;
	cell.textLabel.adjustsFontSizeToFitWidth = YES;
	cell.textLabel.numberOfLines = 2;
	
	cell.detailTextLabel.text = track.humanDuration;
	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.selectionStyle = UITableViewCellSelectionStyleDefault;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath
							 animated:YES];
	
	if(indexPath.section == kShowInfoSection) {
		if(indexPath.row == kShowRecordingInfoRow || indexPath.row == kShowSourceRow) {
			GDRecordingInfoController *vc = [[GDRecordingInfoController alloc] initWithShow:self.show];
			[self.navigationController pushViewController:vc
												 animated:YES];
		}
		return;
	}
	
	((GDAppDelegate*)[UIApplication sharedApplication].delegate).shouldShowNowPlaying = YES;
	StreamingMusicViewController *newPlayer = [StreamingMusicViewController sharedInstance];
	
	NSMutableArray *playlist = [NSMutableArray array];
	for(GDTrack *song in self.show.tracks) {
		StreamingPlaylistItem *item = [[GDStreamingPlaylistItem alloc] initWithTrack:song];
		
		[playlist addObject: item];
	}
	
	[newPlayer changePlaylist:playlist
			andStartFromIndex:indexPath.row];
	
	
	[((GDAppDelegate *)[UIApplication sharedApplication].delegate) navigationController:self.navigationController
															   willShowViewController:self
																			 animated:YES];
	
	[((GDAppDelegate *)[UIApplication sharedApplication].delegate) showNowPlaying];
}


@end
