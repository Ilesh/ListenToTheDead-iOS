//
//  GDShow.h
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import <Foundation/Foundation.h>

@interface GDPartialShow : NSObject

- (instancetype)initWithDictionary:(NSDictionary*)dict;

@property (nonatomic) NSString *gdID;
@property (nonatomic) NSString *album;
@property (nonatomic) NSString *venue;

@property (nonatomic) NSDate *date;

@property (nonatomic) NSInteger day;
@property (nonatomic) NSInteger month;
@property (nonatomic) NSInteger year;

@property (nonatomic) NSString *shortAlbumName;

@end
