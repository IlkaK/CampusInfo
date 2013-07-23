//
//  MenuPlanDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 23.07.13.
//
//

#import "MenuPlanDto.h"
#import "CalendarWeekDto.h"
#import "MenuDto.h"

@implementation MenuPlanDto
@synthesize _version;
@synthesize _calendarWeek;
@synthesize _gastronomyFacilityIds;
@synthesize _menuPlanId;
@synthesize _menus;

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


- (MenuPlanDto *)getMenuPlan:(NSDictionary *)menuPlanDictionary
{
    MenuPlanDto *_localMenuPlan = [[MenuPlanDto alloc]init:nil withVersion:nil withCalendarWeek:nil withGastronomyFacilityIds:nil withMenus:nil];
    
    int             _localMenuPlanId;
    NSString        *_localMenuPlanVersion;
    NSMutableArray *_localGastronomyFacilities;
    //int _gastronomyFacilityIdI;
    
    CalendarWeekDto *_localCalendarWeek = [[CalendarWeekDto alloc]init:nil withYear:nil];
    
    NSMutableArray *_localMenus = [[NSMutableArray alloc] init];
    NSMutableArray *_menuArray;
    int             _menuArrayI;
    
    MenuDto *_localMenu = [[MenuDto alloc]init:nil withDishes:nil withOfferedOn:nil withVersion:nil];

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
        
            for (_menuArrayI = 0; _menuArrayI < [_menuArray count]; _menuArrayI++)
            {
                _localMenu = [_localMenu getMenuWeek:[_menuArray objectAtIndex:_menuArrayI]];
                [_localMenus addObject:_localMenu];
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
