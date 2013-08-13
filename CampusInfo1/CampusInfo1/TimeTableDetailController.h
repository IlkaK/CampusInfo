//
//  TimeTableDetailController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScheduleDto;
@class ScheduleEventDto;
@class ScheduleEventRealizationDto;

@protocol TimeTableDetailViewDelegate <NSObject>
    
-(void)setNewAcronym:(NSString *)newAcronym withAcronymType:(NSString *)newAcronymType;

@end


@interface TimeTableDetailController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    id                         _timeTableDetailViewDelegate;
    ScheduleEventDto          *_scheduleEvent;
    
    IBOutlet UITableView      *_detailTable;
    IBOutlet UITableViewCell  *_detailTableCell;
    IBOutlet UITableViewCell  *_detailTableCellWithButton;
    
    // titel labels
    IBOutlet UILabel            *_titleLabel;
    IBOutlet UILabel            *_timeLabel;
    IBOutlet UILabel            *_timeTableDescriptionLabel;
    IBOutlet UIButton           *_backButton;
    IBOutlet UILabel            *_backLabel;
    
    NSString                  *_timeString;
    NSString                  *_dayAndAcronymString;


}

@property (nonatomic, retain) id<TimeTableDetailViewDelegate> _timeTableDetailViewDelegate;
@property (nonatomic, retain) ScheduleEventDto               *_scheduleEvent;
@property (nonatomic, retain) IBOutlet UITableView           *_detailTable;
@property (nonatomic, retain) IBOutlet UITableViewCell       *_detailTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell       *_detailTableCellWithButton;

@property (nonatomic, retain) IBOutlet UILabel               *_titleLabel;
@property (nonatomic, retain) IBOutlet UILabel               *_timeLabel;
@property (nonatomic, retain) IBOutlet UILabel               *_timeTableDescriptionLabel;
@property (nonatomic, retain) IBOutlet UILabel               *_backLabel;
@property (nonatomic, retain) IBOutlet UIButton              *_backButton;

@property (nonatomic, retain) NSString                       *_timeString;
@property (nonatomic, retain) NSString                       *_dayAndAcronymString;


-(void)setNavigationTitle:(NSString *)titleString;

- (IBAction)moveBackToTimeTable:(id)sender;

@end
