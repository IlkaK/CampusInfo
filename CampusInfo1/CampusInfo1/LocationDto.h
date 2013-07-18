//
//  LocationDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 18.07.13.
//
//

#import <Foundation/Foundation.h>

@interface LocationDto : NSObject
{
    int               _locationId;
    NSString         *_name;
    NSString         *_version;
}

@property (nonatomic, assign) int               _locationId;
@property (nonatomic, retain) NSString          *_name;
@property (nonatomic, retain) NSString          *_version;

-(id)                   init: (int) newLocationId
                    withName: (NSString *)newName
                 withVersion: (NSString *)newVersion;

@end