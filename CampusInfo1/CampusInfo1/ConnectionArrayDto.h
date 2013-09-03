//
//  ConnectionArrayDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 02.09.13.
//
//

#import <Foundation/Foundation.h>
#import <TimeTableAsyncRequest.h>

@interface ConnectionArrayDto : NSObject<TimeTableAsyncRequestDelegate>
{
    NSMutableArray              *_connections;
    
    NSDictionary                *_generalDictionary;
    TimeTableAsyncRequest       *_asyncTimeTableRequest;
    NSData                      *_dataFromUrl;
    NSString                    *_errorMessage;
    int                         _connectionTrials;
    NSURL                       *_url;
}

@property (nonatomic, retain) NSMutableArray                    *_connections;

@property (strong, nonatomic) NSDictionary                      *_generalDictionary;
@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest    *_asyncTimeTableRequest;
@property (nonatomic, retain) NSData                            *_dataFromUrl;
@property (nonatomic, retain) NSString                          *_errorMessage;
@property (nonatomic, assign) int                               _connectionTrials;
@property (nonatomic, retain) NSURL                             *_url;

-(id)   init : (NSMutableArray *) newConnections;

-(void) getData;


@end
