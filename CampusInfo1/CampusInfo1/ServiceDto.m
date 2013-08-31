//
//  ServiceDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 31.08.13.
//
//

#import "ServiceDto.h"

@implementation ServiceDto
@synthesize _irregular;
@synthesize _regular;

-(id)                     init: (NSString *)newRegular
                 withIrregular: (NSString *)newIrregular
{
    self = [super init];
    if (self)
    {
        self._regular          = newRegular;
        self._irregular        = newIrregular;
    }
    return self;
}


- (ServiceDto *)getService:(NSDictionary *)serviceDictionary
{
    ServiceDto *_localService = [[ServiceDto alloc]init:nil withIrregular:nil];
    NSString *_localRegular;
    NSString *_localIrregular;
    
    for (id serviceKey in serviceDictionary)
    {
        if ([serviceDictionary objectForKey:serviceKey] != [NSNull null])
        {
            
            if ([serviceKey isEqualToString:@"regular"])
            {
                _localRegular = [serviceDictionary objectForKey:serviceKey];
                //NSLog(@"StationDto _localStationId: %i", _localStationId);
            }
            
            if ([serviceKey isEqualToString:@"irregular"])
            {
                
                _localIrregular = [serviceDictionary objectForKey:serviceKey];
                //NSLog(@"StationDto _localScore: %i", _localScore);
            }
        }
    }
    
    _localService = [_localService init:_localRegular withIrregular:_localIrregular];
    return _localService;
}

@end
