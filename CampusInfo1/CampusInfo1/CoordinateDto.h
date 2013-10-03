/*
 CoordinateDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header CoordinateDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds coordinate data for PublicTransportDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives x, y and type to be initally set or a dictionary to browse the data itself. </li>
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

@interface CoordinateDto : NSObject
{
    /*! @var _type Stores the type of the coordinate */
    NSString         *_type;
    /*! @var _x Stores the x-value of the coordinate */
    double           _x;
    /*! @var _y Stores the y-value of the coordinate */
    double           _y;
}

@property (nonatomic, retain) NSString          *_type;
@property (nonatomic, assign) double            _x;
@property (nonatomic, assign) double            _y;

/*!
 @function init
 Needs to be called initally, when instance of CoordinateDto is created.
 @param newType
 @param newX
 @param newY
 */
-(id)init: (NSString  *) newType
    withX: (double) newX
    withY: (double) newY;

/*!
 @function getCoordinate
 Is called when a new CoordinateDto instance should be created based on the dictionary information.
 @param coordinateDictionary
 */
- (CoordinateDto *)getCoordinate:(NSDictionary *)coordinateDictionary;


