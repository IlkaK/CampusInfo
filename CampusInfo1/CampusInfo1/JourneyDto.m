/*
 JourneyDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header JourneyDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds journey data for PublicTransportConnectionDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives name, category, category code, journey number, operator, to, pass list, first and second capacity to be initally set or a dictionary to browse the data itself. </li>
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

#import "JourneyDto.h"
#import "FromOrToDto.h"

@implementation JourneyDto
@synthesize _capacity1st;
@synthesize _capacity2nd;
@synthesize _category;
@synthesize _categoryCode;
@synthesize _journeyNumber;
@synthesize _name;
@synthesize _operator;
@synthesize _passList;
@synthesize _to;

/*!
 @function init
 Needs to be called initally, when instance of JourneyDto is created.
 @param newName
 @param newCategory
 @param newCategoryCode
 @param newJourneyNumber
 @param newOperator
 @param newTo
 @param newPassList
 @param newCapacity1st
 @param newCapacity2nd
 */
-(id)                   init: (NSString *)newName
                withCategory: (NSString *)newCategory
            withCategoryCode: (int)newCategoryCode
           withJourneyNumber: (NSString *)newJourneyNumber
                withOperator: (NSString *)newOperator
                      withTo: (NSString *)newTo
                withPassList: (NSMutableArray *)newPassList
             withCapacity1st: (int) newCapacity1st
             withCapacity2nd: (int) newCapacity2nd
{

    self = [super init];
    if (self)
    {
        self._name              = newName;
        self._category          = newCategory;
        self._categoryCode      = newCategoryCode;
        self._journeyNumber     = newJourneyNumber;
        self._operator          = newOperator;
        self._to                = newTo;
        self._passList          = newPassList;
        self._capacity1st       = newCapacity1st;
        self._capacity2nd       = newCapacity2nd;
    }
    return self;

}

/*!
 @function getJourney
 Is called when a new JourneyDto instance should be created based on the dictionary information.
 @param journeyDictionary
 */
- (JourneyDto *)getJourney:(NSDictionary *)journeyDictionary
{
    JourneyDto *_localJourney = [[JourneyDto alloc]init:nil
                                           withCategory:nil
                                       withCategoryCode:0
                                      withJourneyNumber:nil
                                           withOperator:nil
                                                 withTo:nil
                                           withPassList:nil
                                        withCapacity1st:0
                                        withCapacity2nd:0];
    NSString        *_localName;
    NSString        *_localCategory;
    int             _localCategoryCode;
    NSString        *_localJourneyNumber;
    NSString        *_localOperator;
    NSString        *_localTo;
    NSMutableArray  *_localPassList = [[NSMutableArray alloc] init];
    NSArray         *_passListArray;
    int             _localCapacity1st;
    int             _localCapacity2nd;
    
    for (id journeyKey in journeyDictionary)
    {
        if ([journeyDictionary objectForKey:journeyKey] != [NSNull null])
        {
            if ([journeyKey isEqualToString:@"name"])
            {
                _localName = [journeyDictionary objectForKey:journeyKey];
                //NSLog(@"JourneyDto _localName: %@", _localName);
            }
            
            if ([journeyKey isEqualToString:@"category"])
            {
                _localCategory = [journeyDictionary objectForKey:journeyKey];
                //NSLog(@"JourneyDto _localCategory: %@", _localCategory);
            }
            
            if ([journeyKey isEqualToString:@"categoryCode"])
            {
                _localCategoryCode = [[journeyDictionary objectForKey:journeyKey] intValue];
                //NSLog(@"JourneyDto _localCategoryCode: %i", _localCategoryCode);
            }
            
            if ([journeyKey isEqualToString:@"number"])
            {
                _localJourneyNumber = [journeyDictionary objectForKey:journeyKey];
                //NSLog(@"JourneyDto _localJourneyNumber: %@", _localJourneyNumber);
            }
            
            if ([journeyKey isEqualToString:@"operator"])
            {
                _localOperator = [journeyDictionary objectForKey:journeyKey];
                //NSLog(@"JourneyDto _localOperator: %@", _localOperator);
            }
            
            if ([journeyKey isEqualToString:@"to"])
            {
                _localTo = [journeyDictionary objectForKey:journeyKey];
                //NSLog(@"JourneyDto _localTo: %@", _localTo);
            }
            
            if ([journeyKey isEqualToString:@"passList"])
            {
                _passListArray = [journeyDictionary objectForKey:journeyKey];
                int _passListArrayI;
                
                //NSLog(@"count of _stationArray: %i", [_stationArray count]);
            
                FromOrToDto *_localFromOrTo = [[FromOrToDto alloc]init:nil
                                                          withLocation:nil
                                                         withPrognosis:nil
                                                             withDelay:nil
                                                       withArrivalDate:nil
                                                       withArrivalTime:nil
                                                     withDepartureDate:nil
                                                     withDepartureTime:nil
                                                          withPlatform:nil];
            
                for (_passListArrayI = 0; _passListArrayI < [_passListArray count]; _passListArrayI++)
                {
                    _localFromOrTo = [_localFromOrTo getFromOrTo:[_passListArray objectAtIndex:_passListArrayI]];
                    [_passList addObject:_localFromOrTo];
                }
            }
            
            if ([journeyKey isEqualToString:@"capacity1st"])
            {
                _localCapacity1st = [[journeyDictionary objectForKey:journeyKey] intValue];
                //NSLog(@"StationDto _localStationId: %i", _localStationId);
            }
            
            if ([journeyKey isEqualToString:@"capacity2nd"])
            {
                
                _localCapacity2nd = [[journeyDictionary objectForKey:journeyKey] intValue];
                //NSLog(@"StationDto _localScore: %i", _localScore);
            }
        }
    }
    _localJourney =  [_localJourney    init:_localName
                               withCategory:_localCategory
                           withCategoryCode:_localCategoryCode
                          withJourneyNumber:_localJourneyNumber
                               withOperator:_localOperator
                                     withTo:_localTo
                               withPassList:_localPassList
                            withCapacity1st:_localCapacity1st
                            withCapacity2nd:_localCapacity2nd];
    return _localJourney;
}




@end
