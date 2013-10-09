/*
 MensaDetailViewController.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header MensaDetailViewController.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of MensaDetailViewController.xib, where a list of menus of a gastronomic facility is displayed. </li>
 *      <li> Getting and handling the menu of a gastronomic facilitiy.  </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives delegate from MensaViewController and passes it back, if back button is clicked. </li>
 *      <li> Gets data from MensaMenuDto package for menus of a gastronomic facility. </li>
  *      <li> It gets the actual chosen gastronomic facility from MensaViewController so it can show the menus of that gastronomic facility. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It sets the gastronomic facility to menu array which then can build the url to get the desired menu data. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <UIKit/UIKit.h>
#import "GastronomicFacilityDto.h"
#import "GradientButton.h"
#import "DateFormation.h"
#import "ChooseDateViewController.h"
#import "MenuDto.h"
#import "MenuPlanArrayDto.h"
#import "ColorSelection.h"
#import "GradientButton.h"

@interface MensaDetailViewController : UIViewController <ChooseDateViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    /*! @var _actualGastronomy Holds the actual gastronomic facility */
    GastronomicFacilityDto              *_actualGastronomy;
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation                       *_dateFormatter;
    /*! @var _menuPlans Holds the array with all menus */
    MenuPlanArrayDto                    *_menuPlans;
    /*! @var _actualMenu Holds the actual chosen menu */
    MenuDto                             *_actualMenu;

    /*! @var _titleNavigationBar Used as background for title */
    IBOutlet UINavigationBar            *_titleNavigationBar;
    /*! @var _titleNavigationItem Used as navigation item for title */
    IBOutlet UINavigationItem           *_titleNavigationItem;
    /*! @var _titleNavigationLabel Shows the title */
    IBOutlet UILabel                    *_titleNavigationLabel;
    /*! @var _gastronomyLabel Shows the chosen gastronomic facility */
    IBOutlet UILabel                    *_gastronomyLabel;
    
    /*! @var _dayNavigationItem Used to show the back and for button to change the day */
    IBOutlet UINavigationItem           *_dayNavigationItem;
    /*! @var _dateNavigationBar Used as background for showing the date */
    IBOutlet UINavigationBar            *_dateNavigationBar;
    /*! @var _dateButton Used to switch to ChooseDateViewController to change the date */    
    IBOutlet GradientButton             *_dateButton;
    
    /*! @var _chooseDateVC Handles delegate from and to ChooseDateViewController, is triggered when _dateButton is clicked */
    IBOutlet ChooseDateViewController   *_chooseDateVC;
    /*! @var _detailTable Table to display the specific data gained from MenuPlanArrayDto */
    IBOutlet UITableView                *_detailTable;
    /*! @var _detailTableCell Handles cell, which displays one menu */
    IBOutlet UITableViewCell            *_detailTableCell;

    /*! @var _actualDate Holds the actual chosen date for which the menus are shown */    
    NSDate                              *_actualDate;
    /*! @var _actualCalendarWeek Holds the actual calendar week for which the menus are shown */  
    int                                 _actualCalendarWeek;
    
    /*! @var _rightSwipe Controls the right swipe gesture to switch between dates */
    IBOutlet UISwipeGestureRecognizer   *_rightSwipe;
    /*! @var _leftSwipe Controls the left swipe to gesture switch between dates */
    IBOutlet UISwipeGestureRecognizer   *_leftSwipe;
    
    /*! @var _waitForChangeActivityIndicator Waiting indicator to show the user something is loading */
    IBOutlet UIActivityIndicatorView    *_waitForChangeActivityIndicator;
    
    /*! @var _zhawColor Holds all color schemes needed */
    ColorSelection                      *_zhawColor;
}

@property (nonatomic, retain) GastronomicFacilityDto                    *_actualGastronomy;

@property (nonatomic, retain) IBOutlet UINavigationItem                 *_dayNavigationItem;
@property (nonatomic, retain) IBOutlet GradientButton                   *_dateButton;
@property (nonatomic, retain) IBOutlet UINavigationBar                  *_dateNavigationBar;

@property (nonatomic, retain) DateFormation                             *_dateFormatter;

@property (nonatomic, retain) NSDate                                    *_actualDate;
@property (nonatomic, assign) int                                       _actualCalendarWeek;

@property (nonatomic, retain) IBOutlet ChooseDateViewController         *_chooseDateVC;
@property (nonatomic, retain) IBOutlet UITableView                      *_detailTable;
@property (nonatomic, retain) IBOutlet UITableViewCell                  *_detailTableCell;


@property (nonatomic, retain) MenuPlanArrayDto                          *_menuPlans;
@property (nonatomic, retain) MenuDto                                   *_actualMenu;

@property (nonatomic, retain) IBOutlet UISwipeGestureRecognizer         *_rightSwipe;
@property (nonatomic, retain) IBOutlet UISwipeGestureRecognizer         *_leftSwipe;

@property (nonatomic, retain) IBOutlet UINavigationBar                  *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem                 *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                          *_titleNavigationLabel;
@property (nonatomic, retain) IBOutlet UILabel                          *_gastronomyLabel;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView          *_waitForChangeActivityIndicator;

@property (nonatomic, retain) ColorSelection                            *_zhawColor;

/*!
 @function backToMensaOverview
 Function is called, when back button on navigation bar is hit, to move back to gastronomic facilties overview.
 @param sender
 */
- (IBAction)backToMensaOverview:(id)sender;

/*!
 @function moveToChooseDateView
 Switches to ChooseDateViewController, so a different date can be chosen.
 @param sender
 */
- (IBAction)moveToChooseDateView:(id)sender;

@end
