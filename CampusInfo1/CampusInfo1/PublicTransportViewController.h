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
    
    /*! @var _waitForChangeActivityIndicator Waiting indicator to show the user something is loading */
    IBOutlet UIActivityIndicatorView    *_waitForChangeActivityIndicator;
    
    IBOutlet UICollectionView           *_publicTransportCollectionView;
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

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView      *_waitForChangeActivityIndicator;

@property (nonatomic, retain) IBOutlet IBOutlet UICollectionView    *_publicTransportCollectionView;

@end
