//
//  PrognosisDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 31.08.13.
//
//

#import "PrognosisDto.h"

@implementation PrognosisDto
@synthesize _arrival;
@synthesize _capacity1st;
@synthesize _capacity2nd;
@synthesize _departure;
@synthesize _platform;
@synthesize _dateFormatter;

-(id)                   init: (NSString *)newPlatform
                 withArrival: (NSDate *)newArrival
               withDeparture: (NSDate *)newDeparture
             withCapacity1st: (int) newCapacity1st
             withCapacity2nd: (int) newCapacity2nd
{
    self = [super init];
    _dateFormatter  = [[DateFormation alloc] init];
    if (self)
    {
        self._platform          = newPlatform;
        self._arrival           = newArrival;
        self._departure         = newDeparture;
        self._capacity1st       = newCapacity1st;
        self._capacity2nd       = newCapacity2nd;
    }
    return self;
}

- (PrognosisDto *)getPrognosis:(NSDictionary *)prognosisDictionary
{
    NSString        *_localPlatform;
    NSDate          *_localArrival;
    NSDate          *_localDeparture;
    int               _localCapacity1st;
    int               _localCapacity2nd;

    PrognosisDto *_localPrognosis = [[PrognosisDto alloc]init:nil withArrival:nil withDeparture:nil withCapacity1st:nil withCapacity2nd:nil];
    
    for (id prognosisKey in prognosisDictionary)
    {
        if ([prognosisDictionary objectForKey:prognosisKey] != [NSNull null])
        {
            
            if ([prognosisKey isEqualToString:@"capacity1st"])
            {
                _localCapacity1st = [[prognosisDictionary objectForKey:prognosisKey] intValue];
                //NSLog(@"StationDto _localStationId: %i", _localStationId);
            }
            
            if ([prognosisKey isEqualToString:@"capacity2nd"])
            {
                
                _localCapacity2nd = [[prognosisDictionary objectForKey:prognosisKey] intValue];
                //NSLog(@"StationDto _localScore: %i", _localScore);
            }
            
            if ([prognosisKey isEqualToString:@"platform"])
            {
                _localPlatform = [prognosisDictionary objectForKey:prognosisKey];
                //NSLog(@"StationDto _localName: %@", _localName);
            }
            
            if ([prognosisKey isEqualToString:@"arrival"])
            {
                _localArrival = [_dateFormatter parseDate:[prognosisDictionary objectForKey:prognosisKey]];
                //NSLog(@"StationDto _localDistance: %@", _localDistance);
            }
            
            if ([prognosisKey isEqualToString:@"departure"])
            {
                _localDeparture = [_dateFormatter parseDate:[prognosisDictionary objectForKey:prognosisKey]];
            }
        }
    }
    
    _localPrognosis = [_localPrognosis init:_localPlatform
                                withArrival:_localArrival
                              withDeparture:_localDeparture
                            withCapacity1st:_localCapacity1st
                            withCapacity2nd:_localCapacity2nd];
    return _localPrognosis;

    
    
}


@end
