//
//  MensaDetailViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 22.07.13.
//
//

#import "MensaDetailViewController.h"

#import "SideDishDto.h"
#import "DishDto.h"
#import "MenuPlanDto.h"
#import "CalendarWeekDto.h"
#import "MenuDto.h"

@implementation MensaDetailViewController

@synthesize _actualGastronomy;
@synthesize _moveBackButton;
@synthesize _dateLabel;
@synthesize _dayNavigationItem;
@synthesize _dateFormatter;
@synthesize _actualDate;
@synthesize _chooseDateVC;
@synthesize _detailTable;
@synthesize _detailTableCell;
@synthesize _gastronomyLabel;

@synthesize _asyncTimeTableRequest;
@synthesize _connectionTrials;
@synthesize _dataFromUrl;
@synthesize _errorMessage;
@synthesize _generalDictionary;

@synthesize _menuPlans;
@synthesize _actualMenu;

@synthesize _actualCalendarWeek;

@synthesize _leftSwipe;
@synthesize _rightSwipe;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dateFormatter  = [[DateFormation alloc] init];
    //_actualGastronomy = [[GastronomicFacilityDto alloc]init:nil withGastroId:nil withLocation:nil withName:nil withServiceTimePeriods:nil withType:nil withVersion:nil];
    [_moveBackButton useAlertStyle];
    

    //----- Navigation Bar ----
    // set current day
    [self setTitleToActualDate];
    
    // set day navigator
    UIImage *_leftButtonImage  = [UIImage imageNamed:@"arrowLeft_small.png"];
    UIImage *_rightButtonImage = [UIImage imageNamed:@"arrowRight_small.png"];
    
    UIBarButtonItem *_leftButton  = [[UIBarButtonItem alloc] initWithImage: _leftButtonImage
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(dayBefore:)];
    UIBarButtonItem *_rightButton = [[UIBarButtonItem alloc] initWithImage: _rightButtonImage
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(dayAfter:)];
    [_dayNavigationItem setLeftBarButtonItem :_leftButton animated :true];
    [_dayNavigationItem setRightBarButtonItem:_rightButton animated:true];
    
    _dateLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openChooseDateView)];
    [_dateLabel addGestureRecognizer:tapGesture];
    [self.view bringSubviewToFront:_dateLabel];
    
    
    // ------ CHOOSE DATE FREELY ----
    if (_chooseDateVC == nil)
    {
		_chooseDateVC = [[ChooseDateViewController alloc] init];
	}
    _chooseDateVC._chooseDateViewDelegate = self;
    _chooseDateVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    
    // set table controller
    if (_detailTable == nil) {
		_detailTable = [[UITableView alloc] init];
	}
    _detailTable.separatorColor = [UIColor lightGrayColor];
    _detailTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [_detailTable reloadData];
    
    _gastronomyLabel.text = _actualGastronomy._name;
    
    self._menuPlans     = [[NSMutableArray alloc] init];
    self._actualMenu    = [[MenuDto alloc] init:nil withDishes:nil withOfferedOn:nil withVersion:nil];
    self._actualCalendarWeek = 0;
    
    _rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dayBefore:)];
    [_rightSwipe setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:_rightSwipe];
    
    _leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dayAfter:)];
    [_leftSwipe setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:_leftSwipe];
    
}


- (void)setActualDate:(NSDate *)newDate
{
    self._actualDate      = newDate;
    [self setDateInNavigatorWithActualDate:_actualDate];
    
    NSCalendar *_calendar = [NSCalendar currentCalendar];
    int         _newWeekNumber = [[_calendar components: NSWeekOfYearCalendarUnit fromDate:newDate] weekOfYear];

    
    if (_newWeekNumber != _actualCalendarWeek || [_actualMenu._dishes lastObject] == nil)
    {
        //NSLog(@"setActualDate => _actualCalendarWeek: %i - newWeekNumber %i - count actual dishes: %i",_actualCalendarWeek, _newWeekNumber, [_actualMenu._dishes count]);
        
        [self getData];
    }
    [self setActualMenu];
    [_detailTable reloadData];
}


- (void) dayBefore:(id)sender
{
    int daysToAdd = -1;
    
    // set up date components
    NSDateComponents *_components = [[NSDateComponents alloc] init];
    [_components setDay:daysToAdd];
    
    NSCalendar *_gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate     *_newDate   = [_gregorian dateByAddingComponents:_components toDate:self._actualDate options:0];
    
    [self setActualDate:_newDate];
    //[self viewWillAppear:YES];
}

- (void) dayAfter:(id)sender
{
    NSDate *_newDate = [self._actualDate dateByAddingTimeInterval:(1*24*60*60)];
    [self setActualDate:_newDate];
    //[self viewWillAppear:YES];
}

- (void) setTitleToActualDate
{
    NSDateFormatter* df_local = [[NSDateFormatter alloc] init];
    [df_local setTimeZone:[NSTimeZone timeZoneWithName:@"CEST"]];
    [df_local setDateFormat:@"yyyy.MM.dd G 'at' HH:mm:ss zzz"];
        
    //----- Navigation Bar ----
    // set current day
    if (self._actualDate == nil)
    {
        self._actualDate = [NSDate date];
        //self._actualDate    = [[_dateFormatter _dayFormatter] dateFromString:@"17.12.2012"];
    }
    
    [self setDateInNavigatorWithActualDate:self._actualDate];
    
    //NSLog(@"set actual Date: %@", [[self dayFormatter] stringFromDate:self._actualDate]);
}


- (void) setDateInNavigatorWithActualDate:(NSDate *)showDate
{
    NSString *_dateString = [NSString stringWithFormat:@"%@, %@"
                             ,[[_dateFormatter _weekDayFormatter] stringFromDate:showDate]
                             ,[[_dateFormatter _dayFormatter]     stringFromDate:showDate]];
    
    [_dateLabel setTextColor:[UIColor whiteColor]];
    _dateLabel.text = _dateString;
    _dayNavigationItem.title = @"";
    
    self.navigationItem.titleView = _dateLabel;
    [self setActualMenu];
}

-(void) openChooseDateView
{
    _chooseDateVC._actualDate = self._actualDate;
    [self presentModalViewController:_chooseDateVC animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToMensaOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    _moveBackButton = nil;
    _dayNavigationItem = nil;
    _dateLabel = nil;
    _chooseDateVC = nil;
    _detailTable = nil;
    _detailTableCell = nil;
    _gastronomyLabel = nil;
    _rightSwipe = nil;
    _leftSwipe = nil;
    [super viewDidUnload];
}

-(void)setActualMenu
{
    int             _menuPlansI;
    MenuPlanDto     *_oneMenuPlan;
    MenuDto         *_oneMenu = [[MenuDto alloc]init:nil withDishes:nil withOfferedOn:nil withVersion:nil];
    int             _gastronomyFacilityIdsI;
    int             _localGastronomyFacilityId;
    int             _menuI;
    NSString        *_offeredOnString;
    NSString        *_actualDateString = [[_dateFormatter _dayFormatter] stringFromDate:_actualDate];
    
    _actualMenu = _oneMenu;
    
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
            
                    //NSLog(@"compare gastro ids %i - %i", _localGastronomyFacilityId, _actualGastronomy._gastroId);
            
                    if (_localGastronomyFacilityId == _actualGastronomy._gastroId)
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
    [_detailTable reloadData];
}


//-------------------------------
// asynchronous request
//-------------------------------

-(void) dataDownloadDidFinish:(NSData*) data
{
    
    self._dataFromUrl = data;
    
    // NSLog(@"dataDownloadDidFinish 1 %@",[NSThread callStackSymbols]);
    
    if (self._dataFromUrl != nil)
    {
        //NSString *_receivedString = [[NSString alloc] initWithData:self._dataFromUrl encoding:NSASCIIStringEncoding];
        //_receivedString = [_receivedString substringToIndex:2000];
        //NSLog(@"dataDownloadDidFinish for MensaViewController %@", _receivedString);
        
        NSError *_error;
        
        [_menuPlans removeAllObjects];
        _actualMenu =  [_actualMenu init:nil withDishes:nil withOfferedOn:nil withVersion:nil];
        
        _generalDictionary = [NSJSONSerialization
                              JSONObjectWithData:_dataFromUrl
                              options:kNilOptions
                              error:&_error];
        
        NSArray         *_menuPlanArray;
        int             _menuPlanArrayI;
        MenuPlanDto     *_localMenuPlan = [[MenuPlanDto alloc]init:nil withVersion:nil withCalendarWeek:nil withGastronomyFacilityIds:nil withMenus:nil];
        
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
                [self setActualMenu];
            }
        }

    }
}


-(void)threadDone:(NSNotification*)arg
{
    //NSLog(@"Thread exiting");
}


-(void) downloadData
{
    NSCalendar *_calendar = [NSCalendar currentCalendar];
    int         _newCalendarWeek = [[_calendar components: NSWeekOfYearCalendarUnit fromDate:_actualDate] weekOfYear];

    //NSLog(@"actual calendar week: %i - new calendar week %i",_actualCalendarWeek, _newCalendarWeek);

    if (_actualCalendarWeek == 0
    ||  _actualCalendarWeek != _newCalendarWeek)
    {
        _actualCalendarWeek = _newCalendarWeek;
    }
    
    NSDateComponents *components = [_calendar components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:_actualDate];
    NSInteger _year = [components year];
    
    NSString *_urlString = [NSString stringWithFormat:@"https://srv-lab-t-874.zhaw.ch//v1/catering/menuplans/years/%i/weeks/%i/",_year, _actualCalendarWeek];
    
    NSLog(@"urlString: %@", _urlString);
    
    NSURL *_url = [NSURL URLWithString:_urlString];
    [_asyncTimeTableRequest downloadData:_url];

}
    


- (NSDictionary *) getDictionaryFromUrl
{
    
    _asyncTimeTableRequest = [[TimeTableAsyncRequest alloc] init];
    _asyncTimeTableRequest._timeTableAsynchRequestDelegate = self;
    [self performSelectorInBackground:@selector(downloadData) withObject:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(threadDone:)
                                                 name:NSThreadWillExitNotification
                                               object:nil];
    
    NSError      *_error = nil;
    NSDictionary *_scheduleDictionary;
    
    if (_dataFromUrl == nil)
    {
        return nil;
    }
    else
    {
        //NSLog(@"getDictionaryFromUrl got some data putting it now into dictionary");
        _scheduleDictionary = [NSJSONSerialization
                               JSONObjectWithData:_dataFromUrl
                               options:kNilOptions
                               error:&_error];
        
    }
    return _scheduleDictionary;
}



-(void) getData
{
    //self._generalDictionary = nil;
    self._generalDictionary = [self getDictionaryFromUrl];
    
    if (self._generalDictionary == nil)
    {
        NSLog(@"MensaDetailViewController: no connection");
    }
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setActualDate:_actualDate];
    //if (_connectionTrials < 20)
    //{
        //NSLog(@"viewWillAppear try connecting");
     //   _connectionTrials++;
     //   [self getData];
    //}
    [_detailTable reloadData];
}
 






// table and table cell handling

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return 3;
    //NSLog(@"number of sections in table view: %i", [_actualMenu._dishes count]);
    if ([_actualMenu._dishes  lastObject] == nil)
    {
        return 1;
    }
    else
    {
        return [_actualMenu._dishes count];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 137;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if ([_actualMenu._dishes  lastObject] == nil)
    //{
        // VERY IMPORTANT, OTHERWISE, NO NEW DATA
       // [self viewWillAppear:YES];
    //}
    
    
    
    //NSLog(@"start cellForRowAtIndexPath");
    NSUInteger        _cellSelection = indexPath.section;
    static NSString *_cellIdentifier  = @"MensaDetailTableCell";
    UITableViewCell *_cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
        
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"MensaDetailTableCell" owner:self options:nil];
        _cell = _detailTableCell;
        self._detailTableCell = nil;
    }
    
    //NSLog(@"cellForRowAtIndexPath callStack %@",[NSThread callStackSymbols]);
    
    
    UILabel         *_labelTitle            = (UILabel *) [_cell viewWithTag:1];
    UILabel         *_labelMaincourse       = (UILabel *) [_cell viewWithTag:2];
    UILabel         *_labelSidedishes       = (UILabel *) [_cell viewWithTag:3];
    UILabel         *_labelPriceInternal    = (UILabel *) [_cell viewWithTag:4];
    UILabel         *_labelPricePartner     = (UILabel *) [_cell viewWithTag:5];
    UILabel         *_labelPriceExternal    = (UILabel *) [_cell viewWithTag:6];
    
    UILabel         *_labelWriteInternalPrice   = (UILabel *) [_cell viewWithTag:7];
    UILabel         *_labelWritePartnerPrice    = (UILabel *) [_cell viewWithTag:8];
    UILabel         *_labelWriteExternalPrice   = (UILabel *) [_cell viewWithTag:9];
    
    if ([_actualMenu._dishes  lastObject] == nil
    || [_actualMenu._dishes count] <= _cellSelection)
    {
        //NSLog(@"no dishes found with _cellSelection: %i", _cellSelection);

        if (_cellSelection > 0)
        {
            _labelTitle.text = @"";
        }
        else
        {
            _labelTitle.text            = @"keine Informationen über das Menü";
        }
        
        _labelMaincourse.text           = @"";
        _labelSidedishes.text           = @"";
        _labelPriceInternal.text        = @"";
        _labelPriceExternal.text        = @"";
        _labelPricePartner.text         = @"";
        _labelWriteInternalPrice.text   = @"";
        _labelWritePartnerPrice.text    = @"";
        _labelWriteExternalPrice.text   = @"";
    }
    else
    {
        
        SideDishDto     *_oneSideDish;
        int             sideDishI;
        NSString        *_sideDishString;
        DishDto         *_oneDish = [_actualMenu._dishes objectAtIndex:_cellSelection];
        
        _labelTitle.text = _oneDish._label;
        _labelMaincourse.text = _oneDish._name;
        
        //NSLog(@"show dishes: %i with _cellSelection: %i one dish name %@", [_actualMenu._dishes count], _cellSelection, _oneDish._name);
        
        if ([_oneDish._sideDishes lastObject] != nil)
        {
            for (sideDishI=0; sideDishI < [_oneDish._sideDishes count]; sideDishI++)
            {
                _oneSideDish = [_oneDish._sideDishes objectAtIndex:sideDishI];
                if (sideDishI == 0)
                {
                    _sideDishString = _oneSideDish._name;
                }
                else
                {
                    _sideDishString = [NSString stringWithFormat:@"%@, %@",_sideDishString, _oneSideDish._name];
                }
            }
        }
        _labelSidedishes.text       = _sideDishString;
        _labelPriceExternal.text    = [NSString stringWithFormat:@"%.2f CHF",_oneDish._externalPrice];
        _labelPriceInternal.text    = [NSString stringWithFormat:@"%.2f CHF",_oneDish._internalPrice];
        _labelPricePartner.text     = [NSString stringWithFormat:@"%.2f CHF",_oneDish._priceForPartners];
        _labelWriteInternalPrice.text = @"interner Preis";
        _labelWritePartnerPrice.text  = @"Partner";
        _labelWriteExternalPrice.text = @"externer Preis";

    }
    return _cell;
}


@end
