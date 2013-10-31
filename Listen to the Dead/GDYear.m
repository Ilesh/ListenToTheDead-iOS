//
//  GDYear.m
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import "GDYear.h"

@implementation GDYear

- (instancetype)initWithDictionary:(NSDictionary *)dict {
	if (self = [super init]) {
		self.gdID = dict[@"_id"];
		self.year = [dict[@"year"] stringValue];
		
		NSMutableArray *arr = [NSMutableArray array];
		for (NSDictionary *d in dict[@"_days"]) {
			[arr addObject:[[GDPartialShow alloc] initWithDictionary:d]];
		}
		self.shows = arr;
	}
	return self;
}

@end
