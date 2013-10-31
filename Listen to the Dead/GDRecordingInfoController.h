//
//  GDRecordingInfoController.h
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import <UIKit/UIKit.h>

@interface GDRecordingInfoController : UITableViewController

- (instancetype)initWithShow:(GDShow*)show;

@property (nonatomic) GDShow *show;

@end
