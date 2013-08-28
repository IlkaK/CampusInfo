//
//  CoordinateDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 28.08.13.
//
//

#import "CoordinateDto.h"

@end

@implementation CoordinateDto

@synthesize _type;
@synthesize _x;
@synthesize _y;

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
