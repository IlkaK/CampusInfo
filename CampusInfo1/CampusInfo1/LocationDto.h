/*
 LocationDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header LocationDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the location data in MensaOverviewDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives location id, name and version to be initally set or a dictionary to browse the data itself. </li>
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

@interface LocationDto : NSObject
{
    /*! @var _locationId Stores the id of the location */
    int               _locationId;
    /*! @var _planType Holds the name of the location */
    NSString         *_name;
    /*! @var _version Holds the version of the location */
    NSString         *_version;
}

@property (nonatomic, assign) int               _locationId;
@property (nonatomic, retain) NSString          *_name;
@property (nonatomic, retain) NSString          *_version;

/*!
 @function init
 Initializes LocationDto.
 @param newLocationId
 @param newName
 @param newVersion
 */
-(id)                   init: (int) newLocationId
                    withName: (NSString *)newName
                 withVersion: (NSString *)newVersion;

/*!
 @function getLocation
 Is called when a new LocationDto instance should be created based on the dictionary information.
 @param locationDictionary
 */
- (LocationDto *)getLocation:(NSDictionary *)locationDictionary;

@end