//
//  CoordinateDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 28.08.13.
//
//

#import <Foundation/Foundation.h>

@interface CoordinateDto : NSObject
{
    NSString         *_type;
    double           _x;
    double           _y;
}

@property (nonatomic, retain) NSString          *_type;
@property (nonatomic, assign) double            _x;
@property (nonatomic, assign) double            _y;

-(id)init: (NSString  *) newType
    withX: (double) newX
    withY: (double) newY;

- (CoordinateDto *)getCoordinate:(NSDictionary *)coordinateDictionary;


