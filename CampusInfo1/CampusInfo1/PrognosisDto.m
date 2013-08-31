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

-(id)                   init: (NSString *)newPlatform
                 withArrival: (NSString *)newArrival
               withDeparture: (NSString *)newDeparture
             withCapacity1st: (int) newCapacity1st
             withCapacity2nd: (int) newCapacity2nd
{
    self = [super init];
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
    NSString        *_localArrival;
    NSString        *_localDeparture;
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
                _localArrival = [prognosisDictionary objectForKey:prognosisKey];
                //NSLog(@"StationDto _localDistance: %@", _localDistance);
            }
            
            if ([prognosisKey isEqualToString:@"departure"])
            {
                _localDeparture = [prognosisDictionary objectForKey:prognosisKey];
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
