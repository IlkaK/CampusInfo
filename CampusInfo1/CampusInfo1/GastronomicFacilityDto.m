//
//  GastronomicFacilityDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 17.07.13.
//
//

#import "GastronomicFacilityDto.h"

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

@end
