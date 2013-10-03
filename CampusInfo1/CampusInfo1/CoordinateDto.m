/*
 CoordinateDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header CoordinateDto.m
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

#import "CoordinateDto.h"

@end

@implementation CoordinateDto

@synthesize _type;
@synthesize _x;
@synthesize _y;

/*!
 @function init
 Needs to be called initally, when instance of CoordinateDto is created.
 @param newType
 @param newX
 @param newY
 */
-(id)init: (NSString  *) newType
    withX: (double) newX
    withY: (double) newY
{
    self = [super init];
    if (self)
    {
        self._type = newType;
        self._x    = newX;
        self._y    = newY;
    }
    return self;
}

/*!
 @function getCoordinate
 Is called when a new CoordinateDto instance should be created based on the dictionary information.
 @param coordinateDictionary
 */
- (CoordinateDto *)getCoordinate:(NSDictionary *)coordinateDictionary
{
    NSString *_localType;
    double   _localX;
    double   _localY;

    CoordinateDto *_localCoordinate = [[CoordinateDto alloc]init:nil withX:0 withY:0];
    
    for (id coordinateKey in coordinateDictionary)
    {
        //NSLog(@"_gastronomicFacilitiesDictionary key: %@", gastronomicFacilitiesKey);
        
        if ([coordinateKey isEqualToString:@"type"])
        {
            _localType = [coordinateDictionary objectForKey:coordinateKey];
            //NSLog(@"CoordinateDto _localType: %@", _localType);
        }
        
        if ([coordinateKey isEqualToString:@"x"])
        {
            _localX = [[coordinateDictionary objectForKey:coordinateKey] doubleValue];
            //NSLog(@"CoordinateDto _localX: %f", _localX);
        }
        
        if ([coordinateKey isEqualToString:@"y"])
        {
            _localY = [[coordinateDictionary objectForKey:coordinateKey] doubleValue];
            //NSLog(@"CoordinateDto _localY: %f", _localY);
        }
    }
    _localCoordinate = [[CoordinateDto alloc]init:_localType withX:_localX withY:_localY];
    return _localCoordinate;
}

@end
