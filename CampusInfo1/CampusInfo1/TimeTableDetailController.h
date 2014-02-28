/*
 TimeTableDetailViewDelegate.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header TimeTableDetailViewDelegate.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of TimeTableDetailViewDelegate.xib, which shows the detail aspects of a time table entry </li>
 *      <li> Handling the details of a time table entry  </li>
 *      <li> Tiggers loading another time table, if one of the details is activated </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> This class is delegated by TimeTableOverviewController, which sets the _scheduleEvent in which a time table entry is stored. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It sends new acronym and acronym type back to TimeTableOverviewController to load the new time table. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */


#import <UIKit/UIKit.h>
#import "ColorSelection.h"

@class ScheduleDto;
@class ScheduleEventDto;
@class ScheduleEventRealizationDto;

@protocol TimeTableDetailViewDelegate <NSObject>

/*!
 @function setNewAcronym
 Works as bridge between TimeTableDetailController and TimeTableOverviewController.
 @param newAcronym new acronym, for which the time table is loaded
 @param newAcronymType type of acronym, for which the time table is loaded
 */
-(void)setNewAcronym:(NSString *)newAcronym withAcronymType:(NSString *)newAcronymType;

@end



@interface TimeTableDetailController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    /*! @var _timeTableDetailViewDelegate Id for delegation (used by TimeTableOverviewController) */
    id                                  _timeTableDetailViewDelegate;
    
    /*! @var _scheduleEvent Holds all data to chosen lecture */
    ScheduleEventDto                    *_scheduleEvent;
    
    /*! @var _detailTable Table to display the scheduleEvent data */
    IBOutlet UITableView                *_detailTable;
    /*! @var _detailTableCell Table cell to order the data without a link to other time tables */
    IBOutlet UITableViewCell            *_detailTableCell;
    /*! @var _detailTableCell Table cell to order the data with a link (button) to other time tables */
    IBOutlet UITableViewCell            *_detailTableCellWithButton;
    
    /*! @var _timeString String which is set in _timeLabel */
    NSString                            *_timeString;
    /*! @var _dayAndAcronymString String which is set in _timeTableDescriptionLabel */
    NSString                            *_dayAndAcronymString;

    /*! @var _waitForChangeActivityIndicator Waiting indicator to show the user something is loading */
    IBOutlet UIActivityIndicatorView    *_waitForChangeActivityIndicator;
    
    /*! @var _titleNavigationBar Used as background for the title in the view */
    IBOutlet UINavigationBar            *_titleNavigationBar;
    /*! @var _titleNavigationItem Used to show the back button to return to main menu in title */
    IBOutlet UINavigationItem           *_titleNavigationItem;
    /*! @var _titleNavigationLabel Shows the title of the view */
    IBOutlet UILabel                    *_titleNavigationLabel;
    /*! @var _timeTableDescriptionLabel Shows the time table owner */
    IBOutlet UILabel                    *_timeTableDescriptionLabel;

    /*! @var _timeNavigationBar Used as background for the date and time description */
    IBOutlet UINavigationBar            *_timeNavigationBar;
    /*! @var _timeNavigationItem Used as navigation item for the date and time description */
    IBOutlet UINavigationItem           *_timeNavigationItem;
    /*! @var _timeLabel Shows the time and date of the chosen lecture */
    IBOutlet UILabel                    *_timeLabel;

    /*! @var _zhawColors Holds all color schemes needed */
    ColorSelection                      *_zhawColor;
}

@property (nonatomic, retain) id<TimeTableDetailViewDelegate>   _timeTableDetailViewDelegate;
@property (nonatomic, retain) ScheduleEventDto                  *_scheduleEvent;
@property (nonatomic, retain) IBOutlet UITableView              *_detailTable;
@property (nonatomic, retain) IBOutlet UITableViewCell          *_detailTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell          *_detailTableCellWithButton;

@property (nonatomic, retain) NSString                          *_timeString;
@property (nonatomic, retain) NSString                          *_dayAndAcronymString;

@property (nonatomic, retain) IBOutlet UINavigationBar          *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem         *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                  *_titleNavigationLabel;
@property (nonatomic, retain) IBOutlet UILabel                  *_timeTableDescriptionLabel;

@property (nonatomic, retain) IBOutlet UINavigationBar          *_timeNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem         *_timeNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                  *_timeLabel;

@property (nonatomic, retain) ColorSelection                    *_zhawColor;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView  *_waitForChangeActivityIndicator;

/*!
 @function setNavigationTitle
 Sets _timeTableDescriptionLabel to given string. Called by TimeTableOverviewController. 
 @param titleString String to be set for _timeTableDescriptionLabel.
 */
-(void)setNavigationTitle:(NSString *)titleString;

/*!
 @function moveBackToTimeTable
 Function is called, when back button on navigation bar is hit, to move back to time table overview.
 @param sender
 */
- (IBAction)moveBackToTimeTable:(id)sender;

@end
