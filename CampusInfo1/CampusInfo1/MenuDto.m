//
//  MenuDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 23.07.13.
//
//

#import "MenuDto.h"
#import "DishDto.h"

@implementation MenuDto
@synthesize _dishes;
@synthesize _version;
@synthesize _offeredOn;
@synthesize _menuId;
@synthesize _dateFormatter;

-(id)         init:(int) newMenuId
        withDishes:(NSMutableArray *) newDishes
     withOfferedOn:(NSDate *)newOfferedOn
       withVersion:(NSString *)newVersion
{
    self = [super init];
    if (self)
    {
        self._menuId    = newMenuId;
        self._dishes    = newDishes;
        self._offeredOn = newOfferedOn;
        self._version   = newVersion;
    }
    _dateFormatter  = [[DateFormation alloc] init];
    return self;
}


- (MenuDto *)getMenuWeek:(NSDictionary *)menuDictionary
{
    MenuDto         *_localMenu = [[MenuDto alloc]init:nil withDishes:nil withOfferedOn:nil withVersion:nil];
    int             _localMenuId;
    NSMutableArray  *_localDishes = [[NSMutableArray alloc] init];
    NSDate          *_localOfferedOn;
    NSString        *_localMenuVersion;
    DishDto *_localDish = [[DishDto alloc]init:nil withExternalPrice:0 withInternalPrice:0 withPriceForPartners:0 withLabel:nil withName:nil withVersion:nil withSideDishes:nil];
    NSMutableArray  *_dishesArray;
    int             _dishesArrayI;
    
    for (id menuKey in menuDictionary)
    {
        //NSLog(@"menuKey key: %@", menuKey);
        if ([menuKey isEqualToString:@"id"])
        {
            _localMenuId = [[menuDictionary objectForKey:menuKey] intValue];
            //NSLog(@"_localMenuId: %i", _localMenuId);
        }
        if ([menuKey isEqualToString:@"version"])
        {
            _localMenuVersion = [menuDictionary objectForKey:menuKey];
            //NSLog(@"_localMenuVersion: %@", _localMenuVersion);
        }
        if ([menuKey isEqualToString:@"offeredOn"])
        {
            _localOfferedOn = [_dateFormatter parseDate:[menuDictionary objectForKey:menuKey]];
            //NSLog(@"_localOfferedOn: %@", [[_dateFormatter _englishDayFormatter] stringFromDate:_localOfferedOn]);
        }
        if ([menuKey isEqualToString:@"dishes"])
        {
        
            _dishesArray = [menuDictionary objectForKey:menuKey];
            //NSLog(@"count of _dishesArray: %i", [_dishesArray count]);
        
            if([_dishesArray lastObject] != nil)
            {
                for (_dishesArrayI = 0; _dishesArrayI < [_dishesArray count]; _dishesArrayI++)
                {
                    _localDish = [_localDish getDish:[_dishesArray objectAtIndex:_dishesArrayI]];
                    [_localDishes addObject:_localDish];
                }
            }
        }
    }   
    _localMenu = [_localMenu init:_localMenuId
                       withDishes:_localDishes
                    withOfferedOn:_localOfferedOn
                      withVersion:_localMenuVersion
                  ];
    return _localMenu;
}


@end
