//
//  SomethingDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 14.08.13.
//
//

#import <Foundation/Foundation.h>
#import <TimeTableAsyncRequest.h>

@interface SomethingDto : NSObject<TimeTableAsyncRequestDelegate, NSXMLParserDelegate>
{
    NSDictionary                *_generalDictionary;
    
    TimeTableAsyncRequest       *_asyncTimeTableRequest;
    NSData                      *_dataFromUrl;
    NSString                    *_errorMessage;
    int                         _connectionTrials;
    
    // data structure
    NSString                    *_title;
    NSString                    *_link;
    NSString                    *_language;
    NSString                    *_newsUrl;
    int                         _width;
    int                         _height;
    
}

@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest *_asyncTimeTableRequest;

@property (strong, nonatomic) NSDictionary                   *_generalDictionary;

@property (nonatomic, retain) NSData                         *_dataFromUrl;
@property (nonatomic, retain) NSString                       *_errorMessage;
@property (nonatomic, assign) int                             _connectionTrials;

@property(nonatomic, assign) id<NSXMLParserDelegate> delegate;

-(void) getData;

@end
