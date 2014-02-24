/*
 MensaViewController.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header MensaViewController.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of MensaViewController.xib, where a list of gastronomic facilities is displayed. </li>
 *      <li> Getting and handling gastronomic facilities with opening and eating times.  </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives delegate from MenuOverviewController and passes it back, if back button is clicked. </li>
 *      <li> Gets data from MensaOverviewDto package for gastronomic facilities, their opening and eating times. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It passes the delegate to MensaDetailViewController and receives it back from there. </li>
 *      <li> It sets the actual chosen gastronomic facility on MensaDetailViewController so it can show the menus of that gastronomic facility. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <UIKit/UIKit.h>
#import "DateFormation.h"
#import "LanguageTranslation.h"
#import "MensaDetailViewController.h"
#import "GastronomicFacilityDto.h"
#import "GastronomicFacilityArrayDto.h"
#import "GradientButton.h"
#import "ColorSelection.h"

@interface MensaViewController : UIViewController<UITableViewDelegate>
{
    /*! @var _mensaOverviewTable Table to display a list of gastronomic facilities */
    IBOutlet UITableView                *_mensaOverviewTable;
    /*! @var _mensaOverviewTableCell Handles cell, which displays one gastronomic facilities with times */
    IBOutlet UITableViewCell            *_mensaOverviewTableCell;
    
    /*! @var _gastronomyFacilityArray Holds the array with all gastronomic facilities */
    GastronomicFacilityArrayDto         *_gastronomyFacilityArray;
    
    /*! @var _actualDate Holds the actual date */
    NSDate                              *_actualDate;
    
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation                       *_dateFormatter;
    /*! @var _translator Class which provides methods to translate from German to English and the other way around */
    LanguageTranslation                 *_translator;
    /*! @var _zhawColor Holds all color schemes needed */
    ColorSelection                      *_zhawColor;
    
    /*! @var _mensaDetailVC Handles delegate from and to MensaDetailViewController, is triggered when one of the table cells (gastronomic facilities) is chosen. */    
    IBOutlet MensaDetailViewController  *_mensaDetailVC;

    /*! @var _titleNavigationBar Shows the title */
    IBOutlet UINavigationBar            *_titleNavigationBar;
    /*! @var _titleNavigationItem Used as navigation item for title */
    IBOutlet UINavigationItem           *_titleNavigationItem;
    /*! @var _dateNavigationBar Shows the date */
    IBOutlet UINavigationBar            *_dateNavigationBar;
    /*! @var _titleNavigationItem Used as navigation item for date */
    IBOutlet UINavigationItem           *_dateNavigationItem;
    
    /*! @var _waitForChangeActivityIndicator Waiting indicator to show the user something is loading */
    IBOutlet UIActivityIndicatorView    *_waitForChangeActivityIndicator;
    
    /*! @var _noConnectionLabel If there is no connection to server, the label is displayed to inform the user */
    IBOutlet UILabel                    *_noConnectionLabel;
    /*! @var _noConnectionButton If there is no connection to server, the button is displayed, so the user can trigger another trial to connect to the server */
    IBOutlet GradientButton             *_noConnectionButton;

    /*! @var _tableRows Holds the number of table rows */
    int                                 _tableRows;
}

@property (nonatomic, retain) IBOutlet UITableView                  *_mensaOverviewTable;
@property (nonatomic, retain) IBOutlet UITableViewCell              *_mensaOverviewTableCell;

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UINavigationBar              *_dateNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_dateNavigationItem;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView      *_waitForChangeActivityIndicator;

@property (nonatomic, retain) GastronomicFacilityArrayDto           *_gastronomyFacilityArray;

@property (nonatomic, retain) IBOutlet MensaDetailViewController    *_mensaDetailVC;
@property (nonatomic, retain) NSDate                                *_actualDate;
@property (nonatomic, retain) DateFormation                         *_dateFormatter;
@property (nonatomic, retain) LanguageTranslation                   *_translator;
@property (nonatomic, retain) ColorSelection                        *_zhawColor;

@property (nonatomic, retain) IBOutlet UILabel                      *_noConnectionLabel;
@property (nonatomic, retain) IBOutlet GradientButton               *_noConnectionButton;

@property (nonatomic, assign) int                                       _tableRows;

/*!
 @function tryConnectionAgain
 Triggered by clicking the _noConnectionButton, another trial to connect to server is started.
 @param sender
 */
- (IBAction)tryConnectionAgain:(id)sender;

@end
