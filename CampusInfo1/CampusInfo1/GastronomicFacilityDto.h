//
//  GastronomicFacilityDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 17.07.13.
//
//

#import <Foundation/Foundation.h>

@interface GastronomicFacilityDto : NSObject
{
    NSMutableArray   *_holidays;
    int               _gastroId;
    //LocationDto      *_location;
    NSString         *_name;
    NSMutableArray   *_serviceTimePeriods;
    NSString         *_type;
    NSString         *_version;
}

@property (nonatomic, retain) NSMutableArray    *_holidays;
@property (nonatomic, assign) int               _gastroId;
//@property (nonatomic, retain) LocationDto       *_location;
@property (nonatomic, retain) NSString          *_name;
@property (nonatomic, retain) NSMutableArray    *_serviceTimePeriods;
@property (nonatomic, retain) NSString          *_type;
@property (nonatomic, retain) NSString          *_version;

-(id)                   init: (NSMutableArray  *) newHolidays
                withGastroId: (int) newGastroId
                //withLocation: (LocationDto *)newLocation
                    withName: (NSString *)newName
      withServiceTimePeriods: (NSMutableArray *)newServiceTimePeriods
                    withType: (NSString *)newType
                 withVersion: (NSString *)newVersion;

@end