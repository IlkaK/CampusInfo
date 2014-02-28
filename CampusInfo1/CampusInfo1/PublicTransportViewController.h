/*
 PublicTransportViewController.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header PublicTransportViewController.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of PublicTransportViewController.xib, where data for public transport connection can be entered and the connections are displayed. </li>
 *      <li> Getting and handling start and stop data as well as the connections.  </li>
 *      <li> With two buttons it can be switched to PubliStopViewController to search for different stops. </li>
 *      <li> Three start (from) and stop (to) stations are stored in database and handled here as well. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives delegate from MenuOverviewController and passes it back, if back button is clicked. </li>
 *      <li> Receives chosen station from PublicStopViewController, if a new one is found. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It passes the delegate to PublicStopViewController and receives it back from there. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <UIKit/UIKit.h>
#import "PublicStopViewController.h"
#import "ConnectionArrayDto.h"
#import "DateFormation.h"
#import "DBCachingForAutocomplete.h"
#import "ColorSelection.h"


@class PublicStopViewController;

@interface PublicTransportViewController : UIViewController<UITableViewDelegate, UITextFieldDelegate>
{
    
    /*! @var _publicTransportNavigationBar Shows the title */
    IBOutlet UINavigationBar            *_titleNavigationBar;
    /*! @var _publicTransportNavigationItem Used as navigation item for title */
    IBOutlet UINavigationItem           *_titleNavigationItem;
    
    /*! @var _pubilcTransportOverviewTableCell Handles cell, which displays the solo connections */
    IBOutlet UITableViewCell            *_pubilcTransportOverviewTableCell;
    /*! @var _publicTransportTableView Table to display the connection data */
    IBOutlet UITableView                *_publicTransportTableView;
    
    /*! @var _publicStopVC Handles delegate from and to PublicStopViewController, is triggered when start or stop station is searched (new Button clicked) */
    IBOutlet PublicStopViewController   *_publicStopVC;
    
    /*! @var _connectionArray Holds the array with all connections */
    ConnectionArrayDto                  *_connectionArray;
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation                       *_dateFormatter;
    /*! @var _zhawColor Holds all color schemes needed */
    ColorSelection                      *_zhawColor;
    
    /*! @var _startStation Holds the actual start station to search for connections */
    NSString                            *_startStation;
    /*! @var _stopStation Holds the actual stop station to search for connections */
    NSString                            *_stopStation;
    /*! @var _changedStartStation Stores if the start station has changed and new connections need to be searched for */
    BOOL                                _changedStartStation;
    /*! @var _changedStopStation Stores if the stop station has changed and new connections need to be searched for */
    BOOL                                _changedStopStation;
    
    /*! @var _dbCachingForAutocomplete Handles the interaction of the database to store and get student acronyms */
    DBCachingForAutocomplete            *_dbCachingForAutocomplete;
    /*! @var _storedStartStationArray Stores the last three start stations searched so far */    
    NSMutableArray                      *_storedStartStationArray;
    /*! @var _storedStopStationArray Stores the last three stop stations searched so far */
    NSMutableArray                      *_storedStopStationArray;
    
    /*! @var _startLabel Shows the start station used for searching the connections */
    IBOutlet UILabel                    *_startLabel;
    /*! @var _changeStartButtonIsActivated Stores if the start button is clicked */
    BOOL                                _changeStartButtonIsActivated;
    /*! @var _lastStart1Button Switches to the last searched start station */
    IBOutlet UIButton                   *_lastStart1Button;
    /*! @var _lastStart2Button Switches to the second last searched start station */
    IBOutlet UIButton                   *_lastStart2Button;
    /*! @var _chooseNewStartButton Enabled switching to PublicStopViewController to search for a new start station */
    IBOutlet UIButton                   *_chooseNewStartButton;
    
    /*! @var _stopLabel Shows the stop station used for searching the connections */
    IBOutlet UILabel                    *_stopLabel;
    /*! @var _changeStopButtonIsActivated Stores if the stop button is clicked */
    BOOL                                _changeStopButtonIsActivated;
    /*! @var _lastStop1Button Switches to the last searched stop station */
    IBOutlet UIButton                   *_lastStop1Button;
    /*! @var _lastStop2Button Switches to the second last searched stop station */
    IBOutlet UIButton                   *_lastStop2Button;
    /*! @var _chooseNewStopButton Enabled switching to PublicStopViewController to search for a new stop station */
    IBOutlet UIButton                   *_chooseNewStopButton;
    
    /*! @var _searchButton Triggers searching for new connections */
    IBOutlet UIButton                   *_searchButton;
    /*! @var _changeDirectionButton Switches start and stop station*/
    IBOutlet UIButton *_changeDirectionButton;
    /*! @var _waitForChangeActivityIndicator Waiting indicator to show the user something is loading */
    IBOutlet UIActivityIndicatorView    *_waitForChangeActivityIndicator;
    
    /*! @var _fromLabel Shows the title from */
    IBOutlet UILabel                    *_fromLabel;
    /*! @var _toLabel Shows the title to */
    IBOutlet UILabel                    *_toLabel;
    /*! @var _destinationTitleLabel Shows the title destination */
    IBOutlet UILabel                    *_destinationTitleLabel;
    /*! @var _dateTitleLabel Shows the title date */
    IBOutlet UILabel                    *_dateTitleLabel;
    /*! @var _timeTitleLabel Shows the title time */
    IBOutlet UILabel                    *_timeTitleLabel;
    /*! @var _durationTitleLabel Shows the title duration */
    IBOutlet UILabel                    *_durationTitleLabel;
    /*! @var _transfersTitleLabel Shows the title transfers */
    IBOutlet UILabel                    *_transfersTitleLabel;
    /*! @var _transportationTitleLabel Shows the title transportation */
    IBOutlet UILabel                    *_transportationTitleLabel;
}


@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;

@property (nonatomic, retain) IBOutlet UITableViewCell              *_pubilcTransportOverviewTableCell;
@property (nonatomic, retain) IBOutlet UITableView                  *_publicTransportTableView;

@property (nonatomic, retain) IBOutlet PublicStopViewController     *_publicStopVC;

@property (nonatomic, retain) ConnectionArrayDto                    *_connectionArray;
@property (nonatomic, retain) DateFormation                         *_dateFormatter;
@property (nonatomic, retain) ColorSelection                        *_zhawColor;

@property (nonatomic, retain) NSString                              *_startStation;
@property (nonatomic, retain) NSString                              *_stopStation;
@property (nonatomic, assign) BOOL                                  _changedStartStation;
@property (nonatomic, assign) BOOL                                  _changedStopStation;

@property (nonatomic, retain) DBCachingForAutocomplete              *_dbCachingForAutocomplete;
@property (nonatomic, retain) NSMutableArray                        *_storedStartStationArray;
@property (nonatomic, retain) NSMutableArray                        *_storedStopStationArray;

@property (nonatomic, retain) IBOutlet UILabel                      *_startLabel;
@property (nonatomic, assign) BOOL                                  _changeStartButtonIsActivated;
@property (nonatomic, retain) IBOutlet UIButton                     *_lastStart1Button;
@property (nonatomic, retain) IBOutlet UIButton                     *_lastStart2Button;
@property (nonatomic, retain) IBOutlet UIButton                     *_chooseNewStartButton;

@property (nonatomic, retain) IBOutlet UILabel                      *_stopLabel;
@property (nonatomic, assign) BOOL                                  _changeStopButtonIsActivated;
@property (nonatomic, retain) IBOutlet UIButton                     *_lastStop1Button;
@property (nonatomic, retain) IBOutlet UIButton                     *_lastStop2Button;
@property (nonatomic, retain) IBOutlet UIButton                     *_chooseNewStopButton;

@property (nonatomic, retain) IBOutlet UIButton                     *_searchButton;
@property (nonatomic, retain) IBOutlet UIButton                     *_changeDirectionButton;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView      *_waitForChangeActivityIndicator;

@property (nonatomic, retain) IBOutlet IBOutlet UILabel             *_fromLabel;
@property (nonatomic, retain) IBOutlet IBOutlet UILabel             *_toLabel;
@property (nonatomic, retain) IBOutlet IBOutlet UILabel             *_destinationTitleLabel;
@property (nonatomic, retain) IBOutlet IBOutlet UILabel             *_dateTitleLabel;
@property (nonatomic, retain) IBOutlet IBOutlet UILabel             *_timeTitleLabel;
@property (nonatomic, retain) IBOutlet IBOutlet UILabel             *_durationTitleLabel;
@property (nonatomic, retain) IBOutlet IBOutlet UILabel             *_transfersTitleLabel;
@property (nonatomic, retain) IBOutlet IBOutlet UILabel             *_transportationTitleLabel;

/*!
 @function startConnectionSearch
 Triggers searching for new connections.
 @param sender
 */
- (IBAction)startConnectionSearch:(id)sender;

/*!
 @function changeDirection
 Switches start and stop station.
 @param sender
 */
- (IBAction)changeDirection:(id)sender;

/*!
 @function changeStart
 Triggers showing all last start stations.
 It is triggered by detail button next to from label.
 @param sender
 */
- (IBAction)changeStart:(id)sender;

/*!
 @function changeStartToLast1
 Changes start station to the one from the given button.
 @param sender
 */
- (IBAction)changeStartToLast1:(id)sender;

/*!
 @function changeStartToLast2
 Changes start station to the one from the given button.
 @param sender
 */
- (IBAction)changeStartToLast2:(id)sender;

/*!
 @function chooseNewStart
 Switches delegate to PublicStopViewController to search for new start station.
 @param sender
 */
- (IBAction)chooseNewStart:(id)sender;

/*!
 @function changeStop
 Triggers showing all last stop stations.
 It is triggered by detail button next to to label.
 @param sender
 */
- (IBAction)changeStop:(id)sender;

/*!
 @function changeStopToLast1
 Changes stop station to the one from the given button.
 @param sender
 */
- (IBAction)changeStopToLast1:(id)sender;

/*!
 @function changeStopToLast2
 Changes stop station to the one from the given button.
 @param sender
 */
- (IBAction)changeStopToLast2:(id)sender;

/*!
 @function chooseNewStop
 Switches delegate to PublicStopViewController to search for new stop station.
 @param sender
 */
- (IBAction)chooseNewStop:(id)sender;


@end
