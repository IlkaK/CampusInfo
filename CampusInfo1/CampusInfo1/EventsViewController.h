/*
 EventsViewController.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header EventsViewController.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of EventsViewController.xib, where displays all events in a table. </li>
 *      <li> Getting and handling event data via NewsChannelDto.  </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives delegate from MenuOverviewController and passes it back, if back button is clicked. </li>
*      <li> It receives data from NewsChannelDto, which establishes a connection to server. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It passes the data type to NewsChannelDto. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <UIKit/UIKit.h>
#import "NewsChannelDto.h"
#import "DateFormation.h"
#import "ColorSelection.h"
#import "GradientButton.h"

@interface EventsViewController : UIViewController
{
    /*! @var _newsChannel Holds the news channel data */
    NewsChannelDto                      *_newsChannel;

    /*! @var _eventsTable Table to display the events */
    IBOutlet UITableView                *_eventsTable;
    /*! @var _eventsTableCell Handles cell, which displays the solo event */
    IBOutlet UITableViewCell            *_eventsTableCell;
    
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation                       *_dateFormatter;
    
    /*! @var _actualTrials Stores how many times, the system tried to get the event data from server */
    int                                 _actualTrials;
    /*! @var _noConnectionLabel If there is no connection to server, the label is displayed to inform the user */
    IBOutlet UILabel                    *_noConnectionLabel;
    /*! @var _noConnectionButton If there is no connection to server, the button is displayed, so the user can trigger another trial to connect to the server */
    IBOutlet GradientButton             *_noConnectionButton;

    /*! @var _titleNavigationBar Shows the title */
    IBOutlet UINavigationBar            *_titleNavigationBar;
    /*! @var _titleNavigationItem Used as navigation item for title */
    IBOutlet UINavigationItem           *_titleNavigationItem;
    
    /*! @var _zhawColor Holds all color schemes needed */
    ColorSelection                      *_zhawColor;
    
    /*! @var _waitForLoadingActivityIndicator Waiting indicator to show the user something is loading */
    IBOutlet UIActivityIndicatorView    *_waitForLoadingActivityIndicator;
}

@property (nonatomic, retain) NewsChannelDto                        *_newsChannel;

@property (nonatomic, retain) DateFormation                         *_dateFormatter;
@property (nonatomic, retain) ColorSelection                        *_zhawColor;

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;

@property (nonatomic, retain) IBOutlet UITableView                  *_eventsTable;
@property (nonatomic, retain) IBOutlet UITableViewCell              *_eventsTableCell;

@property (nonatomic, assign) int                                   _actualTrials;
@property (nonatomic, retain) IBOutlet GradientButton               *_noConnectionButton;
@property (nonatomic, retain) IBOutlet UILabel                      *_noConnectionLabel;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView      *_waitForLoadingActivityIndicator;

/*!
 @function tryConnectionAgain
 Triggered by clicking the _noConnectionButton, another trial to connect to server is started.
 @param sender
 */
- (IBAction)tryConnectionAgain:(id)sender;

@end
