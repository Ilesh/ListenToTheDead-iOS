//
//  GDStreamingPlaylistItem.h
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/23/13.
//
//

#import "StreamingPlaylistItem.h"
#import "GDTrack.h"

@interface GDStreamingPlaylistItem : StreamingPlaylistItem

@property GDTrack *track;

- (id)initWithTrack:(GDTrack*)track;

@end
