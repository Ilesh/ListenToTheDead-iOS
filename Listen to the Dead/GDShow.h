//
//  GDShow.h
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import <Foundation/Foundation.h>
#import "GDTrack.h"

@interface GDShow : NSObject

- (instancetype)initWithDictionary:(NSDictionary*)dict;

@property (nonatomic) NSString *gdID;
@property (nonatomic) NSString *album;
@property (nonatomic) NSString *venue;

@property (nonatomic) NSString *server;
@property (nonatomic) NSString *title;

@property (nonatomic) NSDate *date;

@property (nonatomic) NSInteger day;
@property (nonatomic) NSInteger month;
@property (nonatomic) NSInteger year;

@property (nonatomic) NSInteger numberOfReviews;
@property (nonatomic) float reviewAverage;

@property (nonatomic) NSArray *notes;
@property (nonatomic) NSArray *transferer;
@property (nonatomic) NSArray *taper;
@property (nonatomic) NSArray *coverages;
@property (nonatomic) NSArray *lineages;
@property (nonatomic) NSArray *sources;
@property (nonatomic) NSArray *pubDates;

@property (nonatomic) NSArray *tracks;

@property (nonatomic) NSString *shortAlbumName;

@end
