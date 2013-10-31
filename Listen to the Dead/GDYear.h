//
//  GDYear.h
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import <Foundation/Foundation.h>
#import "GDPartialShow.h"

@interface GDYear : NSObject

- (instancetype)initWithDictionary:(NSDictionary*)dict;

@property (nonatomic) NSString *gdID;
@property (nonatomic) NSString *year;
@property (nonatomic) NSArray *shows;

@end
