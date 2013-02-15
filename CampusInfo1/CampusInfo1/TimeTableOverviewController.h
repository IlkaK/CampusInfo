//
//  TimeTableOverviewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AcronymViewController.h>
#import <TimeTableAsyncRequest.h>
#import <TimeTableDetailController.h>

@class ScheduleDto;
@class DayDto;
@class TimeTableAsyncRequest;
@class TimeTableDetailController;

@interface TimeTableOverviewController : 
UIViewController 
<AcronymViewDelegate, TimeTableDetailViewDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    
    // taking care of the whole view
    IBOutlet UIView           *timeTableView;
    
    // taking care of the button to acronym
    AcronymViewController     *_acronymVC;
    
    // setting the table with timetable data
    IBOutlet UITableView      *_timeTable;

    NSDate                    *_actualDate;
    ScheduleDto               *_schedule;
    DayDto                    *_actualDayDto;
    
    // acronyms used in the schedule
    NSString                  *_ownStoredAcronymString;
    NSString                  *_ownStoredAcronymType;
    int                        _ownStoredAcronymTrials;

    NSString                  *_actualShownAcronymString;
    NSString                  *_actualShownAcronymType;
    int                        _actualShownAcronymTrials;
    
    // setting the navigation bar
    IBOutlet UINavigationItem *_dayNavigator;
    
    // acronym for timetable
    IBOutlet UILabel          *_acronymLabel;
    IBOutlet UILabel          *_ownStoredAcronymLabel;
    
    // taking care of the button to time table details    
    IBOutlet TimeTableDetailController *_detailsVC;
    
    IBOutlet UITableViewCell  *_oneSlotOneRoomTableCell;    
    IBOutlet UITableViewCell  *_oneSlotTwoRoomsTableCell;
    IBOutlet UITableViewCell  *_oneSlotThreeRoomsTableCell;
    IBOutlet UITableViewCell  *_oneSlotFourRoomsTableCell;
    IBOutlet UITableViewCell  *_oneSlotFiveRoomsTableCell;
    IBOutlet UITableViewCell  *_oneSlotSixRoomsTableCell;
    IBOutlet UITableViewCell  *_oneSlotSevenRoomsTableCell;
    IBOutlet UITableViewCell  *_oneSlotEightRoomsTableCell;

    IBOutlet UITableViewCell  *_twoSlotsOneRoomTableCell;
    IBOutlet UITableViewCell  *_twoSlotsTwoRoomsTableCell;

    IBOutlet UITableViewCell  *_threeSlotsOneRoomTableCell;
    IBOutlet UITableViewCell  *_threeSlotsTwoRoomsTableCell;
    IBOutlet UITableViewCell  *_threeSlotsThreeRoomsTableCell;
    
    IBOutlet UITableViewCell  *_fourSlotsOneRoomTableCell;
    IBOutlet UITableViewCell  *_fourSlotsTwoRoomsTableCell;
    IBOutlet UITableViewCell  *_fourSlotsThreeRoomsTableCell;
    
    IBOutlet UITableViewCell  *_fiveSlotsOneRoomTableCell;
    
    IBOutlet UITableViewCell  *_eightSlotsOneRoomTableCell;
    
    IBOutlet UIButton         *_noConnectionButton;
}

@property (nonatomic, retain) IBOutlet TimeTableDetailController *_detailsVC;
@property (nonatomic, retain) IBOutlet AcronymViewController     *_acronymVC;

@property (nonatomic, retain) IBOutlet UITableView               *_timeTable;

@property (nonatomic, retain) IBOutlet UINavigationItem          *_dayNavigator;
@property (nonatomic, retain) IBOutlet UILabel                   *_acronymLabel;
@property (nonatomic, retain) IBOutlet UILabel                   *_ownStoredAcronymLabel;


@property (nonatomic, retain) IBOutlet UITableViewCell           *_oneSlotOneRoomTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_oneSlotTwoRoomsTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_oneSlotThreeRoomsTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_oneSlotFourRoomsTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_oneSlotFiveRoomsTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_oneSlotSixRoomsTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_oneSlotSevenRoomsTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_oneSlotEightRoomsTableCell;

@property (nonatomic, retain) IBOutlet UITableViewCell           *_twoSlotsOneRoomTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_twoSlotsTwoRoomsTableCell;

@property (nonatomic, retain) IBOutlet UITableViewCell           *_threeSlotsOneRoomTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_threeSlotsTwoRoomsTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_threeSlotsThreeRoomsTableCell;

@property (nonatomic, retain) IBOutlet UITableViewCell           *_fourSlotsOneRoomTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_fourSlotsTwoRoomsTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_fourSlotsThreeRoomsTableCell;

@property (nonatomic, retain) IBOutlet UITableViewCell           *_fiveSlotsOneRoomTableCell;

@property (nonatomic, retain) IBOutlet UITableViewCell           *_eightSlotsOneRoomTableCell;

@property (nonatomic, retain) IBOutlet UIButton                  *_noConnectionButton;

@property (nonatomic, retain)          NSDate                    *_actualDate;
@property (nonatomic, retain)          ScheduleDto               *_schedule;
@property (nonatomic, retain)          DayDto                    *_actualDayDto;

// acronyms used in the schedule
@property (nonatomic, retain)          NSString                  *_ownStoredAcronymString;
@property (nonatomic, retain)          NSString                  *_ownStoredAcronymType;
@property (nonatomic, assign)          int                        _ownStoredAcronymTrials;

@property (nonatomic, retain)          NSString                  *_actualShownAcronymString;
@property (nonatomic, retain)          NSString                  *_actualShownAcronymType;
@property (nonatomic, assign)          int                        _actualShownAcronymTrials;


- (IBAction)enterAcronym:(id)sender;

- (IBAction)tryConnectionAgain:(id)sender;


@end
