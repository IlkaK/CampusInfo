//
//  ClassesDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 07.08.13.
//
//

#import <Foundation/Foundation.h>
#import "TimeTableAsyncRequest.h"
#import "DBCachingForAutocomplete.h"

@interface ClassesDto : NSObject<TimeTableAsyncRequestDelegate>
{
    DBCachingForAutocomplete    *_dbCachingForAutocomplete;
    
    NSMutableArray              *_classArray;
    NSMutableArray              *_classArrayFromDB;
    
    NSDictionary                *_generalDictionary;
    
    TimeTableAsyncRequest       *_asyncTimeTableRequest;
    NSData                      *_dataFromUrl;
    NSString                    *_errorMessage;
    int                         _connectionTrials;
}

@property (nonatomic, retain) DBCachingForAutocomplete      *_dbCachingForAutocomplete;
@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest *_asyncTimeTableRequest;

@property (strong, nonatomic) NSMutableArray                *_classArray;
@property (strong, nonatomic) NSMutableArray                *_classArrayFromDB;

@property (strong, nonatomic) NSDictionary                   *_generalDictionary;

@property (nonatomic, retain) NSData                         *_dataFromUrl;
@property (nonatomic, retain) NSString                       *_errorMessage;
@property (nonatomic, assign) int                             _connectionTrials;

-(void) getData;

@end
