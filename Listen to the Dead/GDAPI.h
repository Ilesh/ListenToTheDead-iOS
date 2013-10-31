//
//  GDAPI.h
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import "AFHTTPClient.h"

#import "GDYear.h"
#import "GDShow.h"
#import "GDPartialShow.h"

@interface GDAPI : AFHTTPClient

+ (instancetype) sharedAPI;

@property (nonatomic) NSArray *years;

- (void)showsForYear:(NSString*)year
			 success:(void(^)(GDYear *year))success;

- (void)showDetailsForPartialShow:(GDPartialShow *)partial
						  success:(void(^)(GDShow *show))success;

@end
