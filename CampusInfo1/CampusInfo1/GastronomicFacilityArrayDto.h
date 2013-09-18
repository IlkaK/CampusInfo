//
//  GastronomicFacilityArrayDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 28.08.13.
//
//

#import <Foundation/Foundation.h>
#import "TimeTableAsyncRequest.h"
#import "GastronomicFacilityDto.h"
#import "DateFormation.h"

@interface GastronomicFacilityArrayDto : NSObject<TimeTableAsyncRequestDelegate>
{
    NSMutableArray              *_gastronomicFacilities;
    DateFormation               *_dateFormatter;
    
    NSDictionary                *_generalDictionary;
    TimeTableAsyncRequest       *_asyncTimeTableRequest;
    NSData                      *_dataFromUrl;
    NSString                    *_errorMessage;
    int                         _connectionTrials;
    NSURL                       *_url;
    
    BOOL                        _threadDone;
    
    BOOL                        _noConnection;
}

@property (nonatomic, retain) NSMutableArray                    *_gastronomicFacilities;
@property (nonatomic, retain) DateFormation                     *_dateFormatter;

@property (strong, nonatomic) NSDictionary                      *_generalDictionary;
@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest    *_asyncTimeTableRequest;
@property (nonatomic, retain) NSData                            *_dataFromUrl;
@property (nonatomic, retain) NSString                          *_errorMessage;
@property (nonatomic, assign) int                               _connectionTrials;
@property (nonatomic, retain) NSURL                             *_url;

@property (nonatomic, assign) BOOL                              _threadDone;
@property (nonatomic, assign) BOOL                              _noConnection;

-(id)   init : (NSMutableArray *) newGastronomicFacilities;

-(void) getData;


@end
