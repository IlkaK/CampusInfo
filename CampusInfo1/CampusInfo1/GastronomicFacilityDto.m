//
//  GastronomicFacilityDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 17.07.13.
//
//

#import "GastronomicFacilityDto.h"
#import "LocationDto.h"
#import "HolidayDto.h"
#import "ServiceTimePeriodDto.h"

@implementation GastronomicFacilityDto
@synthesize _gastroId;
@synthesize _holidays;
@synthesize _location;
@synthesize _name;
@synthesize _serviceTimePeriods;
@synthesize _type;
@synthesize _version;

-(id)                   init: (NSMutableArray  *) newHolidays
                withGastroId: (int) newGastroId
                withLocation: (LocationDto *)newLocation
                    withName: (NSString *)newName
      withServiceTimePeriods: (NSMutableArray *)newServiceTimePeriods
                    withType: (NSString *)newType
                 withVersion: (NSString *)newVersion
{
    self = [super init];
    if (self)
    {
        self._holidays = newHolidays;
        self._gastroId = newGastroId;
        self._location = newLocation;
        self._name = newName;
        self._serviceTimePeriods = newServiceTimePeriods;
        self._type = newType;
        self._version = newVersion;
    }
    return self;
}


- (GastronomicFacilityDto *)getGastronomicFacility:(NSDictionary *)gastronomicDictionary
{
    int       _localGastroId;
    NSString *_localVersion;
    NSString *_localName;
    NSString *_localType;
    NSMutableArray *_holidayDictionaryArray = [[NSMutableArray alloc] init];
    NSMutableArray *_localHolidays = [[NSMutableArray alloc] init];
    NSMutableArray *_serviceTimePeriodDictionaryArray = [[NSMutableArray alloc] init];
    NSMutableArray *_localServiceTimePeriods = [[NSMutableArray alloc] init];
    
    int _holidayArrayI;
    int _serviceTimePeriodArrayI;
    
    LocationDto *_localLocation = [[LocationDto alloc] init:0 withName:nil withVersion:nil];
    HolidayDto *_localHoliday = [[HolidayDto alloc] init:0 withName:nil withVersion:nil withStartsAt:nil withEndsAt:nil];
    ServiceTimePeriodDto *_localServiceTimePeriod = [[ServiceTimePeriodDto alloc] init:nil withEndsOn:nil withServiceTimePeriodId:0 withLunchTimePlan:nil withOpeningTimePlan:nil];
    
    GastronomicFacilityDto *_localGastronomicFacilty = [[GastronomicFacilityDto alloc]init:nil withGastroId:0 withLocation:nil withName:nil withServiceTimePeriods:nil withType:nil withVersion:nil];
    
    for (id gastronomicKey in gastronomicDictionary)
    {
        //NSLog(@"GastronomicFacilityDto gastronomicKey: %@", gastronomicKey);

        if ([gastronomicKey isEqualToString:@"id"])
        {
            _localGastroId = [[gastronomicDictionary objectForKey:gastronomicKey] intValue];
            //NSLog(@"gastronomy id: %i", _localGastroId);
        }
        if ([gastronomicKey isEqualToString:@"name"])
        {
            _localName = [gastronomicDictionary objectForKey:gastronomicKey];
            //NSLog(@"gastronomy name: %@", _localName);
        }
        if ([gastronomicKey isEqualToString:@"type"])
        {
            _localType = [gastronomicDictionary objectForKey:gastronomicKey];
            //NSLog(@"gastronomy type: %@", _localType);
        }
        if ([gastronomicKey isEqualToString:@"version"])
        {
            _localVersion = [gastronomicDictionary objectForKey:gastronomicKey];
            //NSLog(@"gastronomy version: %@", _localVersion);
        }
        if ([gastronomicKey isEqualToString:@"location"])
        {
            _localLocation = [_localLocation getLocation:[gastronomicDictionary objectForKey:gastronomicKey]];
        }
        
        if ([gastronomicKey isEqualToString:@"holidays"])
        {
            _holidayDictionaryArray = [gastronomicDictionary objectForKey:gastronomicKey];
            
            if([_holidayDictionaryArray lastObject] != nil)
            {
                for (_holidayArrayI = 0; _holidayArrayI < [_holidayDictionaryArray count]; _holidayArrayI++)
                {
                    _localHoliday = [_localHoliday getHoliday:[_holidayDictionaryArray objectAtIndex:_holidayArrayI]];
                    [_localHolidays addObject:_localHoliday];
                }
            }
            
        }
        
        if ([gastronomicKey isEqualToString:@"serviceTimePeriods"])
        {
            _serviceTimePeriodDictionaryArray = [gastronomicDictionary objectForKey:gastronomicKey];
            //NSLog(@"-- service time period array count %i", [_serviceTimePeriodDictionaryArray count]);
        
            if([_serviceTimePeriodDictionaryArray lastObject] != nil)
            {
                NSDictionary *_serviceTimeDictionary; 
                for (_serviceTimePeriodArrayI = 0; _serviceTimePeriodArrayI < [_serviceTimePeriodDictionaryArray count]; _serviceTimePeriodArrayI++)
                {
                    //NSLog(@"serviceTimePeriodArray start: %i", _serviceTimePeriodArrayI);
                    _serviceTimeDictionary = [_serviceTimePeriodDictionaryArray objectAtIndex:_serviceTimePeriodArrayI];
                    //NSLog(@"serviceTimePeriodArray store dictionary: %i", _serviceTimePeriodArrayI);
                    
                    _localServiceTimePeriod = [_localServiceTimePeriod getServiceTimePeriod:_serviceTimeDictionary];
                    //NSLog(@"serviceTimePeriodArray get service: %i", _serviceTimePeriodArrayI);

                    [_localServiceTimePeriods addObject:_localServiceTimePeriod];
                    //NSLog(@"serviceTimePeriodArray added object: %i", _serviceTimePeriodArrayI);

                }
            }
        }
    }
    //NSLog(@"- found service time period array count: %i", [_localServiceTimePeriods count]);
    _localGastronomicFacilty = [_localGastronomicFacilty init:_localHolidays withGastroId:_localGastroId withLocation:_localLocation withName:_localName withServiceTimePeriods:_localServiceTimePeriods withType:_localType withVersion:_localVersion];
    return _localGastronomicFacilty;
}



@end
