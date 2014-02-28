/*
 NewsViewController.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header NewsViewController.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of NewsViewController.xib, where an overview of all news is displayed in a table. </li>
 *      <li> Getting and handling news data via NewsChannelDto.  </li>
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
 *      <li> It passes the delegate to NewsDetailViewController. </li>
 *      <li> It also passes the news channel data to NewsDetailViewController, so it can display the details. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <UIKit/UIKit.h>
#import "NewsChannelDto.h"
#import "NewsDetailViewController.h"
#import "DateFormation.h"
#import "ColorSelection.h"

@class NewsDetailViewController;


@interface NewsViewController : UIViewController<UITableViewDelegate>
{
    /*! @var _newsChannel Holds the news channel data */
    NewsChannelDto                      *_newsChannel;
    
    /*! @var _newsTable Table to display the news overview */
    IBOutlet UITableView                *_newsTable;
    /*! @var _newsTableCell Handles cell, which displays the solo news */
    IBOutlet UITableViewCell            *_newsTableCell;
    
    IBOutlet UITableViewCell *_newsSmallTableCell;
    IBOutlet UITableViewCell *_newsNormalTableCell;
    IBOutlet UITableViewCell *_newsLargeTableCell;
    
    
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation                       *_dateFormatter;
    
    /*! @var _zhawColor Holds all color schemes needed */
    ColorSelection                      *_zhawColor;
    
    /*! @var _newsDetailVC Handles delegate from and to NewsDetailViewController, is triggered when the detail button in one of the news cells is hit */
    IBOutlet NewsDetailViewController   *_newsDetailVC;
    
    /*! @var _actualTrials Stores how many times, the system tried to get the event data from server */
    int                                 _actualTrials;
    /*! @var _noConnectionButton If there is no connection to server, the button is displayed, so the user can trigger another trial to connect to the server */
    IBOutlet UIButton                   *_noConnectionButton;
    /*! @var _noConnectionLabel If there is no connection to server, the label is displayed to inform the user */
    IBOutlet UILabel                    *_noConnectionLabel;
    
    /*! @var _titleNavigationBar Shows the title */
    IBOutlet UINavigationBar            *_titleNavigationBar;
    /*! @var _titleNavigationItem Used as navigation item for title */
    IBOutlet UINavigationItem           *_titleNavigationItem;
    
    /*! @var _waitForLoadingActivityIndicator Waiting indicator to show the user something is loading */
    IBOutlet UIActivityIndicatorView    *_waitForLoadingActivityIndicator;
}

@property (strong, nonatomic) NewsChannelDto                        *_newsChannel;

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;

@property (nonatomic, retain) IBOutlet UITableView                  *_newsTable;
@property (nonatomic, retain) IBOutlet UITableViewCell              *_newsTableCell;

@property (nonatomic, retain) IBOutlet UITableViewCell              *_newsSmallTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell              *_newsNormalTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell              *_newsLargeTableCell;

@property (nonatomic, retain) DateFormation                         *_dateFormatter;
@property (nonatomic, retain) ColorSelection                        *_zhawColor;

@property (nonatomic, retain) IBOutlet NewsDetailViewController     *_newsDetailVC;

@property (nonatomic, assign) int                                   _actualTrials;
@property (nonatomic, retain) IBOutlet UIButton                     *_noConnectionButton;
@property (nonatomic, retain) IBOutlet UILabel                      *_noConnectionLabel;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView      *_waitForLoadingActivityIndicator;

/*!
 @function tryConnectionAgain
 Triggered by clicking the _noConnectionButton, another trial to connect to server is started.
 @param sender
 */
- (IBAction)tryConnectionAgain:(id)sender;

@end
