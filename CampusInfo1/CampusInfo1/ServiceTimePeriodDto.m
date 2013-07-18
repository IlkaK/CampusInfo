//
//  ServiceTimePeriodDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 18.07.13.
//
//

#import "ServiceTimePeriodDto.h"

@implementation ServiceTimePeriodDto
@synthesize _endsOn;
@synthesize _startsOn;
@synthesize _serviceTimePeriodId;
@synthesize _lunchTimePlans;
@synthesize _openingTimePlans;

-(id)                  init: (NSDate *) newEndsOn
               withStartsOn: (NSDate *) newStartsOn
    withServiceTimePeriodId: (int) newServiceTimePeriodId
         withLunchTimePlans: (NSMutableArray *)newLunchTimePlans
       withOpeningTimePlans: (NSMutableArray *)newOpeningTimePlans
{
    self = [super init];
    if (self)
    {
        self._endsOn = newEndsOn;
        self._startsOn = newStartsOn;
        self._serviceTimePeriodId = newServiceTimePeriodId;
        self._lunchTimePlans = newLunchTimePlans;
        self._openingTimePlans = newOpeningTimePlans;
    }
    return self;
}

@end

