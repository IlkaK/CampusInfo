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
//@synthesize _location;

-(id)                   init: (NSMutableArray  *) newHolidays
                withGastroId: (int) newGastroId
                //withLocation: (LocationDto *)newLocation
                    withName: (NSString *)newName
      withServiceTimePeriods: (NSMutableArray *)newServiceTimePeriods
                    withType: (NSString *)newType
                 withVersion: (NSString *)newVersion
{
    self = [super init];
    //if (self)
    //{
    //    self._name = newName;
    //}
    return self;
}

@end
