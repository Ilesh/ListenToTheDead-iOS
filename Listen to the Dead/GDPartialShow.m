//
//  GDShow.m
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import "GDPartialShow.h"

@implementation GDPartialShow

- (instancetype)initWithDictionary:(NSDictionary *)dict {
	if (self = [super init]) {
		self.gdID = dict[@"_id"];
		
		self.album = dict[@"album"];
		self.venue = dict[@"venue"];
		
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:SS'.000Z'";
		
		self.date = [dateFormatter dateFromString:dict[@"date"]];
		
		self.day = [dict[@"day"] integerValue];
		self.month = [dict[@"month"] integerValue];
		self.year = [dict[@"year"] integerValue];
		
		self.shortAlbumName = [NSString stringWithFormat:@"%ld/%ld/%ld", (long)self.month, (long)self.day, (long)self.year];
	}
	return self;
}

@end
