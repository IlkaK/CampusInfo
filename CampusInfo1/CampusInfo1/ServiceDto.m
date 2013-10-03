/*
 ServiceDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ServiceDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the service data for PublicTransportConnectionDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives regular and irregular to be initally set or a dictionary to browse the data itself. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It returns itself when called. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "ServiceDto.h"

@implementation ServiceDto
@synthesize _irregular;
@synthesize _regular;

/*!
 @function init
 Needs to be called initally, when instance of ServiceDto is created.
 @param newRegular
 @param newIrregular
 */
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

/*!
 @function getService
 Is called when a new ServiceDto instance should be created based on the dictionary information.
 @param serviceDictionary
 */
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
