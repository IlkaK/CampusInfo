/*
 NewsChannelDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header NewsChannelDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds data for news channel in NewsDto model. </li>
 *      <li> Uses TimeTableAsyncRequestDelegate to connect to server and gain all news/events. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives a title, link, description, content, category, start date, start date and publishing date to be initally set. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It returns itself when called. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <Foundation/Foundation.h>
#import "TimeTableAsyncRequest.h"
#import "DateFormation.h"
#import "NewsImageDto.h"
#import "NewsItemDto.h"

@interface NewsChannelDto  : NSObject<TimeTableAsyncRequestDelegate, NSXMLParserDelegate>
{
    /*! @var _generalDictionary Stores the dictionary of data which is returned by the server */
    NSDictionary                *_generalDictionary;
    
    /*! @var _asyncTimeTableRequest Handles connection to server */  
    TimeTableAsyncRequest       *_asyncTimeTableRequest;
    /*! @var _dataFromUrl Holding data gained from url */
    NSData                      *_dataFromUrl;
    /*! @var _errorMessage Stores the error message, if the connection to server had an error. */  
    NSString                    *_errorMessage;
    /*! @var _connectionTrials Stores how often system tried to connect to server. */
    int                         _connectionTrials;  
    
    /*! @var _actualValue Holds the actual value which parsed from the XML */
    NSString                    *_actualValue;
    /*! @var _actualStartElement Holds the start element which parsed from the XML */
    NSString                    *_actualStartElement;
    /*! @var _actualEndElement Holds the actual end element which parsed from the XML */
    NSString                    *_actualEndElement;
    
    /*! @var _dataType Defines if events or news are loaded */
    NSString                    *_dataType;
    
    /*! @var _title Holds the title of the news channel */
    NSString                    *_title;
    /*! @var _link Holds the link of the news channel */
    NSString                    *_link;
    /*! @var _description Holds the description of the news channel */
    NSString                    *_description;
    /*! @var _language Holds the language of the news channel */
    NSString                    *_language;
    /*! @var _generator Holds the generator of the news channel */
    NSString                    *_generator;
    /*! @var _docs Holds the docs of the news channel */
    NSString                    *_docs;
    /*! @var _lastBuildDate Holds the last build date of the news channel */    
    NSDate                      *_lastBuildDate;
    
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation               *_dateFormatter;
    
    /*! @var _startChannel Defines if the news channel is parsed */
    BOOL                        _startChannel;
    /*! @var _startImage Defines if a news image is parsed */
    BOOL                        _startImage;
    /*! @var _startItem Defines if a news item is parsed */
    BOOL                        _startItem;
    
    /*! @var _newsImage Holds the actual parsed news image */
    NewsImageDto                *_newsImage;
    /*! @var _newsItem Holds the actual parsed news item */
    NewsItemDto                 *_newsItem;
    
    /*! @var _newsItemArray Holds all news items gathered via server connection */
    NSMutableArray              *_newsItemArray;
}

@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest *_asyncTimeTableRequest;

@property (strong, nonatomic) NSDictionary                   *_generalDictionary;

@property (nonatomic, retain) NSData                         *_dataFromUrl;
@property (nonatomic, retain) NSString                       *_errorMessage;
@property (nonatomic, assign) int                             _connectionTrials;

@property (nonatomic, retain) NSString                       *_actualValue;
@property (nonatomic, retain) NSString                       *_actualStartElement;
@property (nonatomic, retain) NSString                       *_actualEndElement;

@property (nonatomic, assign) BOOL                           _startChannel;
@property (nonatomic, assign) BOOL                           _startImage;
@property (nonatomic, assign) BOOL                           _startItem;

@property (nonatomic, retain) NSString                      *_title;
@property (nonatomic, retain) NSString                      *_link;
@property (nonatomic, retain) NSString                      *_description;
@property (nonatomic, retain) NSString                      *_language;
@property (nonatomic, retain) NSString                      *_generator;
@property (nonatomic, retain) NSString                      *_docs;
@property (nonatomic, retain) NSDate                        *_lastBuildDate;

@property (nonatomic, retain) NSString                       *_dataType;

@property (nonatomic, retain) DateFormation                  *_dateFormatter;
@property (nonatomic, retain) NewsImageDto                   *_newsImage;
@property (nonatomic, retain) NewsItemDto                    *_newsItem;
@property (nonatomic, retain) NSMutableArray                 *_newsItemArray;

@property(nonatomic, assign) id<NSXMLParserDelegate> delegate;

/*!
 @function initWithDataType
 Needs to be called initally, when instance of NewsChannelDto is created.
 @param newDataType
 */
- (id)initWithDataType:(NSString *)newDataType;

/*!
 @function getNewsData
 Gets the channel data for news.
 */
-(void) getNewsData;

/*!
 @function getEventData
 Gets the channel data for events.
 */
-(void) getEventData;

@end
