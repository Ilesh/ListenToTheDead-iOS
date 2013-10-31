//
//  GDStreamingPlaylistItem.m
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/23/13.
//
//

#import "GDStreamingPlaylistItem.h"

@implementation GDStreamingPlaylistItem

- (id)initWithTrack:(GDTrack*)track {
	if (self = [super init]) {
		self.track = track;
	}
	return self;
}

- (NSString *)title {
	return self.track.title;
}

- (NSString *)subtitle {
	return self.track.show.album;
}

- (NSTimeInterval)duration {
	return self.track.duration;
}

- (NSURL *)file {
	return self.track.url;
}

- (NSString *)artist {
	return @"Grateful Dead";
}

- (NSString *)shareTitle {
	static NSString *sub = nil;
	if(sub == nil) {
		sub = [NSString stringWithFormat: @"#nowplaying %@ - %@ - Grateful Dead via Listen to the Dead by @alecgorge", self.title, self.track.show.shortAlbumName, nil];
	}
	
	return sub;
}

- (NSURL *)shareURL {
	static NSURL *sub = nil;
	if(sub == nil) {
		sub = [NSURL URLWithString: [NSString stringWithFormat:@"https://listentothedead.com/%ld/%ld/%ld", (long)self.track.show.year, (long)self.track.show.month, (long)self.track.show.day, nil]];
	}
	
	return sub;
}

@end
