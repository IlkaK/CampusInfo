//
//  TimeTableOverviewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TimeTableAsyncRequest.h>
#import <TimeTableDetailController.h>
#import <ChooseDateViewController.h>
#import <GradientButton.h>
#import <LanguageTranslation.h>
#import <DateFormation.h>
#import <SearchViewController.h>
#import <SettingsViewController.h>

@class ScheduleDto;
@class DayDto;
@class TimeTableAsyncRequest;
@class TimeTableDetailController;
@class SearchViewController;
@class SettingsViewController;

@interface TimeTableOverviewController : 
UIViewController 
<TimeTableDetailViewDelegate, ChooseDateViewDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    
    // taking care of the whole view
    IBOutlet UIView                     *timeTableView;
    
    // setting the table with timetable data
    IBOutlet UITableView                *_timeTable;

    NSDate                              *_actualDate;
    ScheduleDto                         *_schedule;
    DayDto                              *_actualDayDto;
    
    // acronyms used in the schedule
    NSString                            *_ownStoredAcronymString;
    NSString                            *_ownStoredAcronymType;
    int                                 _ownStoredAcronymTrials;

    NSString                            *_actualShownAcronymString;
    NSString                            *_actualShownAcronymType;
    int                                 _actualShownAcronymTrials;
    
    // setting the navigation bar
    IBOutlet UINavigationItem           *_dayNavigator;
    IBOutlet UILabel                    *_dateLabel;
    
    // acronym for timetable
    IBOutlet UILabel                    *_acronymLabel;
    IBOutlet UILabel                    *_titleLabel;
    
    // choose dates for navigator
    IBOutlet ChooseDateViewController   *_chooseDateVC;
    
    // taking care of the button to time table details    
    IBOutlet TimeTableDetailController  *_detailsVC;
    
    // switches to search view
    IBOutlet SearchViewController       *_searchVC;
    
    IBOutlet SettingsViewController     *_settingsVC;
    
    // cells for table
    IBOutlet UITableViewCell            *_oneSlotOneRoomTableCell;    
    IBOutlet UITableViewCell            *_oneSlotTwoRoomsTableCell;
    IBOutlet UITableViewCell            *_oneSlotThreeRoomsTableCell;
    IBOutlet UITableViewCell            *_oneSlotFourRoomsTableCell;
    IBOutlet UITableViewCell            *_oneSlotFiveRoomsTableCell;
    IBOutlet UITableViewCell            *_oneSlotSixRoomsTableCell;
    IBOutlet UITableViewCell            *_oneSlotSevenRoomsTableCell;
    IBOutlet UITableViewCell            *_oneSlotEightRoomsTableCell;
            
    IBOutlet UITableViewCell  *_twoSlotsOneRoomTableCell;
    IBOutlet UITableViewCell  *_twoSlotsTwoRoomsTableCell;
    IBOutlet UITableViewCell  *_twoSlotsThreeRoomsTableCell;
    IBOutlet UITableViewCell  *_twoSlotsFourRoomsTableCell;
    IBOutlet UITableViewCell  *_twoSlotsSixRoomsTableCell;

    IBOutlet UITableViewCell  *_threeSlotsOneRoomTableCell;
    IBOutlet UITableViewCell  *_threeSlotsTwoRoomsTableCell;
    IBOutlet UITableViewCell  *_threeSlotsThreeRoomsTableCell;
    
    IBOutlet UITableViewCell  *_fourSlotsOneRoomTableCell;
    IBOutlet UITableViewCell  *_fourSlotsTwoRoomsTableCell;
    IBOutlet UITableViewCell  *_fourSlotsThreeRoomsTableCell;
    IBOutlet UITableViewCell  *_fourSlotsFiveRoomsTableCell;
    
    IBOutlet UITableViewCell  *_fiveSlotsOneRoomTableCell;
    
    IBOutlet UITableViewCell  *_sixSlotsOneRoomTableCell;
    IBOutlet UITableViewCell  *_sixSlotsTwoRoomsTableCell;
    
    IBOutlet UITableViewCell  *_sevenSlotsOneRoomTableCell;
    
    IBOutlet UITableViewCell  *_eightSlotsOneRoomTableCell;
    
    IBOutlet UITableViewCell  *_emptyTableCell;
    IBOutlet UITableViewCell  *_errorMessageCell;
    
    IBOutlet UIButton         *_noConnectionButton;
    IBOutlet UILabel          *_noConnectionLabel;
    
    NSString                  *_searchText;
    NSString                  *_searchType;
    
    IBOutlet GradientButton             *_homeButton;
    IBOutlet GradientButton             *_todayButton;
    IBOutlet GradientButton             *_searchButton;
    
    IBOutlet UISwipeGestureRecognizer   *_rightSwipe;
    IBOutlet UISwipeGestureRecognizer   *_leftSwipe;
    
    LanguageTranslation                 *_translator;
    DateFormation                       *_dateFormatter;
    
    IBOutlet UIActivityIndicatorView    *_waitForLoadingActivityIndicator;
}


@property (nonatomic, retain) IBOutlet TimeTableDetailController *_detailsVC;
@property (nonatomic, retain) IBOutlet ChooseDateViewController  *_chooseDateVC;
@property (nonatomic, retain) IBOutlet SearchViewController      *_searchVC;
@property (nonatomic, retain) IBOutlet SettingsViewController    *_settingsVC;

@property (nonatomic, retain) IBOutlet UITableView               *_timeTable;

@property (nonatomic, retain) IBOutlet UINavigationItem          *_dayNavigator;
@property (nonatomic, retain) IBOutlet UILabel                   *_dateLabel;

@property (nonatomic, retain) IBOutlet UILabel                   *_acronymLabel;
@property (nonatomic, retain) IBOutlet UILabel                   *_titleLabel;

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
@property (nonatomic, retain) IBOutlet UITableViewCell           *_twoSlotsThreeRoomsTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_twoSlotsFourRoomsTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_twoSlotsSixRoomsTableCell;

@property (nonatomic, retain) IBOutlet UITableViewCell           *_threeSlotsOneRoomTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_threeSlotsTwoRoomsTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_threeSlotsThreeRoomsTableCell;

@property (nonatomic, retain) IBOutlet UITableViewCell           *_fourSlotsOneRoomTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_fourSlotsTwoRoomsTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_fourSlotsThreeRoomsTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_fourSlotsFiveRoomsTableCell;

@property (nonatomic, retain) IBOutlet UITableViewCell           *_fiveSlotsOneRoomTableCell;

@property (nonatomic, retain) IBOutlet UITableViewCell           *_sixSlotsOneRoomTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_sixSlotsTwoRoomsTableCell;

@property (nonatomic, retain) IBOutlet UITableViewCell           *_sevenSlotsOneRoomTableCell;

@property (nonatomic, retain) IBOutlet UITableViewCell           *_eightSlotsOneRoomTableCell;

@property (nonatomic, retain) IBOutlet UITableViewCell           *_emptyTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_errorMessageCell;

@property (nonatomic, retain) IBOutlet UIButton                  *_noConnectionButton;
@property (nonatomic, retain) IBOutlet UILabel                   *_noConnectionLabel;

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

@property (nonatomic, retain)          NSString                  *_searchText;
@property (nonatomic, retain)          NSString                  *_searchType;

@property (nonatomic, retain) IBOutlet GradientButton            *_homeButton;
@property (nonatomic, retain) IBOutlet GradientButton            *_todayButton;
@property (nonatomic, retain) IBOutlet GradientButton            *_searchButton;

@property (nonatomic, retain) IBOutlet UISwipeGestureRecognizer  *_rightSwipe;
@property (nonatomic, retain) IBOutlet UISwipeGestureRecognizer  *_leftSwipe;

@property (nonatomic, retain)          LanguageTranslation       *_translator;
@property (nonatomic, retain)          DateFormation             *_dateFormatter;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView   *_waitForLoadingActivityIndicator;


- (IBAction)tryConnectionAgain:(id)sender;

- (IBAction)backToOwnAcronym:(id)sender;
- (IBAction)backToToday:(id)sender;
- (IBAction)moveToSearch:(id)sender;
- (IBAction)moveBackToMenuOverview:(id)sender;

@end
