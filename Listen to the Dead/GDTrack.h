//
//  GDTrack.h
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import <Foundation/Foundation.h>

@class GDShow;

@interface GDTrack : NSObject

- (instancetype)initWithDictionary:(NSDictionary*)dict andShow:(GDShow*)show;

@property (nonatomic) NSString *gdID;

@property (nonatomic) NSString *title;
@property (nonatomic) NSURL *url;

@property (nonatomic) GDShow *show;

@property (nonatomic) NSInteger size;

@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) NSString *humanDuration;

- (NSString *)formatTime:(NSTimeInterval)dur;

@end
