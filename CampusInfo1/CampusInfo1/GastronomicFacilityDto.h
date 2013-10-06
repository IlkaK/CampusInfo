/*
 GastronomicFacilityDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header GastronomicFacilityDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the gastronomic facility data in MensaOverviewDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives an array of holidays, id, location, name, service time plan, type and version to be initally set or a dictionary to browse the data itself. </li>
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

#import <Foundation/Foundation.h>

@class LocationDto;

@interface GastronomicFacilityDto : NSObject
{
    /*! @var _holidays Holds an array of holidays of the gastronomic facility */
    NSMutableArray   *_holidays;
    /*! @var _gastroId Stores the id of the gastronomic facility */
    int               _gastroId;
    /*! @var _location Holds the location of the gastronomic facility */
    LocationDto      *_location;
    /*! @var _name Holds the name of the gastronomic facility */
    NSString         *_name;
    /*! @var _serviceTimePeriods Holds an array of service time periods of the gastronomic facility */
    NSMutableArray   *_serviceTimePeriods;
    /*! @var _type Holds the type of the gastronomic facility */
    NSString         *_type;
    /*! @var _version Holds the version of the gastronomic facility */
    NSString         *_version;
}

@property (nonatomic, retain) NSMutableArray    *_holidays;
@property (nonatomic, assign) int               _gastroId;
@property (nonatomic, retain) LocationDto       *_location;
@property (nonatomic, retain) NSString          *_name;
@property (nonatomic, retain) NSMutableArray    *_serviceTimePeriods;
@property (nonatomic, retain) NSString          *_type;
@property (nonatomic, retain) NSString          *_version;

/*!
 @function init
 Initializes GastronomicFacilityDto.
 @param newHolidays
 @param newGastroId
 @param newLocation
 @param newName
 @param newServiceTimePeriods
 @param newType
 @param newVersion
 */
-(id)                   init: (NSMutableArray  *) newHolidays
                withGastroId: (int) newGastroId
                withLocation: (LocationDto *)newLocation
                    withName: (NSString *)newName
      withServiceTimePeriods: (NSMutableArray *)newServiceTimePeriods
                    withType: (NSString *)newType
                 withVersion: (NSString *)newVersion;

/*!
 @function getGastronomicFacility
 Is called when a new GastronomicFacilityDto instance should be created based on the dictionary information.
 @param gastronomicDictionary
 */
- (GastronomicFacilityDto *)getGastronomicFacility:(NSDictionary *)gastronomicDictionary;

@end