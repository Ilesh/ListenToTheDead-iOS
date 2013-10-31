//
//  GDShow.m
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import "GDShow.h"

@implementation GDShow

- (instancetype)initWithDictionary:(NSDictionary *)dict {
	if (self = [super init]) {
		self.gdID = dict[@"show"][@"_id"];
		
		self.album = dict[@"show"][@"album"];
		self.venue = dict[@"venue"];
		
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:SS'.000Z'";
		
		self.date = [dateFormatter dateFromString:dict[@"show"][@"date"]];
		
		self.day = [dict[@"show"][@"day"] integerValue];
		self.month = [dict[@"show"][@"month"] integerValue];
		self.year = [dict[@"show"][@"year"] integerValue];
		
		self.numberOfReviews = [dict[@"show"][@"total_reviews"] integerValue];
		self.reviewAverage = [dict[@"show"][@"avg"] floatValue];
		
		self.notes = dict[@"show"][@"notes"];
		self.transferer = dict[@"show"][@"transferer"];
		self.taper = dict[@"show"][@"taper"];
		self.lineages = dict[@"show"][@"lineage"];
		self.sources = dict[@"show"][@"source"];
		self.coverages = dict[@"show"][@"coverage"];
		self.pubDates = dict[@"show"][@"publicdate"];
		
		NSMutableArray *arr = [NSMutableArray array];
		for (NSDictionary *d in dict[@"show"][@"_songs"]) {
			[arr addObject:[[GDTrack alloc] initWithDictionary:d
													   andShow:self]];
		}
		self.tracks = arr;
		
		self.shortAlbumName = [NSString stringWithFormat:@"%ld/%ld/%ld", (long)self.month, (long)self.day, (long)self.year];
	}
	return self;
}

@end
