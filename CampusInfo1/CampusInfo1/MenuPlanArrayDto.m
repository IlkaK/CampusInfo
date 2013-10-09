/*
 MenuPlanArrayDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header MenuPlanArrayDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds menu plan array in MensaMenuDto model. </li>
 *      <li> Uses TimeTableAsyncRequestDelegate to connect to server and gain mensa menu data from there. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives calendar week and year to build the url which is send to the server. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> Using TimeTableAsyncRequestDelegate it gets the date from server request. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "MenuPlanArrayDto.h"
#import "MenuPlanDto.h"
#import "URLConstantStrings.h"

@implementation MenuPlanArrayDto
@synthesize _dateFormatter;
@synthesize _menuPlans;

@synthesize _errorMessage;
@synthesize _asyncTimeTableRequest;
@synthesize _connectionTrials;
@synthesize _dataFromUrl;
@synthesize _generalDictionary;

@synthesize _actualYear;
@synthesize _actualCalendarWeek;

/*!
 @function init
 Initializes MenuPlanArrayDto.
 @param newMenuPlans
 */
-(id) init:(NSMutableArray *) newMenuPlans
{
    self = [super init];
    if (self)
    {
        self._menuPlans = newMenuPlans;
    }
    _dateFormatter  = [[DateFormation alloc] init];
    self._actualCalendarWeek = 0;
    self._actualYear = 1970;
    return self;
}

//-------------------------------
// asynchronous request
//-------------------------------
/*!
 @function dataDownloadDidFinish
 Needed since TimeTableAsyncRequest is used.
 Function receives data, when download from server is finished.
 */
-(void) dataDownloadDidFinish:(NSData*) data
{
    
    self._dataFromUrl = data;
    
    // NSLog(@"dataDownloadDidFinish 1 %@",[NSThread callStackSymbols]);
    
    if (self._dataFromUrl != nil)
    {
        //NSString *_receivedString = [[NSString alloc] initWithData:self._dataFromUrl encoding:NSASCIIStringEncoding];
        //_receivedString = [_receivedString substringToIndex:50];
        //NSLog(@"dataDownloadDidFinish for MenuPlanArrayDto %@", _receivedString);
        
        NSError *_error;
        
        _menuPlans = [[NSMutableArray alloc] init];
        //[_menuPlans removeAllObjects];
        
        _generalDictionary = [NSJSONSerialization
                              JSONObjectWithData:_dataFromUrl
                              options:kNilOptions
                              error:&_error];
        
        NSArray         *_menuPlanArray;
        int             _menuPlanArrayI;
        MenuPlanDto     *_localMenuPlan = [[MenuPlanDto alloc]init:0 withVersion:nil withCalendarWeek:nil withGastronomyFacilityIds:nil withMenus:nil];
        
        for (id generalKey in _generalDictionary)
        {
            //NSLog(@"generalDictionary key: %@", generalKey);
            if ([generalKey isEqualToString:@"Message"])
            {
                NSString *_message = [_generalDictionary objectForKey:generalKey];
                //self._errorMessage = _message;
                NSLog(@"Message: %@",_message);
            }
            else
            {
                if ([generalKey isEqualToString:@"menuPlans"])
                {
                    _menuPlanArray = [_generalDictionary objectForKey:generalKey];
                    
                    if([_menuPlanArray lastObject] != nil)
                    {
                        
                        for (_menuPlanArrayI = 0; _menuPlanArrayI < [_menuPlanArray count]; _menuPlanArrayI++)
                        {
                            _localMenuPlan = [_localMenuPlan getMenuPlan:[_menuPlanArray objectAtIndex:_menuPlanArrayI]];
                            [_menuPlans addObject:_localMenuPlan];
                        }
                    }
                }
                //NSLog(@"menu plan array count: %i", [_menuPlans count]);
            }
        }
    }
}

/*!
 @function threadDone
 Needed since TimeTableAsyncRequest is used.
 If thread to download data is done, this function is called.
 */
-(void)threadDone:(NSNotification*)arg
{
    //NSLog(@"Thread exiting");
}

/*!
 @function downloadData
 Needed since TimeTableAsyncRequest is used.
 Function sends the request for data to server.
 */
-(void) downloadData
{
    NSString *_urlString = [NSString stringWithFormat:URLMenuPlanArray,_actualYear, _actualCalendarWeek];
    
    //NSLog(@"urlString: %@", _urlString);
    
    NSURL *_url = [NSURL URLWithString:_urlString];
    [_asyncTimeTableRequest downloadData:_url];
}

/*!
 @function getDictionaryFromUrl
 Needed since TimeTableAsyncRequest is used.
 TimeTableAsyncRequest is initialized and data download is triggered here.
 If data is downloaded from server it is processed as well.
 */
- (NSDictionary *) getDictionaryFromUrl
{
    _asyncTimeTableRequest = [[TimeTableAsyncRequest alloc] init];
    _asyncTimeTableRequest._timeTableAsynchRequestDelegate = self;
    //[self performSelectorInBackground:@selector(downloadData) withObject:nil];
    [self performSelectorOnMainThread:@selector(downloadData) withObject:nil waitUntilDone:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(threadDone:)
                                                 name:NSThreadWillExitNotification
                                               object:nil];
    if (_dataFromUrl == nil)
    {
        return nil;
    }
    else
    {       
        NSError      *_error = nil;
        NSDictionary *_scheduleDictionary = [NSJSONSerialization
                                             JSONObjectWithData:_dataFromUrl
                                             options:kNilOptions
                                             error:&_error];
        return _scheduleDictionary;
    }
}

/*!
 @function getData
 Gets mensa menu plan array for given year, calendar week, actual date and gastro id.
 @param calendarWeek
 @param year
 @param actualDate
 @param gastroId
 */
-(void) getData:(int)calendarWeek
       withYear:(int)year
 withActualDate:(NSDate *)actualDate
   withGastroId:(int)gastroId
{
    _actualCalendarWeek = calendarWeek;
    _actualYear = year;
    
    MenuDto *_thisMenu = [[MenuDto alloc]init:0 withDishes:nil withOfferedOn:nil withVersion:nil];
    
    if (_menuPlans != nil)
    {
        _thisMenu = [self getActualMenu:actualDate withGastroId:gastroId];
    }
    
    if (_thisMenu == nil || [_thisMenu._dishes count] == 0)
    {
        self._generalDictionary = [self getDictionaryFromUrl];
    
        //if (self._generalDictionary == nil)
        //{
        //    NSLog(@"MenuPlanArrayDto: no connection");
        //}
    }
}

/*!
 @function getActualMenu
 Gets the mensa menu plan for given date and gastro id.
 @param actualDate
 @param gastroId
 */
-(MenuDto *)getActualMenu:(NSDate *)actualDate
                 withGastroId:(int)gastroId
{
    int             _menuPlansI;
    MenuPlanDto     *_oneMenuPlan;
    MenuDto         *_oneMenu    = [[MenuDto alloc]init:0 withDishes:nil withOfferedOn:nil withVersion:nil];
    MenuDto         *_actualMenu = [[MenuDto alloc]init:0 withDishes:nil withOfferedOn:nil withVersion:nil];
    int             _gastronomyFacilityIdsI;
    int             _localGastronomyFacilityId;
    int             _menuI;
    NSString        *_offeredOnString;
    NSString        *_actualDateString = [[_dateFormatter _dayFormatter] stringFromDate:actualDate];
    
    if (_menuPlans != nil && [_menuPlans lastObject] != nil)
    {
        for (_menuPlansI = 0; _menuPlansI < [_menuPlans count]; _menuPlansI++)
        {
            _oneMenuPlan = [_menuPlans objectAtIndex:_menuPlansI];
            
            if ([_oneMenuPlan._gastronomyFacilityIds lastObject] != nil)
            {
                for (_gastronomyFacilityIdsI = 0; _gastronomyFacilityIdsI < [_oneMenuPlan._gastronomyFacilityIds count]; _gastronomyFacilityIdsI++)
                {
                    //NSLog(@"gastronomy facility id: %@", [_oneMenuPlan._gastronomyFacilityIds objectAtIndex:_gastronomyFacilityIdsI]);
                    
                    _localGastronomyFacilityId = [[_oneMenuPlan._gastronomyFacilityIds objectAtIndex:_gastronomyFacilityIdsI] intValue];
                    
                    //NSLog(@"compare gastro ids %i - %i", _localGastronomyFacilityId, gastroId);
                    
                    if (_localGastronomyFacilityId == gastroId)
                    {
                        if([_oneMenuPlan._menus lastObject] != nil)
                        {
                            
                            for (_menuI = 0; _menuI < [_oneMenuPlan._menus count]; _menuI++)
                            {
                                _oneMenu         = [_oneMenuPlan._menus objectAtIndex:_menuI];
                                _offeredOnString = [[_dateFormatter _dayFormatter] stringFromDate:_oneMenu._offeredOn];
                                
                                //NSLog(@"compare dates %@ = %@?", _offeredOnString, _actualDateString);
                                if ([_offeredOnString isEqualToString: _actualDateString])
                                {
                                    _actualMenu = _oneMenu;
                                    //NSLog(@"getActualMenu dishes count: %i", [_actualMenu._dishes count]);
                                    
                                    //int dishI;
                                    //for (dishI = 0; dishI < [_actualMenu._dishes count]; dishI++)
                                    //{
                                    //DishDto *_oneDish = [_actualMenu._dishes objectAtIndex:dishI];
                                    //NSLog(@"On %@ dishes %@", _offeredOnString, _oneDish._label);
                                    //}
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return _actualMenu;
}



@end
