//
//  GDTrack.m
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import "GDTrack.h"

@implementation GDTrack

- (instancetype)initWithDictionary:(NSDictionary *)dict
						   andShow:(GDShow *)show {
	if (self = [super init]) {
		self.gdID = dict[@"_id"];
		
		self.title = dict[@"title"];
		self.url = [NSURL URLWithString: [@"http:" stringByAppendingString:dict[@"url"]]];
		
		self.show = show;
		self.size = [dict[@"size"] integerValue];
		
		self.duration = [dict[@"duration"] integerValue];
		self.humanDuration = [self formatTime:self.duration];
	}
	return self;
}

- (NSString *)formatTime:(NSTimeInterval)dur {
	int totalSeconds = floor(dur);
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
	
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

@end
