/*
 MenuDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header MenuDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the menu data in MensaMenuDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives menu id, dishes, offered on date and version to be initally set or a dictionary to browse the data itself. </li>
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

#import "MenuDto.h"
#import "DishDto.h"

@implementation MenuDto
@synthesize _dishes;
@synthesize _version;
@synthesize _offeredOn;
@synthesize _menuId;
@synthesize _dateFormatter;

/*!
 @function init
 Initializes MenuDto.
 @param newMenuId
 @param newDishes
 @param newOfferedOn
 @param newVersion
 */
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

/*!
 @function getMenuWeek
 Is called when a new MenuDto instance should be created based on the dictionary information.
 @param menuDictionary
 */
- (MenuDto *)getMenuWeek:(NSDictionary *)menuDictionary
{
    MenuDto         *_localMenu = [[MenuDto alloc]init:0 withDishes:nil withOfferedOn:nil withVersion:nil];
    int             _localMenuId;
    NSMutableArray  *_localDishes = [[NSMutableArray alloc] init];
    NSDate          *_localOfferedOn;
    NSString        *_localMenuVersion;
    DishDto *_localDish = [[DishDto alloc]init:0 withExternalPrice:0 withInternalPrice:0 withPriceForPartners:0 withLabel:nil withName:nil withVersion:nil withSideDishes:nil];
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
