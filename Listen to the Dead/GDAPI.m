//
//  GDAPI.m
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import "GDAPI.h"

@implementation GDAPI

+ (instancetype) sharedAPI {
    static dispatch_once_t once;
    static GDAPI *sharedFoo;
    dispatch_once(&once, ^ {
		sharedFoo = [[self alloc] initWithBaseURL:[NSURL URLWithString:GD_API_BASE]];
		
		NSMutableArray *arr = [NSMutableArray array];
		for (int i = 1965; i <= 1995; i++) {
			[arr addObject:[NSString stringWithFormat:@"%d", i]];
		}
		
		sharedFoo.years = arr;
	});
    return sharedFoo;
}

- (void)showsForYear:(NSString*)year
			 success:(void(^)(GDYear *year))success {
	[self getPath:year
	   parameters:nil
		  success:^(AFHTTPRequestOperation *operation, id responseObject) {
			  NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject
																   options:0
																	 error:nil];
			  success([[GDYear alloc] initWithDictionary:dict]);
		  }
		  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
			  [self error:error];
		  }];
}

- (void)showDetailsForPartialShow:(GDPartialShow *)partial
						  success:(void (^)(GDShow *))success {
	[self getPath:[NSString stringWithFormat:@"%ld/%ld/%ld", (long)partial.year, (long)partial.month, (long)partial.day, nil]
	   parameters:nil
		  success:^(AFHTTPRequestOperation *operation, id responseObject) {
			  NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject
																   options:0
																	 error:nil];
			  success([[GDShow alloc] initWithDictionary:dict]);

		  }
		  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
			  [self error:error];
		  }];
}

- (void)error:(NSError*)err {
	UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"Error"
												message:err.localizedDescription
											   delegate:nil
									  cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
	[a show];
}

@end
