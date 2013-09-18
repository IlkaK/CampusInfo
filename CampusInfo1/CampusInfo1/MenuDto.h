//
//  MenuDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 23.07.13.
//
//

#import <Foundation/Foundation.h>
#import "DateFormation.h"

@interface MenuDto : NSObject
{
    int             _menuId;
    NSMutableArray  *_dishes;
    NSDate          *_offeredOn;
    NSString        *_version;
    DateFormation   *_dateFormatter;
}

@property (nonatomic, assign) int               _menuId;
@property (nonatomic, retain) NSMutableArray    *_dishes;
@property (nonatomic, retain) NSDate            *_offeredOn;
@property (nonatomic, retain) NSString          *_version;
@property (nonatomic, retain) DateFormation     *_dateFormatter;


-(id)         init:(int) newMenuId
        withDishes:(NSMutableArray *) newDishes
     withOfferedOn:(NSDate *)newOfferedOn
       withVersion:(NSString *)newVersion;

- (MenuDto *)getMenuWeek:(NSDictionary *)menuDictionary;

@end