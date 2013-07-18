//
//  ServiceTimePeriodDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 18.07.13.
//
//

#import <Foundation/Foundation.h>

@interface ServiceTimePeriodDto : NSObject
{
    NSDate          *_endsOn;
    NSDate          *_startsOn;
    int             _serviceTimePeriodId;
    NSMutableArray *_lunchTimePlans;
    NSMutableArray *_openingTimePlans;
}

@property (nonatomic, retain) NSDate            *_endsOn;
@property (nonatomic, retain) NSDate            *_startsOn;
@property (nonatomic, assign) int               _serviceTimePeriodId;
@property (nonatomic, retain) NSMutableArray    *_lunchTimePlans;
@property (nonatomic, retain) NSMutableArray    *_openingTimePlans;

-(id)                  init: (NSDate *) newEndsOn
               withStartsOn: (NSDate *) newStartsOn
    withServiceTimePeriodId: (int) newServiceTimePeriodId
         withLunchTimePlans: (NSMutableArray *)newLunchTimePlans
       withOpeningTimePlans: (NSMutableArray *)newOpeningTimePlans;

@end