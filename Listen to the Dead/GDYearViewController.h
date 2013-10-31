//
//  GDYearViewController.h
//  Listen to the Dead
//
//  Created by Alec Gorge on 9/22/13.
//
//

#import "GDRefreshableTableViewController.h"

@interface GDYearViewController : GDRefreshableTableViewController

- (instancetype)initWithYear:(NSString*)year;

@property (nonatomic) NSString *showYear;
@property (nonatomic) GDYear *year;

@end
