/*
 MenuPlanDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header MenuPlanDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the calendar menu plan data in MensaMenuDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives menu plan id, version, calendar week, gastronomy facility id and an array of menus to be initally set or a dictionary to browse the data itself. </li>
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

#import "MenuPlanDto.h"
#import "CalendarWeekDto.h"
#import "MenuDto.h"

@implementation MenuPlanDto
@synthesize _version;
@synthesize _calendarWeek;
@synthesize _gastronomyFacilityIds;
@synthesize _menuPlanId;
@synthesize _menus;

/*!
 @function init
 Initializes MenuPlanDto.
 @param newMenuPlanId
 @param newVersion
 @param newCalendarWeek
 @param newGastronomyFacilityIds
 @param newMenus
 */
-(id)   init               : (int) newMenuPlanId
                withVersion: (NSString *) newVersion
           withCalendarWeek: (CalendarWeekDto *) newCalendarWeek
  withGastronomyFacilityIds: (NSMutableArray *)newGastronomyFacilityIds
                  withMenus: (NSMutableArray *)newMenus
{
    self = [super init];
    if (self)
    {
        self._menuPlanId            = newMenuPlanId;
        self._version               = newVersion;
        self._calendarWeek          = newCalendarWeek;
        self._gastronomyFacilityIds = newGastronomyFacilityIds;
        self._menus                 = newMenus;
    }
    return self;
}

/*!
 @function getMenuPlan
 Is called when a new MenuPlanDto instance should be created based on the dictionary information.
 @param menuPlanDictionary
 */
- (MenuPlanDto *)getMenuPlan:(NSDictionary *)menuPlanDictionary
{
    MenuPlanDto *_localMenuPlan = [[MenuPlanDto alloc]init:0 withVersion:nil withCalendarWeek:nil withGastronomyFacilityIds:nil withMenus:nil];
    
    int             _localMenuPlanId;
    NSString        *_localMenuPlanVersion;
    NSMutableArray *_localGastronomyFacilities;
    //int _gastronomyFacilityIdI;
    
    CalendarWeekDto *_localCalendarWeek = [[CalendarWeekDto alloc]init:0 withYear:0];
    
    NSMutableArray *_localMenus = [[NSMutableArray alloc] init];
    NSMutableArray *_menuArray;
    int             _menuArrayI;
    
    MenuDto *_localMenu = [[MenuDto alloc]init:0 withDishes:0 withOfferedOn:nil withVersion:nil];

    for (id menuPlanKey in menuPlanDictionary)
    {
        //NSLog(@"menuPlanKey key: %@", menuPlanKey);
        if ([menuPlanKey isEqualToString:@"id"])
        {
            _localMenuPlanId = [[menuPlanDictionary objectForKey:menuPlanKey] intValue];
            //NSLog(@"_localMenuPlanId: %i", _localMenuPlanId);
        }
        if ([menuPlanKey isEqualToString:@"version"])
        {
            _localMenuPlanVersion = [menuPlanDictionary objectForKey:menuPlanKey];
            //NSLog(@"_localMenuPlanVersion: %@", _localMenuPlanVersion);
        }
    
        if ([menuPlanKey isEqualToString:@"gastronomicFacilityIds"])
        {
            _localGastronomyFacilities = [menuPlanDictionary objectForKey:menuPlanKey];
            //NSLog(@"count of _gastronomyFacilityIdArray: %i", [_gastronomyFacilityIdArray count]);
            //for (_gastronomyFacilityIdI = 0; _gastronomyFacilityIdI < [_gastronomyFacilityIdArray count]; _gastronomyFacilityIdI++)
            //{
            //    NSLog(@"whats there: %@",[_gastronomyFacilityIdArray objectAtIndex:_gastronomyFacilityIdI]);
            //}
        }
        if ([menuPlanKey isEqualToString:@"calendarWeek"])
        {
            _localCalendarWeek = [_localCalendarWeek getCalendarWeek:[menuPlanDictionary objectForKey:menuPlanKey]];
        }
        if ([menuPlanKey isEqualToString:@"menus"])
        {
            _menuArray = [menuPlanDictionary objectForKey:menuPlanKey];
            //NSLog(@"count of _menuArray: %i", [_menuArray count]);
        
            if([_menuArray lastObject] != nil)
            {
                for (_menuArrayI = 0; _menuArrayI < [_menuArray count]; _menuArrayI++)
                {
                    _localMenu = [_localMenu getMenuWeek:[_menuArray objectAtIndex:_menuArrayI]];
                    [_localMenus addObject:_localMenu];
                }
            }
        }
    }
    _localMenuPlan = [_localMenuPlan init:_localMenuPlanId
                              withVersion:_localMenuPlanVersion
                         withCalendarWeek:_localCalendarWeek
                withGastronomyFacilityIds:_localGastronomyFacilities
                                withMenus:_localMenus
                      ];

    return _localMenuPlan;
}



@end
