//
//  MenuPlanArrayDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 20.08.13.
//
//

#import <Foundation/Foundation.h>
#import "MenuDto.h"
#import "TimeTableAsyncRequest.h"

@interface MenuPlanArrayDto : NSObject<TimeTableAsyncRequestDelegate>
{
    NSMutableArray              *_menuPlans;
    DateFormation               *_dateFormatter;
    
    NSDictionary                *_generalDictionary;
    TimeTableAsyncRequest       *_asyncTimeTableRequest;
    NSData                      *_dataFromUrl;
    NSString                    *_errorMessage;
    int                         _connectionTrials;
    
    int                         _actualYear;
    int                         _actualCalendarWeek;
}

@property (nonatomic, retain) NSMutableArray                    *_menuPlans;
@property (nonatomic, retain) DateFormation                     *_dateFormatter;

@property (strong, nonatomic) NSDictionary                      *_generalDictionary;
@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest    *_asyncTimeTableRequest;
@property (nonatomic, retain) NSData                            *_dataFromUrl;
@property (nonatomic, retain) NSString                          *_errorMessage;
@property (nonatomic, assign) int                               _connectionTrials;

@property (nonatomic, assign) int                               _actualYear;
@property (nonatomic, assign) int                               _actualCalendarWeek;

-(id)   init : (NSMutableArray *) newMenuPlans;

-(void) getData:(int)calendarWeek
       withYear:(int)year
 withActualDate:(NSDate *)actualDate
   withGastroId:(int)gastroId;

-(MenuDto *)getActualMenu:(NSDate *)actualDate
             withGastroId:(int)gastroId;

@end
