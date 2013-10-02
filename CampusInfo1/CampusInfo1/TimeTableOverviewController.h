/*
 TimeTableOverviewController.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header TimeTableOverviewController.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of TimeTableOverviewController.xib, which shows an overview of the time table of a selected student, lecturer, class, room or lecture </li>
 *      <li> Getting and handling time table data  </li>
 *      <li> Tiggers loading another time table, if lecture or room, shown in the time table, is clicked </li>
 *      <li> Switch to showing details in TimeTableDetailController is possible via link on table cells. </li>
 *      <li> Switch to search other time tables is possible (SearchViewController), via search button of segmented control bar. </li>
 *      <li> If no acronym is stored in settings, settings view (@link SettingsViewController.h @/link) is called via acronym button of segmented control bar. </li>
 *      <li> Date of shown time table can be changed or it can be moved to today (also a button in segmented control bar). </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> TimeTableOverviewController is called directly from MenuOverviewController or via main tab bar controller. Therefore it triggers all needed data on its own. </li>
 *      <li> Via call of ScheduleDto, data is get from server, which then is used to display the time tables. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It sends the gained schedule data to TimeTableDetailController to show its details. </li>
 *      <li> It does not send any data back to MenuOverviewController or to SearchViewController. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <UIKit/UIKit.h>
#import "TimeTableAsyncRequest.h"
#import "TimeTableDetailController.h"
#import "ChooseDateViewController.h"
#import "LanguageTranslation.h"
#import "DateFormation.h"
#import "SearchViewController.h"
#import "SettingsViewController.h"
#import "ColorSelection.h"
#import "GradientButton.h"

@class ScheduleDto;
@class DayDto;
@class TimeTableAsyncRequest;
@class TimeTableDetailController;
@class SearchViewController;
@class SettingsViewController;
@class GradientButton;

@interface TimeTableOverviewController : 
UIViewController 
<TimeTableDetailViewDelegate, ChooseDateViewDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
 
    /*! @var timeTableView Takes care of the whole view */
    IBOutlet UIView                     *timeTableView;
    
    /*! @var _timeTable Table to display the specific data gained from _schedule */
    IBOutlet UITableView                *_timeTable;

    /*! @var _actualDate Holds the actual chosen date for which the time table is shown */    
    NSDate                              *_actualDate;    
    /*! @var _schedule Holds all time table data for chosen acronym */
    ScheduleDto                         *_schedule;
    /*! @var _actualDayDto Holds the time table data for chosen acronym of only one day */
    DayDto                              *_actualDayDto;
    
    /*! @var _ownStoredAcronymString Stores the acronym, which is stored in the settings */
    NSString                            *_ownStoredAcronymString;
    /*! @var _ownStoredAcronymType Stores the acronym type, which is stored in the settings */
    NSString                            *_ownStoredAcronymType;
    /*! @var _ownStoredAcronymTrials Stores how many times, the system tried to get the data for own acronym from server */
    int                                 _ownStoredAcronymTrials;

    /*! @var _actualShownAcronymString Stores the actual acronym for which the time table is shown, can be unequal to _ownStoredAcronymString */    
    NSString                            *_actualShownAcronymString;
    /*! @var _actualShownAcronymType Stores the acronym type for which the time table is shown */
    NSString                            *_actualShownAcronymType;
    /*! @var _actualShownAcronymTrials Stores how many times, the system tried to get the data for actual acronym from server */
    int                                 _actualShownAcronymTrials;
    
    /*! @var _dayNavigator Used to show the back and for button to change the day */
    IBOutlet UINavigationItem           *_dayNavigator;
    /*! @var _dayNavigationBar Used as background for the date buttons (back, forth, date switch) */
    IBOutlet UINavigationBar            *_dayNavigationBar;
    /*! @var _dateButton Used to switch to ChooseDateViewController to change the date */    
    IBOutlet GradientButton             *_dateButton;
    
    /*! @var _timeTableSegmentedControl Has three buttons to switch to own stored acronym, today or search view */
    IBOutlet UISegmentedControl         *_timeTableSegmentedControl;
    /*! @var _segmentedControlNavigationBar Used as background for the segmented control */
    IBOutlet UINavigationBar            *_segmentedControlNavigationBar;
    
    
    /*! @var _chooseDateVC Handles delegate from and to ChooseDateViewController, is triggered when _dateButton is clicked */
    IBOutlet ChooseDateViewController   *_chooseDateVC;
    /*! @var _detailsVC Handles delegate from and to TimeTableDetailController, is triggered when button in table cell is clicked */
    IBOutlet TimeTableDetailController  *_detailsVC;
    /*! @var _searchVC Handles delegate from and to SearchViewController, is triggered when search button in segmented control bar is clicked */
    IBOutlet SearchViewController       *_searchVC;
    /*! @var _settingsVC Handles delegate from and to SettingsViewController, is triggered when no acronym is set in settings and acronym button in segmented control bar is clicked */    
    IBOutlet SettingsViewController     *_settingsVC;
    
    /*! @var _oneSlotOneRoomTableCell Handles cell, which displays one time slot and one room */
    IBOutlet UITableViewCell            *_oneSlotOneRoomTableCell;
    /*! @var _oneSlotTwoRoomsTableCell Handles cell, which displays one time slot and two rooms */
    IBOutlet UITableViewCell            *_oneSlotTwoRoomsTableCell;
    /*! @var _oneSlotThreeRoomsTableCell Handles cell, which displays one time slot and three rooms */
    IBOutlet UITableViewCell            *_oneSlotThreeRoomsTableCell;
    /*! @var _oneSlotFourRoomsTableCell Handles cell, which displays one time slot and four rooms */
    IBOutlet UITableViewCell            *_oneSlotFourRoomsTableCell;
    /*! @var _oneSlotFiveRoomsTableCell Handles cell, which displays one time slot and five rooms */
    IBOutlet UITableViewCell            *_oneSlotFiveRoomsTableCell;
    /*! @var _oneSlotSixRoomsTableCell Handles cell, which displays one time slot and six rooms */
    IBOutlet UITableViewCell            *_oneSlotSixRoomsTableCell;
    /*! @var _oneSlotSevenRoomsTableCell Handles cell, which displays one time slot and seven rooms */
    IBOutlet UITableViewCell            *_oneSlotSevenRoomsTableCell;
    /*! @var _oneSlotEightRoomsTableCell Handles cell, which displays one time slot and eight rooms */
    IBOutlet UITableViewCell            *_oneSlotEightRoomsTableCell;
            
    /*! @var _twoSlotsOneRoomTableCell Handles cell, which displays two time slots and one room */
    IBOutlet UITableViewCell            *_twoSlotsOneRoomTableCell;
    /*! @var _twoSlotsTwoRoomsTableCell Handles cell, which displays two time slots and two rooms */
    IBOutlet UITableViewCell            *_twoSlotsTwoRoomsTableCell;
    /*! @var _twoSlotsThreeRoomsTableCell Handles cell, which displays two time slots and three rooms */
    IBOutlet UITableViewCell            *_twoSlotsThreeRoomsTableCell;
    /*! @var _twoSlotsFourRoomsTableCell Handles cell, which displays two time slots and four rooms */
    IBOutlet UITableViewCell            *_twoSlotsFourRoomsTableCell;
    /*! @var _twoSlotsSixRoomsTableCell Handles cell, which displays two time slots and six rooms */
    IBOutlet UITableViewCell            *_twoSlotsSixRoomsTableCell;

    /*! @var _threeSlotsOneRoomTableCell Handles cell, which displays three time slots and one room */
    IBOutlet UITableViewCell            *_threeSlotsOneRoomTableCell;
    /*! @var _threeSlotsTwoRoomsTableCell Handles cell, which displays three time slots and two rooms */
    IBOutlet UITableViewCell            *_threeSlotsTwoRoomsTableCell;
    /*! @var _threeSlotsThreeRoomsTableCell Handles cell, which displays three time slots and three rooms */
    IBOutlet UITableViewCell            *_threeSlotsThreeRoomsTableCell;
    
    /*! @var _fourSlotsOneRoomTableCell Handles cell, which displays four time slots and one room */
    IBOutlet UITableViewCell            *_fourSlotsOneRoomTableCell;
    /*! @var _fourSlotsTwoRoomsTableCell Handles cell, which displays four time slots and two rooms */
    IBOutlet UITableViewCell            *_fourSlotsTwoRoomsTableCell;
    /*! @var _fourSlotsThreeRoomsTableCell Handles cell, which displays four time slots and three rooms */
    IBOutlet UITableViewCell            *_fourSlotsThreeRoomsTableCell;
    /*! @var _fourSlotsFourRoomsTableCell Handles cell, which displays four time slots and four rooms */
    IBOutlet UITableViewCell            *_fourSlotsFourRoomsTableCell;
    /*! @var _fourSlotsFiveRoomsTableCell Handles cell, which displays four time slots and five rooms */
    IBOutlet UITableViewCell            *_fourSlotsFiveRoomsTableCell;
    
    /*! @var _fiveSlotsOneRoomTableCell Handles cell, which displays five time slots and one room */
    IBOutlet UITableViewCell            *_fiveSlotsOneRoomTableCell;
    
    /*! @var _sixSlotsOneRoomTableCell Handles cell, which displays six time slots and one room */
    IBOutlet UITableViewCell            *_sixSlotsOneRoomTableCell;
    /*! @var _sixSlotsTwoRoomsTableCell Handles cell, which displays six time slots and two rooms */
    IBOutlet UITableViewCell            *_sixSlotsTwoRoomsTableCell;
    
    /*! @var _sevenSlotsOneRoomTableCell Handles cell, which displays seven time slots and one room */
    IBOutlet UITableViewCell            *_sevenSlotsOneRoomTableCell;
    /*! @var _sevenSlotsEightRoomsTableCell Handles cell, which displays seven time slots and eight rooms */
    IBOutlet UITableViewCell            *_sevenSlotsEightRoomsTableCell;
    
    /*! @var _eightSlotsOneRoomTableCell Handles cell, which displays eight time slots and one room */
    IBOutlet UITableViewCell            *_eightSlotsOneRoomTableCell;
    
    /*! @var _nineSlotsThreeRoomsTableCell Handles cell, which displays nine time slots and one room */    
    IBOutlet UITableViewCell            *_nineSlotsThreeRoomsTableCell;
    
    /*! @var _emptyTableCell Handles cell, which displays no data */
    IBOutlet UITableViewCell            *_emptyTableCell;
    /*! @var _errorMessageCell Handles cell, which displays an error message */
    IBOutlet UITableViewCell            *_errorMessageCell;
    
    /*! @var _noConnectionButton If there is no connection to server, the button is displayed, so the user can trigger another trial to connect to the server */
    IBOutlet GradientButton             *_noConnectionButton;
    /*! @var _noConnectionLabel If there is no connection to server, the label is displayed to inform the user */
    IBOutlet UILabel                    *_noConnectionLabel;
    
    /*! @var _searchText Stores the acronym returned by SearchViewController */
    NSString                            *_searchText;
    /*! @var _searchType Stores the acronym type returned by SearchViewController */
    NSString                            *_searchType;
    
    /*! @var _rightSwipe Controls the right swipe gesture to switch between dates */
    IBOutlet UISwipeGestureRecognizer   *_rightSwipe;
    /*! @var _leftSwipe Controls the left swipe to gesture switch between dates */
    IBOutlet UISwipeGestureRecognizer   *_leftSwipe;
    
    /*! @var _translator Class which provides methods to translate from German to English and the other way around */
    LanguageTranslation                 *_translator;
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation                       *_dateFormatter;
    
    /*! @var _waitForLoadingActivityIndicator Waiting indicator to show the user something is loading */
    IBOutlet UIActivityIndicatorView    *_waitForLoadingActivityIndicator;

    /*! @var _timeNavigationItem Used as navigation item for title and acronym */
    IBOutlet UINavigationItem           *_titleNavigationItem;
    /*! @var _timeNavigationBar Used as background for title and acronym */
    IBOutlet UINavigationBar            *_titleNavigationBar;
    /*! @var _titleNavigationLabel Shows the title */
    IBOutlet UILabel                    *_titleNavigationLabel;
    /*! @var _acronymLabel Shows the acronym */
    IBOutlet UILabel                    *_acronymLabel;
    
    /*! @var _zhawColor Holds all color schemes needed */
    ColorSelection                      *_zhawColor;
}


@property (nonatomic, retain) IBOutlet TimeTableDetailController *_detailsVC;
@property (nonatomic, retain) IBOutlet ChooseDateViewController  *_chooseDateVC;
@property (nonatomic, retain) IBOutlet SearchViewController      *_searchVC;
@property (nonatomic, retain) IBOutlet SettingsViewController    *_settingsVC;

@property (nonatomic, retain) IBOutlet UITableView               *_timeTable;

@property (nonatomic, retain) IBOutlet UINavigationBar           *_dayNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem          *_dayNavigator;
@property (nonatomic, retain) IBOutlet GradientButton            *_dateButton;

@property (nonatomic, retain) IBOutlet UILabel                   *_acronymLabel;
@property (nonatomic, retain) IBOutlet UILabel                   *_titleNavigationLabel;
@property (nonatomic, retain) IBOutlet UINavigationItem          *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UINavigationBar           *_titleNavigationBar;

@property (nonatomic, retain) IBOutlet UISegmentedControl        *_timeTableSegmentedControl;
@property (nonatomic, retain) IBOutlet UINavigationBar           *_segmentedControlNavigationBar;

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
@property (nonatomic, retain) IBOutlet UITableViewCell           *_fourSlotsFourRoomsTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_fourSlotsFiveRoomsTableCell;

@property (nonatomic, retain) IBOutlet UITableViewCell           *_fiveSlotsOneRoomTableCell;

@property (nonatomic, retain) IBOutlet UITableViewCell           *_sixSlotsOneRoomTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_sixSlotsTwoRoomsTableCell;

@property (nonatomic, retain) IBOutlet UITableViewCell           *_sevenSlotsOneRoomTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_sevenSlotsEightRoomsTableCell;

@property (nonatomic, retain) IBOutlet UITableViewCell           *_eightSlotsOneRoomTableCell;

@property (nonatomic, retain) IBOutlet UITableViewCell           *_nineSlotsThreeRoomsTableCell;

@property (nonatomic, retain) IBOutlet UITableViewCell           *_emptyTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell           *_errorMessageCell;

@property (nonatomic, retain) IBOutlet UIButton                  *_noConnectionButton;
@property (nonatomic, retain) IBOutlet UILabel                   *_noConnectionLabel;

@property (nonatomic, retain)          NSDate                    *_actualDate;
@property (nonatomic, retain)          ScheduleDto               *_schedule;
@property (nonatomic, retain)          DayDto                    *_actualDayDto;

@property (nonatomic, retain)          NSString                  *_ownStoredAcronymString;
@property (nonatomic, retain)          NSString                  *_ownStoredAcronymType;
@property (nonatomic, assign)          int                        _ownStoredAcronymTrials;

@property (nonatomic, retain)          NSString                  *_actualShownAcronymString;
@property (nonatomic, retain)          NSString                  *_actualShownAcronymType;
@property (nonatomic, assign)          int                        _actualShownAcronymTrials;

@property (nonatomic, retain)          NSString                  *_searchText;
@property (nonatomic, retain)          NSString                  *_searchType;

@property (nonatomic, retain) IBOutlet UISwipeGestureRecognizer  *_rightSwipe;
@property (nonatomic, retain) IBOutlet UISwipeGestureRecognizer  *_leftSwipe;

@property (nonatomic, retain)          LanguageTranslation       *_translator;
@property (nonatomic, retain)          DateFormation             *_dateFormatter;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView   *_waitForLoadingActivityIndicator;

@property (nonatomic, retain)          ColorSelection            *_zhawColor;


/*!
 @function tryConnectionAgain
 Triggered by clicking the _noConnectionButton, another trial to connect to server is started.
 @param sender
 */
- (IBAction)tryConnectionAgain:(id)sender;

/*!
 @function moveToTimeTableSegmentedControlFeature
 Controls the segmented control buttons to switch to own acronym (or settings view), to today or search view.
 @param sender
 */
- (IBAction)moveToTimeTableSegmentedControlFeature:(id)sender;

/*!
 @function moveToChooseDateView
 Switches to ChooseDateViewController, so a different date can be chosen.
 @param sender
 */
- (IBAction)moveToChooseDateView:(id)sender;

@end
