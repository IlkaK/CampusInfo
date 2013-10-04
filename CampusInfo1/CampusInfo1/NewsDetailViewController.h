/*
 NewsDetailViewController.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header NewsDetailViewController.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of NewsDetailViewController.xib, where all elements of a chosen news item displays. </li>
 *      <li> Displaying one of the news items.  </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives delegate from NewsViewController and passes it back, if back button is clicked. </li>
 *      <li> It receives data from NewsViewController as well. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It passes the delegate back to NewsViewController. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <UIKit/UIKit.h>
#import "NewsItemDto.h"
#import "DateFormation.h"

@interface NewsDetailViewController : UIViewController
{
    /*! @var _titleNavigationBar Used as background for title */
    IBOutlet UINavigationBar    *_titleNavigationBar;
    /*! @var _titleNavigationItem Used as navigation item for title */
    IBOutlet UINavigationItem   *_titleNavigationItem;
    /*! @var _titleNavigationLabel Shows the title */
    IBOutlet UILabel            *_titleNavigationLabel;    
    
    /*! @var _descriptionNavigationBar Used as background for description of the news item */
    IBOutlet UINavigationBar    *_descriptionNavigationBar;
    /*! @var _descriptionNavigationItem Used as navigation item for description of the news item */
    IBOutlet UINavigationItem   *_descriptionNavigationItem;
    /*! @var _descriptionTitleLabel Shows the description of the news item */
    IBOutlet UILabel            *_descriptionTitleLabel;
    
    /*! @var _dateLabel Shows the date and time of the news item */
    IBOutlet UILabel            *_dateLabel;
    /*! @var _linkButton Shows the link of the news item */
    IBOutlet UIButton           *_linkButton;
    /*! @var _contentWebView Displays the content of the news item */
    IBOutlet UIWebView          *_contentWebView;
    
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation               *_dateFormatter;
    /*! @var _newsItem Holds the news item data */
    NewsItemDto                 *_newsItem;    
}

@property (nonatomic, retain) UINavigationBar                       *_titleNavigationBar;
@property (nonatomic, retain) UINavigationItem                      *_titleNavigationItem;
@property (nonatomic, retain) UILabel                               *_titleNavigationLabel;

@property (nonatomic, retain) UINavigationBar                       *_descriptionNavigationBar;
@property (nonatomic, retain) UINavigationItem                      *_descriptionNavigationItem;
@property (nonatomic, retain) UILabel                               *_descriptionTitleLabel;

@property (nonatomic, retain) UILabel                               *_dateLabel;
@property (nonatomic, retain) UIButton                              *_linkButton;
@property (nonatomic, retain) UIWebView                             *_contentWebView;

@property (strong, nonatomic) NewsItemDto                           *_newsItem;
@property (nonatomic, retain) DateFormation                         *_dateFormatter;

@end
