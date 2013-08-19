//
//  NewsChannelDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 15.08.13.
//
//

#import <Foundation/Foundation.h>
#import <TimeTableAsyncRequest.h>
#import <DateFormation.h>
#import <NewsImageDto.h>
#import <NewsItemDto.h>

@interface NewsChannelDto  : NSObject<TimeTableAsyncRequestDelegate, NSXMLParserDelegate>
{
    NSDictionary                *_generalDictionary;
    
    TimeTableAsyncRequest       *_asyncTimeTableRequest;
    NSData                      *_dataFromUrl;
    NSString                    *_errorMessage;
    int                         _connectionTrials;
    
    // actual data read from XML parser
    NSString                    *_actualValue;
    NSString                    *_actualStartElement;
    NSString                    *_actualEndElement;
    
    NSString                    *_dataType;
    
    // data structure of channel
    NSString                    *_title;
    NSString                    *_link;
    NSString                    *_description;
    NSString                    *_language;
    NSString                    *_generator;
    NSString                    *_docs;
    NSDate                      *_lastBuildDate;
    
    DateFormation               *_dateFormatter;
    
    BOOL                        _startChannel;
    BOOL                        _startImage;
    BOOL                        _startItem;
    
    NewsImageDto                *_newsImage;
    NewsItemDto                 *_newsItem;
    
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

-(void) getNewsData;
-(void) getEventData;

@end
