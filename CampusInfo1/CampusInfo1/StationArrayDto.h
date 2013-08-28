//
//  StationArrayDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 28.08.13.
//
//

#import <Foundation/Foundation.h>
#import <TimeTableAsyncRequest.h>


@interface StationArrayDto : NSObject<TimeTableAsyncRequestDelegate>
{
    NSMutableArray              *_stations;
    NSString                    *_actualStation;
    
    NSDictionary                *_generalDictionary;
    TimeTableAsyncRequest       *_asyncTimeTableRequest;
    NSData                      *_dataFromUrl;
    NSString                    *_errorMessage;
    int                         _connectionTrials;
    NSURL                       *_url;
}

@property (nonatomic, retain) NSMutableArray                    *_stations;
@property (nonatomic, retain) NSString                          *_actualStation;

@property (strong, nonatomic) NSDictionary                      *_generalDictionary;
@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest    *_asyncTimeTableRequest;
@property (nonatomic, retain) NSData                            *_dataFromUrl;
@property (nonatomic, retain) NSString                          *_errorMessage;
@property (nonatomic, assign) int                               _connectionTrials;
@property (nonatomic, retain) NSURL                             *_url;

-(id)   init : (NSMutableArray *) newStations;

-(void) getData:(NSString *)newActualStation;


@end
