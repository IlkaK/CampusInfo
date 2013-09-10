//
//  TimeTableOverviewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TimeTableOverviewController.h"
#import "ChooseDateViewController.h"
#import "ScheduleDto.h"
#import "TimeTableDetailController.h"
#import "ScheduleEventDto.h"
#import "SlotDto.h"
#import "DayDto.h"
#import "SchoolClassDto.h"
#import "RoomDto.h"
#import "PersonDto.h"
#import "ScheduleEventRealizationDto.h"
#import "UIConstantStrings.h"


@implementation TimeTableOverviewController

@synthesize _timeTable;
@synthesize _actualDate;
@synthesize _schedule;
@synthesize _actualDayDto;

@synthesize _dayNavigationBar;
@synthesize _dayNavigator;
@synthesize _dateButton;

@synthesize _detailsVC;
@synthesize _chooseDateVC;
@synthesize _searchVC;
@synthesize _settingsVC;

@synthesize _timeTableSegmentedControl;
@synthesize _segmentedControlNavigationBar;

@synthesize _ownStoredAcronymString;
@synthesize _ownStoredAcronymType;
@synthesize _ownStoredAcronymTrials;
@synthesize _actualShownAcronymString;
@synthesize _actualShownAcronymType;
@synthesize _actualShownAcronymTrials;

@synthesize _oneSlotOneRoomTableCell;
@synthesize _oneSlotTwoRoomsTableCell;
@synthesize _oneSlotThreeRoomsTableCell;
@synthesize _oneSlotFourRoomsTableCell;
@synthesize _oneSlotFiveRoomsTableCell;
@synthesize _oneSlotSixRoomsTableCell;
@synthesize _oneSlotSevenRoomsTableCell;
@synthesize _oneSlotEightRoomsTableCell;

@synthesize _twoSlotsOneRoomTableCell;
@synthesize _twoSlotsTwoRoomsTableCell;
@synthesize _twoSlotsThreeRoomsTableCell;
@synthesize _twoSlotsFourRoomsTableCell;
@synthesize _twoSlotsSixRoomsTableCell;

@synthesize _threeSlotsOneRoomTableCell;
@synthesize _threeSlotsTwoRoomsTableCell;
@synthesize _threeSlotsThreeRoomsTableCell;

@synthesize _fourSlotsOneRoomTableCell;
@synthesize _fourSlotsTwoRoomsTableCell;
@synthesize _fourSlotsThreeRoomsTableCell;
@synthesize _fourSlotsFourRoomsTableCell;
@synthesize _fourSlotsFiveRoomsTableCell;

@synthesize _fiveSlotsOneRoomTableCell;

@synthesize _sixSlotsOneRoomTableCell;
@synthesize _sixSlotsTwoRoomsTableCell;

@synthesize _sevenSlotsOneRoomTableCell;
@synthesize _sevenSlotsEightRoomsTableCell;

@synthesize _eightSlotsOneRoomTableCell;

@synthesize _nineSlotsThreeRoomsTableCell;

@synthesize _emptyTableCell;
@synthesize _errorMessageCell;

@synthesize _noConnectionButton;
@synthesize _noConnectionLabel;

@synthesize _searchText;
@synthesize _searchType;

@synthesize _leftSwipe;
@synthesize _rightSwipe;

@synthesize _translator;
@synthesize _dateFormatter;

@synthesize _waitForLoadingActivityIndicator;

@synthesize _acronymLabel;
@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;
@synthesize _titleNavigationLabel;

@synthesize _zhawColor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{   
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}



-(void) setNewScheduleWithAcronym:(NSString *)newAcronym
                withAcronymType  :(NSString *)newAcronymType
                withAcronymText  :(NSString *)newAcronymText
{
    //NSLog(@"newAcronymText: %@", newAcronymText);
    if (newAcronymText != nil)
    {
        self._acronymLabel.text        = [NSString stringWithFormat:@"   %@",newAcronymText];
    }
    else
    {
        self._acronymLabel.text        = [NSString stringWithFormat:@""];
    }
    
    if (_ownStoredAcronymString != nil)
    {
        [self._timeTableSegmentedControl setTitle:_ownStoredAcronymString forSegmentAtIndex:0];
    }
    else
    {
        [self._timeTableSegmentedControl setTitle:@"Kürzel" forSegmentAtIndex:0];
    }
    
    self._actualShownAcronymTrials = 1;
    self._actualShownAcronymString = newAcronym;
    self._actualShownAcronymType   = newAcronymType;
    self._schedule                 = nil;
    self._schedule                 = [[ScheduleDto alloc] initWithAcronym:newAcronym:newAcronymType:_actualDate];
    self._actualDayDto             = [self getDayDto];

    
    //NSLog(@"2 showScheduleDetails acronym: %@", self._actualShownAcronymString);
    _detailsVC._dayAndAcronymString = [NSString stringWithFormat:@"von %@ (%@)"
                                       ,newAcronym //self._actualShownAcronymString
                                       ,[_translator getGermanTypeTranslation:newAcronymType] //self._actualShownAcronymType]
                                       ];
    
    [_timeTable reloadData];
}



-(void) setNewScheduleWithDate:(NSDate *)newDate
{
    _actualShownAcronymTrials   = 1;
    DayDto   *_localDay;
    NSString *_localDateString;
    NSString *_newDateString    = [[_dateFormatter _dayFormatter] stringFromDate:newDate];
    int       _compareDate      = 0;
        
    if (self._schedule == nil) 
    {
		self._schedule = [[ScheduleDto alloc] initWithAcronym:_actualShownAcronymString:_actualShownAcronymType:newDate];
	}
    else 
    {
        //NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        
        // 1 => new date is smaller than all dates => load new days for new date -7
        // 2 => new date is within date range      => no new load needed
        // 3 => new date is bigger than all dates  => load new days for new date
        
        int scheduleI;
        for (scheduleI = 0; scheduleI < [self._schedule._days count]; scheduleI ++)
        {   
            _localDay        = [_schedule._days objectAtIndex:scheduleI];     
            _localDateString = [[_dateFormatter _dayFormatter] stringFromDate:_localDay._date];
            
            //NSLog(@" %@ compare with %@",_newDateString, _localDateString);
            
            if ([_newDateString compare: _localDateString] == NSOrderedSame)
            {
                //NSLog(@"they are the same");
                _compareDate = 2;
            }
            if (  [_newDateString compare: _localDateString] == NSOrderedAscending
                && _compareDate != 2)
            {
                //NSLog(@"NSOrderedAscending");
                _compareDate = 1;
            }
            if (  [_newDateString compare: _localDateString] == NSOrderedDescending
                && _compareDate != 2)
            {
                //NSLog(@"NSOrderedDescending");
                _compareDate = 3;
            }
        }
        //NSLog(@"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");

        if (_compareDate == 1)
        {
            //NSLog(@"load schedule for %@ -7",_newDateString);
            NSDateComponents *_components         = [[NSDateComponents alloc] init];
            [_components setDay:-7];
            NSCalendar       *_gregorian          = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDate           *_newDateForSchedule = [_gregorian dateByAddingComponents:_components toDate:newDate options:0];
            self._schedule = [[ScheduleDto alloc] initWithAcronym:_actualShownAcronymString:_actualShownAcronymType:_newDateForSchedule];
            _actualDayDto  = [self getDayDto];
            [_timeTable reloadData];
        }
        
        if (_compareDate == 3)
        {
            //NSLog(@"load schedule for %@",_newDateString);
            self._schedule = [[ScheduleDto alloc] initWithAcronym:_actualShownAcronymString:_actualShownAcronymType:newDate];
            _actualDayDto  = [self getDayDto];
            [_timeTable reloadData];
            //NSLog(@"done loading schedule!");
        }
        
        // no connection at all
        if (_compareDate == 0)
        {
            //NSLog(@"no connection so far for %@",_newDateString);
            self._schedule = [[ScheduleDto alloc] initWithAcronym:_actualShownAcronymString:_actualShownAcronymType:newDate];
            _actualDayDto  = [self getDayDto];
            [_timeTable reloadData];
        }
        
        if ([self._schedule._days count] > 0)
        {
            _noConnectionButton.hidden = YES;
            _noConnectionLabel.hidden = YES;
        }
    }
}


- (IBAction)tryConnectionAgain:(id)sender
{
    [self setNewScheduleWithDate:_actualDate];
}

- (void)moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    self.tabBarController.selectedIndex = 0;
}

- (IBAction)moveToTimeTableSegmentedControlFeature:(id)sender
{
    // acronym
    if(_timeTableSegmentedControl.selectedSegmentIndex == 0)
    {
		if (self._ownStoredAcronymString == nil)
        {
            [self presentModalViewController:_settingsVC animated:YES];
        }
        else
        {
            [self setNewScheduleWithAcronym:self._ownStoredAcronymString
                            withAcronymType:self._ownStoredAcronymType
                            withAcronymText:[NSString stringWithFormat:@"von %@ (%@)"
                                             ,_ownStoredAcronymString
                                             ,[_translator getGermanTypeTranslation:_ownStoredAcronymType]
                                             ]
             ];
        }
	}
    
    // today
	if(_timeTableSegmentedControl.selectedSegmentIndex == 1)
    {
        NSDate *_today = [NSDate date];
        [self setActualDate:_today];
	}

    // search
    if(_timeTableSegmentedControl.selectedSegmentIndex == 2)
    {
        [self presentModalViewController:_searchVC animated:YES];
	}
    
}

- (IBAction)moveToChooseDateView:(id)sender
{
    _chooseDateVC._actualDate = self._actualDate;
    [self presentModalViewController:_chooseDateVC animated:YES];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void) setDateInNavigatorWithActualDate:(NSDate *)showDate
{
    NSString *_dateString = [NSString stringWithFormat:@"%@, %@"
                                                        ,[[_dateFormatter _weekDayFormatter] stringFromDate:showDate]
                                                        ,[[_dateFormatter _dayFormatter]     stringFromDate:showDate]];
    [_dateButton setTitle:_dateString forState:UIControlStateNormal];
    _dayNavigator.title = @"";
}



- (void)setActualDate:(NSDate *)newDate
{
    NSString *_actualDayString    = [[_dateFormatter _dayFormatter] stringFromDate:_actualDate];
    NSString *_todayString        = [[_dateFormatter _dayFormatter] stringFromDate:newDate];
    
    // compare dates
    if (![_actualDayString isEqualToString: _todayString])
    {
    
        self._actualDate      = newDate;
        [self setNewScheduleWithDate:newDate];
        [self setDateInNavigatorWithActualDate:_actualDate];
        _actualDayDto        = [self getDayDto];
        [_timeTable reloadData];
        [_timeTableSegmentedControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
    }
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
}


- (void) dayAfter:(id)sender
{
    NSDate *_newDate = [self._actualDate dateByAddingTimeInterval:(1*24*60*60)];
    [self setActualDate:_newDate];
}


- (NSString *)getAcronymType:(NSString *)_newAcronym
{
    // student : 8 digits, only letters and numbers
    // lecturer: 3-5 digits, only letters
    
    NSString       *_localType = @"empty";
    NSCharacterSet * alphabecticalSet          = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ"] invertedSet];
    NSCharacterSet * alphabecticalAndNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890"] invertedSet];

    if ([_newAcronym length] == 8)
    {
        if ([[_newAcronym stringByTrimmingCharactersInSet:alphabecticalAndNumberSet] isEqualToString: _newAcronym])
        {
            _localType = @"students";
        }      
    }    
    else 
    {
      if ([_newAcronym length] >= 3 && [_newAcronym length] <= 5)
      {
          if ([[_newAcronym stringByTrimmingCharactersInSet:alphabecticalSet] isEqualToString: _newAcronym])
          {
             _localType = @"lecturers";
          }      
      }
    }
    if ([_localType  compare: @"empty" ] == NSOrderedSame)
    {
      NSLog(@"Nur Kürzel von Studenten und Dozenten sind möglich. %@ kann nicht identifiziert werden.", _newAcronym);
      //[self popUpAcronymView:@"Nur Kürzel von Studenten und Dozenten sind möglich."];
    }
    return _localType;
}


- (void)setAcronymLabel:(NSString *)newAcronym
{
    if (_ownStoredAcronymString == nil || [_ownStoredAcronymString  compare: newAcronym ] != NSOrderedSame)
    {
        self._ownStoredAcronymString         = newAcronym;
        self._ownStoredAcronymType           = [self getAcronymType:_ownStoredAcronymString];
        
        NSUserDefaults *_acronymUserDefaults = [NSUserDefaults standardUserDefaults];
        [_acronymUserDefaults setObject:_ownStoredAcronymString forKey:TimeTableAcronym];
        [_acronymUserDefaults synchronize];
       

        if (_ownStoredAcronymString != nil)
        {
            _acronymLabel.text          = [NSString stringWithFormat:@"von %@ (%@)"
                                           ,_ownStoredAcronymString
                                           ,[_translator getGermanTypeTranslation:_ownStoredAcronymType]
                                           ];
            [self._timeTableSegmentedControl setTitle:_ownStoredAcronymString forSegmentAtIndex:0];
        }
        else
        {
            _acronymLabel.text          = [NSString stringWithFormat:@""];
            [self._timeTableSegmentedControl setTitle:@"Kürzel" forSegmentAtIndex:0];
        }
        
        // SET NEW ACRONYM WITH ACTUAL DATE
        [self setNewScheduleWithAcronym:_ownStoredAcronymString
         withAcronymType:_ownStoredAcronymType
         withAcronymText:[NSString stringWithFormat:@"von %@ (%@)"
                                         ,_ownStoredAcronymString
                                         ,[_translator getGermanTypeTranslation:_ownStoredAcronymType]
                                         ]
         ];
    
        //NSLog(@"setAcronymLabel new acronym %@",_ownStoredAcronymString);
    }    
}


- (void) setTitleToActualDate 
{
    NSDateFormatter* df_local = [[NSDateFormatter alloc] init];
    [df_local setTimeZone:[NSTimeZone timeZoneWithName:@"CEST"]];
    [df_local setDateFormat:@"yyyy.MM.dd G 'at' HH:mm:ss zzz"];    

    //----- Navigation Bar ----
    // set current day
    self._actualDate = [NSDate date];
    //self._actualDate    = [[_dateFormatter _dayFormatter] dateFromString:@"07.10.2013"];
    
    [self setDateInNavigatorWithActualDate:_actualDate];
    
    //NSLog(@"set actual Date: %@", [[self dayFormatter] stringFromDate:self._actualDate]);    
}



-(void) setNewAcronym:(NSString *)newAcronym withAcronymType:(NSString *)newAcronymType
{
    //NSLog(@"setNewAcronym");
    // SET NEW ACRONYM WITH ACTUAL DATE
    
    [self setNewScheduleWithAcronym:newAcronym
                    withAcronymType:newAcronymType
                    withAcronymText:[NSString stringWithFormat:@"von %@ (%@)"
                                     ,newAcronym
                                     ,[_translator getGermanTypeTranslation:newAcronymType]
                                     ]
     ];
}



- (void)viewDidLoad
{

    [super viewDidLoad];
    
    // general initializer
    _translator     = [[LanguageTranslation alloc] init];
    _dateFormatter  = [[DateFormation alloc] init];
    _zhawColor      = [[ColorSelection alloc] init];
    
    //----- TimeTableViewController ----
    // set table controller
    if (_timeTable == nil) {
		_timeTable = [[UITableView alloc] init];
	}
    // clear border colour between table cells
    _timeTable.separatorColor = _zhawColor._zhawLightGrey;
    
    
    // title
    //[_acronymLabel setBackgroundColor:_zhawColor._zhawOriginalBlue];
    [_acronymLabel setTextColor:_zhawColor._zhawWhite];
    [_acronymLabel setTextAlignment:UITextAlignmentCenter];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToMenuOverview:)];
    [backButtonItem setTintColor:_zhawColor._zhawOriginalBlue];
    
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = TimeTableOverVCTitle;
    _titleNavigationItem.title = @"";
    
    [_titleNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];
    [_titleNavigationLabel setTextAlignment:UITextAlignmentCenter];
    
    // segmented controls below the title
    [_timeTableSegmentedControl setTintColor:_zhawColor._zhawOriginalBlue];
    [self.view bringSubviewToFront:_timeTableSegmentedControl];
    [_segmentedControlNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];
    
    // set activity indicator
    _waitForLoadingActivityIndicator.hidesWhenStopped = YES;
    _waitForLoadingActivityIndicator.hidden = YES;
    [_waitForLoadingActivityIndicator setColor:_zhawColor._zhawOriginalBlue];
    //[_waitForLoadingActivityIndicator setBackgroundColor:_zhawColor._zhawOriginalBlue];
    [self.view bringSubviewToFront:_waitForLoadingActivityIndicator];
    
    
    //----- Navigation Bar for date ----
    // set current day
    [self setTitleToActualDate];
    
    // set day navigator
    UIBarButtonItem *_rightButton = [[UIBarButtonItem alloc] initWithTitle:RightArrowSymbol
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(dayAfter:)];
    UIBarButtonItem *_leftButton = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(dayBefore:)];
    [_rightButton setTintColor:_zhawColor._zhawOriginalBlue];
    [_leftButton  setTintColor:_zhawColor._zhawOriginalBlue];
    [_dayNavigator setLeftBarButtonItem :_leftButton animated :true];
    [_dayNavigator setRightBarButtonItem:_rightButton animated:true];
    [_dayNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];
    
    
    [_dateButton useAlertStyle];

    // ----- DETAIL PAGE -----
    if (_detailsVC == nil)
    {
		_detailsVC = [[TimeTableDetailController alloc] init];
	}
    _detailsVC._timeTableDetailViewDelegate = self;
    _detailsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    
    // ------ CHOOSE DATE FREELY ----
    if (_chooseDateVC == nil)
    {
		_chooseDateVC = [[ChooseDateViewController alloc] init];
	}
    _chooseDateVC._chooseDateViewDelegate = self;
    _chooseDateVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    // ------ SWITCH TO SEARCH VIEW ----
    if (_searchVC == nil)
    {
		_searchVC = [[SearchViewController alloc] init];
	}
    _searchVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    // ------ SWITCH TO SETTINGS VIEW ----
    if (_settingsVC == nil)
    {
		_settingsVC = [[SettingsViewController alloc] init];
	}
    _settingsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    
    //----- SET ACRONYM WHEN COMING FROM SEARCH TAB -----
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleSearchType:)
                                                 name:SettingsVCSearchType
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleSearchText:)
                                                 name:SettingsVCSearchText
                                               object:nil];

    
    // ------ INITIALIZE NO CONNECTION BUTTON ------
    [_noConnectionButton useAlertStyle];
    _noConnectionButton.hidden = YES;
    _noConnectionLabel.hidden = YES;
     [self.view bringSubviewToFront:_noConnectionButton];
     [self.view bringSubviewToFront:_noConnectionLabel];
     
     
    //[_noConnectionButton setBackgroundColor:_zhawColor._zhawOriginalBlue];
    //[_noConnectionButton setTintColor:_zhawColor._zhawOriginalBlue];
    
    // initialize swipe gestures
    _rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dayBefore:)];
    [_rightSwipe setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:_rightSwipe];
    
    _leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dayAfter:)];
    [_leftSwipe setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:_leftSwipe];
}


-(void) openChooseDateView
{
     _chooseDateVC._actualDate = self._actualDate;
    [self presentModalViewController:_chooseDateVC animated:YES];
}


- (void)handleSearchType:(id)object {
    //NSLog(@"%@ found something object?",object);
    NSString *txt = [object object]; // gets string from within notification object
    //NSLog(@"%@ found something text?",txt);
    self._searchType = txt;
}


- (void)handleSearchText:(id)object {
    //NSLog(@"%@ found something object?",object);
    NSString *txt = [object object]; // gets string from within notification object
    //NSLog(@"%@ found something text?",txt);
    self._searchText = txt;
    
    [self setNewScheduleWithAcronym:self._searchText
                    withAcronymType:[_translator getEnglishTypeTranslation:self._searchType]
                    withAcronymText:[NSString stringWithFormat:@"von %@ (%@)",self._searchText, self._searchType]
     ];
}

- (void) threadWaitForLoadingActivityIndicator:(id)data
{
    _waitForLoadingActivityIndicator.hidden = NO;
    [_waitForLoadingActivityIndicator startAnimating];
}


// IMPORTANT, OTHERWISE DATA WILL NOT BE UPDATED, WHEN APP IS STARTED FIRST TIME
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    

    //NSLog(@"viewWillAppear schedule type %@",_schedule._type);
    
    if (_ownStoredAcronymString != nil)
    {
        [self._timeTableSegmentedControl setTitle:_ownStoredAcronymString forSegmentAtIndex:0];
    }
    else
    {
        [self._timeTableSegmentedControl setTitle:@"Kürzel" forSegmentAtIndex:0];
    }
    
    
    // only reload, if acronym or date has changed
    if ( _schedule._type                  == nil
     || [_schedule._type length]          == 0
     ||  _schedule._connectionEstablished == nil
     || ([_schedule._connectionEstablished compare: @"NO"] == NSOrderedSame)
     ) 
    {
        //NSLog(@"viewWillAppear _actualShownAcronymString %@",_actualShownAcronymString);
        if (self._actualShownAcronymString == nil || [self._actualShownAcronymString length] == 0)
        {
            if (self._searchText != nil && [self._searchText length] > 0)
            {
                self._actualShownAcronymString       = self._searchText;
                self._actualShownAcronymType         = self._searchType;
            }
            else
            {
            
                if (self._ownStoredAcronymString == nil || [_ownStoredAcronymString length] == 0)
                {
                    NSUserDefaults *_acronymUserDefaults = [NSUserDefaults standardUserDefaults];
                    self._ownStoredAcronymString         = [_acronymUserDefaults stringForKey:TimeTableAcronym];
                    self._ownStoredAcronymType           = [self getAcronymType:_ownStoredAcronymString];
                }
                self._actualShownAcronymString       = self._ownStoredAcronymString;
                self._actualShownAcronymType         = self._ownStoredAcronymType;
            }
        }
        
        if (self._actualShownAcronymString != nil && [_actualShownAcronymString length] > 0)
        {

            if (_ownStoredAcronymString != nil)
            {
                self._acronymLabel.text          = [NSString stringWithFormat:@"von %@ (%@)"
                                                    ,self._actualShownAcronymString
                                                    ,[_translator getGermanTypeTranslation:self._actualShownAcronymType]
                                                    ];
                [self._timeTableSegmentedControl setTitle:_ownStoredAcronymString forSegmentAtIndex:0];
            }
            else
            {
                self._acronymLabel.text          = [NSString stringWithFormat:@""];
                [self._timeTableSegmentedControl setTitle:@"Kürzel" forSegmentAtIndex:0];
            }
            
            //self._schedule                 = [[ScheduleDto alloc] initWithAcronym:_actualShownAcronymString:_actualShownAcronymType:_actualDate];
            
            
            //NSLog(@"2 showScheduleDetails acronym: %@", self._actualShownAcronymString);
            _detailsVC._dayAndAcronymString = [NSString stringWithFormat:@"von %@ (%@)"
                                               ,self._actualShownAcronymString
                                               ,[_translator getGermanTypeTranslation:self._actualShownAcronymType]
                                               ];
            
            if (_actualShownAcronymTrials < 20)
            {
                [NSThread detachNewThreadSelector:@selector(threadWaitForLoadingActivityIndicator:) toTarget:self withObject:nil];
                
                //NSLog(@"viewWillAppear try connecting");
                _actualShownAcronymTrials++;
                if (self._schedule == nil)
                {
                    self._schedule = [[ScheduleDto alloc] initWithAcronym:_actualShownAcronymString:_actualShownAcronymType:_actualDate];
                }
                else
                {
                    self._schedule             = [_schedule initWithAcronym:_actualShownAcronymString:_actualShownAcronymType:_actualDate];
                }
                
                self._actualDayDto              = [self getDayDto];
                self._noConnectionButton.hidden = YES;
                self._noConnectionLabel.hidden = YES;
                
                [_timeTable reloadData];
                
                [_waitForLoadingActivityIndicator stopAnimating];
                _waitForLoadingActivityIndicator.hidden = YES;
            }
            else
            {
                //NSLog(@"50 mal versucht mit diesem Kürzel.");
                _noConnectionButton.hidden = NO;
                _noConnectionLabel.hidden = NO;
            }
        }
    }
    [_timeTableSegmentedControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
}



// also needed for shaking
-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    
    NSUserDefaults *_acronymUserDefaults = [NSUserDefaults standardUserDefaults];
    self._ownStoredAcronymString         = [_acronymUserDefaults stringForKey:TimeTableAcronym];
    self._ownStoredAcronymType           = [self getAcronymType:_ownStoredAcronymString];
    [self._timeTableSegmentedControl setTitle:_ownStoredAcronymString forSegmentAtIndex:0];
    
    // go to acronym page to enforce setting an acronym
    if (self._ownStoredAcronymString == nil && self._searchText == nil)
    {
        //NSLog(@"viewDidLoad noch kein Kürzel für den Stundenplan");
        
        UIAlertView *_acronymAlertView = [[UIAlertView alloc]
                                          initWithTitle:@"Stundenplan"
                                          message:@"Bitte ein Kürzel in Suche oder Einstellungen eingeben."
                                          delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
        
        [_acronymAlertView show];
        
        // switch to settings tab
        //[self presentModalViewController:_settingsVC animated:YES];
        //NSLog(@"cannot load acronym view");
    }
}

// also needed for shaking
- (void)viewWillDisappear:(BOOL)animated 
{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

// gets values from acronym alert view
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle=[alertView buttonTitleAtIndex:buttonIndex];
    if([buttonTitle isEqualToString:@"OK"])
    {
        UITextField *_textField = (UITextField*)[alertView viewWithTag:1001];
        
        if (_actualShownAcronymString == nil ||
            [_actualShownAcronymString  compare: _textField.text ]!= NSOrderedSame)
        {
            self._actualShownAcronymString       = _textField.text;
            _actualShownAcronymTrials            = 1;
            
            if (_ownStoredAcronymString != nil)
            {
                _acronymLabel.text                   = [NSString stringWithFormat:@"von %@",_actualShownAcronymString];
                [self._timeTableSegmentedControl setTitle:_ownStoredAcronymString forSegmentAtIndex:0];
            }
            else
            {
                _acronymLabel.text                   = [NSString stringWithFormat:@""];
                [self._timeTableSegmentedControl setTitle:@"Kürzel" forSegmentAtIndex:0];
            }
            
            NSUserDefaults *_acronymUserDefaults = [NSUserDefaults standardUserDefaults];
            [_acronymUserDefaults setObject:_actualShownAcronymString forKey:TimeTableAcronym];
            [_acronymUserDefaults synchronize];
        }
        // NSLog(@"ok button is pushed: %@ %@", _textField.text, _acronymString);
    }
}



// needed for shaking
-(BOOL)canBecomeFirstResponder {
    return YES;
}




//this one is also needed for shaking
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [self setTitleToActualDate];
        if (self._ownStoredAcronymString != nil)
        {
            [self setNewAcronym:self._ownStoredAcronymString withAcronymType:self._ownStoredAcronymType];
        }
    }
}


- (void)viewDidUnload
{
    _oneSlotOneRoomTableCell    = nil;
    _oneSlotTwoRoomsTableCell   = nil;
    _oneSlotThreeRoomsTableCell = nil;
    _oneSlotFourRoomsTableCell = nil;
    _oneSlotFiveRoomsTableCell  = nil;
    _oneSlotSixRoomsTableCell   = nil;
    _oneSlotSevenRoomsTableCell = nil;
    _oneSlotEightRoomsTableCell = nil;

    _twoSlotsOneRoomTableCell   = nil;
    _twoSlotsTwoRoomsTableCell  = nil;
    _twoSlotsThreeRoomsTableCell = nil;
    _twoSlotsFourRoomsTableCell = nil;

    _twoSlotsSixRoomsTableCell = nil;

    _threeSlotsOneRoomTableCell = nil;
    _threeSlotsTwoRoomsTableCell = nil;
    _threeSlotsThreeRoomsTableCell = nil;
    
    _fourSlotsOneRoomTableCell    = nil;
    _fourSlotsTwoRoomsTableCell   = nil;
    _fourSlotsThreeRoomsTableCell = nil;
    _fourSlotsFiveRoomsTableCell = nil;
    
    _fiveSlotsOneRoomTableCell    = nil;
    
    _sixSlotsOneRoomTableCell = nil;
    _sixSlotsTwoRoomsTableCell = nil;

    _sevenSlotsOneRoomTableCell = nil;
    
    _eightSlotsOneRoomTableCell = nil;

    _emptyTableCell = nil;
    _errorMessageCell = nil;
    
    _noConnectionButton = nil;
    _noConnectionLabel = nil;

    _detailsVC = nil;
    _chooseDateVC = nil;
    _settingsVC = nil;
    _searchVC = nil;    
    
    _dayNavigator = nil;
    _acronymLabel = nil;
    
    _rightSwipe = nil;
    _leftSwipe = nil;

    [self set_errorMessageCell:nil];
    
    _waitForLoadingActivityIndicator = nil;

    _timeTableSegmentedControl = nil;

    _dateButton = nil;
    
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    _fourSlotsFourRoomsTableCell = nil;
    _nineSlotsThreeRoomsTableCell = nil;
    _sevenSlotsEightRoomsTableCell = nil;
    _dayNavigationBar = nil;
    _segmentedControlNavigationBar = nil;
    [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




// ------- MANAGE SCHEDULE DETAIL PAGE ----
-(void) setScheduleDetail:(ScheduleDto *)newSchedule 
{
   // NSLog(@"setScheduleDetail");
}


-(void) showScheduleDetails:(id)sender event:(id)event
{
    NSSet       *_touches              = [event    allTouches];
    UITouch     *_touch                = [_touches anyObject ];
    CGPoint      _currentTouchPosition = [_touch locationInView:self._timeTable];
    NSIndexPath *_indexPath            = [self._timeTable indexPathForRowAtPoint: _currentTouchPosition];
    
    if (_indexPath.section < [_actualDayDto._events count])
    {
        _detailsVC._scheduleEvent = [_actualDayDto._events objectAtIndex:_indexPath.section];
        
        //NSLog(@"schedule event name %@", _detailsVC._scheduleEvent._name);
        //NSLog(@"showScheduleDetails date   : %@",[[self dayFormatter] stringFromDate:_actualDate]);
        //NSLog(@"1 showScheduleDetails acronym: %@", self._actualShownAcronymString);
    
        _detailsVC._dayAndAcronymString = [NSString stringWithFormat:@"von %@ (%@)"
                                           , self._actualShownAcronymString
                                           ,[_translator getGermanTypeTranslation:self._actualShownAcronymType]
                                           ];
    
        NSString *_fromString           = [[_dateFormatter _timeFormatter] stringFromDate: _detailsVC._scheduleEvent._startTime];
        NSString *_toString             = [[_dateFormatter _timeFormatter] stringFromDate: _detailsVC._scheduleEvent._endTime  ];
        
        //NSLog(@"schedule event end time %@", _toString);
        
        _detailsVC._timeString          = [NSString stringWithFormat:@"Modul für den %@ von %@ bis %@"
                                           ,[[_dateFormatter _dayFormatter] stringFromDate:_actualDate]
                                           ,_fromString
                                           ,_toString];
        _detailsVC._timeLabel.text      = _detailsVC._timeString;
        
        [_detailsVC._detailTable reloadData];
        
        
        [_detailsVC setNavigationTitle:_detailsVC._dayAndAcronymString];
        
        [self presentModalViewController:_detailsVC animated:YES];
    }
}




-(void) changeToRoomSchedule:(id)sender withEvent:(id)event withRealizationIndex:(int)realizationIndex
{
    NSSet       *_touches              = [event    allTouches];
    UITouch     *_touch                = [_touches anyObject ];
    CGPoint      _currentTouchPosition = [_touch locationInView:self._timeTable];
    NSIndexPath *_indexPath            = [self._timeTable indexPathForRowAtPoint: _currentTouchPosition];
    ScheduleEventDto            *_localScheduleEvent;
    ScheduleEventRealizationDto *_localRealization;
    NSString                    *_roomString;
    
    if (_indexPath.section < [_actualDayDto._events count])
    {
        _localScheduleEvent = [_actualDayDto._events objectAtIndex:_indexPath.section];
        _localRealization   = [_localScheduleEvent._scheduleEventRealizations objectAtIndex:realizationIndex];
        
        _roomString         = _localRealization._room._name;
        
        // SET NEW ACRONYM WITH ACTUAL DATE
        [self setNewScheduleWithAcronym:_roomString
                        withAcronymType:@"rooms"
                        withAcronymText:[NSString stringWithFormat:@"von %@ (Raum)",_roomString]
         ];
        //NSLog(@"new room schedule is set");
    }
}



-(void) changeToCourseSchedule:(id)sender event:(id)event
{
    NSSet            *_touches              = [event    allTouches];
    UITouch          *_touch                = [_touches anyObject ];
    CGPoint           _currentTouchPosition = [_touch locationInView:self._timeTable];
    NSIndexPath      *_indexPath            = [self._timeTable indexPathForRowAtPoint: _currentTouchPosition];
    ScheduleEventDto *_localScheduleEvent;
    NSString         *_courseString;
    
    if (_indexPath.section < [_actualDayDto._events count])
    {
        _localScheduleEvent = [_actualDayDto._events objectAtIndex:_indexPath.section];
        
        _courseString       = _localScheduleEvent._name;
        
        // SET NEW ACRONYM WITH ACTUAL DATE
        [self setNewScheduleWithAcronym:_courseString
                        withAcronymType:@"courses"
                        withAcronymText:[NSString stringWithFormat:@"von %@ (Kurs)",_courseString]];
    }
}


- (void) changeToRoomSchedule1:(id)sender event:(id)event
{
    [self changeToRoomSchedule:sender withEvent:event withRealizationIndex:0];
}

- (void) changeToRoomSchedule2:(id)sender event:(id)event
{
    [self changeToRoomSchedule:sender withEvent:event withRealizationIndex:1];
}

- (void) changeToRoomSchedule3:(id)sender event:(id)event
{
    [self changeToRoomSchedule:sender withEvent:event withRealizationIndex:2];
}

- (void) changeToRoomSchedule4:(id)sender event:(id)event
{
    [self changeToRoomSchedule:sender withEvent:event withRealizationIndex:3];
}

- (void) changeToRoomSchedule5:(id)sender event:(id)event
{
    [self changeToRoomSchedule:sender withEvent:event withRealizationIndex:4];
}

- (void) changeToRoomSchedule6:(id)sender event:(id)event
{
    [self changeToRoomSchedule:sender withEvent:event withRealizationIndex:5];
}

- (void) changeToRoomSchedule7:(id)sender event:(id)event
{
    [self changeToRoomSchedule:sender withEvent:event withRealizationIndex:6];
}

- (void) changeToRoomSchedule8:(id)sender event:(id)event
{
    [self changeToRoomSchedule:sender withEvent:event withRealizationIndex:7];
}



// --------------------------------



// ------- MANAGE TABLE CELLS ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self._schedule._errorMessage != nil)
    {
        return 1;
    }
    else
    {
        return [_actualDayDto._events count];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"in numberOfRowsInSection");
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1; //[_schedule._days count]; //first 1 // [_timeTableSlotArray count];
}
 

- (NSMutableArray *)getCurrentScheduleEventArrayWithDay       :(DayDto *)        currentDay
                                    withFromTimeString        :(NSString *)      fromTimeString
                                    withToTimeString          :(NSString *)      toTimeString
                                withFormerScheduleEventArray  :(NSMutableArray *)formerScheduleEventArray
{   
    
    NSDate           *_fromTime          = [[_dateFormatter _timeFormatter] dateFromString:fromTimeString];
    NSDate           *_toTime            = [[_dateFormatter _timeFormatter] dateFromString:toTimeString];
    NSString         *_fromString        = fromTimeString; 
    NSString         *_toString          = toTimeString; 
    NSString         *_fromLocalScheduleEvent;
    NSString         *_toLocalScheduleEvent;
    NSString         *_formerToEvent;
    NSString         *_formerFromEvent;
    
    NSMutableArray   *_allGoalScheduleEventArray        = [[NSMutableArray alloc]init];
    NSMutableArray   *_localFormerScheduleEventArray    = [[NSMutableArray alloc]init];
    NSMutableArray   *_emptyArray                       = [[NSMutableArray alloc]init];
    
    ScheduleEventDto *_localScheduleEvent        = nil;
    ScheduleEventDto *_goalScheduleEvent         = nil;
    ScheduleEventDto *_localFormerScheduleEvent  = nil;
    
    ScheduleEventRealizationDto *_formerRealization = nil;
    ScheduleEventRealizationDto *_localRealization  = nil;
    
    BOOL              _sameEventAgain       = NO;
    
    int dayI;
    int localFormerScheduleEventArrayI;
    
    //NSLog(@"----------------------------------");
    for (localFormerScheduleEventArrayI = 0; localFormerScheduleEventArrayI < [formerScheduleEventArray count]; localFormerScheduleEventArrayI ++)
    {
        _localScheduleEvent     = [formerScheduleEventArray objectAtIndex:localFormerScheduleEventArrayI];
        [_localFormerScheduleEventArray     addObject: _localScheduleEvent];
        //_toLocalScheduleEvent   = [[_dateFormatter _timeFormatter] stringFromDate: _localScheduleEvent._endTime];
        //_fromLocalScheduleEvent = [[_dateFormatter _timeFormatter] stringFromDate: _localScheduleEvent._startTime];
        //NSLog(@"former event: %@ from %@ to %@", _localScheduleEvent._name, _fromLocalScheduleEvent, _toLocalScheduleEvent);
    }
    //NSLog(@"----------------------------------");
    
    
    for (dayI = 0; dayI < [currentDay._events count]; dayI ++)
    {   
        _localScheduleEvent     = [currentDay._events objectAtIndex:dayI];     
        _fromLocalScheduleEvent = [[_dateFormatter _timeFormatter] stringFromDate: _localScheduleEvent._startTime];
        _toLocalScheduleEvent   = [[_dateFormatter _timeFormatter] stringFromDate: _localScheduleEvent._endTime];
        
        // actual time slot is defined by fromString and toString
        // the local schedule event must be either between them or be one of them
        if (  [_fromString compare: _fromLocalScheduleEvent] == NSOrderedSame
            ||[_toString   compare: _toLocalScheduleEvent  ] == NSOrderedSame
            ||(
               // _fromString is later in time than _fromLocalScheduleEvent
               // and _toString is earlier in time than _toLocalScheduleEvent
                    [_fromString          compare: _fromLocalScheduleEvent  ] == NSOrderedDescending
                    &&[_toString          compare: _toLocalScheduleEvent    ] == NSOrderedAscending
              )
            ||(
               // _fromString is later in time than _fromLocalScheduleEvent
               // and _fromString is earlier in time than _toLocalScheduleEvent
               [_fromString          compare: _fromLocalScheduleEvent  ] == NSOrderedDescending
               &&[_fromString          compare: _toLocalScheduleEvent    ] == NSOrderedAscending
               )
            )
        {
        
            // loop over all events which are already added, to avoid listing this one again
            if ([_localFormerScheduleEventArray count] > 0 )
            {
                _sameEventAgain = NO;
                for (localFormerScheduleEventArrayI = 0; localFormerScheduleEventArrayI < [_localFormerScheduleEventArray count]; localFormerScheduleEventArrayI ++)
                {
                    if (!_sameEventAgain)
                    {
                        _localFormerScheduleEvent = [_localFormerScheduleEventArray objectAtIndex:localFormerScheduleEventArrayI];
                        _formerFromEvent = [[_dateFormatter _timeFormatter] stringFromDate: _localFormerScheduleEvent._startTime];
                        _formerToEvent   = [[_dateFormatter _timeFormatter] stringFromDate: _localFormerScheduleEvent._endTime];
            
                        // if the same lecture comes again, don't list it again
                        // then the time of the former event must be between them or one of the them
                        if(
                           ([_formerFromEvent          compare: _fromLocalScheduleEvent  ] == NSOrderedSame
                            ||[_formerToEvent          compare: _toLocalScheduleEvent    ] == NSOrderedSame
                            ||(
                                 [_formerFromEvent       compare: _fromLocalScheduleEvent  ] == NSOrderedDescending
                               &&[_formerToEvent         compare: _toLocalScheduleEvent    ] == NSOrderedAscending
                               )
                            )
                           && [_localFormerScheduleEvent._name compare: _localScheduleEvent._name] == NSOrderedSame
                           )
                        {                            
                            //NSLog(@"_localScheduleEvent._name: %@ from %@ to %@ <-> former event %@ from %@ to %@"
                            //      , _localScheduleEvent._name
                            //      , _fromLocalScheduleEvent
                            //      , _toLocalScheduleEvent
                            //      ,_localFormerScheduleEvent._name
                            //      ,_formerFromEvent
                            //      ,_formerToEvent
                            //     );
                            
                            // also compare the rooms, mabye the next lecture is somewhere else
                            if (   [_localScheduleEvent._scheduleEventRealizations count] == 1
                                && [_localFormerScheduleEvent._scheduleEventRealizations count] == 1
                                )
                            {
                                 _formerRealization = [_localFormerScheduleEvent._scheduleEventRealizations objectAtIndex:0];
                                _localRealization = [_localScheduleEvent._scheduleEventRealizations objectAtIndex:0];
                            
                                if  ([_formerRealization._room._name compare: _localRealization._room._name] == NSOrderedSame)
                                {
                                    _goalScheduleEvent = [[ScheduleEventDto alloc]init:@"":_fromTime:_toTime:@"same":_emptyArray:@"same":_emptyArray];
                                    [_allGoalScheduleEventArray     addObject: _goalScheduleEvent];
                                    _sameEventAgain    = YES;
                                    //NSLog(@"only one room and its the same one");
                                }
                                //else
                                //{
                                //    NSLog(@"only one room but they are different");
                                //}
                            }
                            else // more than one room
                            {
                                _goalScheduleEvent = [[ScheduleEventDto alloc]init:@"":_fromTime:_toTime:@"same":_emptyArray:@"same":_emptyArray];
                                [_allGoalScheduleEventArray     addObject: _goalScheduleEvent];
                                _sameEventAgain    = YES;
                                //NSLog(@"more than one room, but they are not compared");
                            }
                        } // events are not the same
                        else
                        {
                            _sameEventAgain    = NO;
                        }
                    } // end if sameEventAgain
                } // end loop over former events
            } // end if localFormerArray count > 0
        
            // found a (new) schedule event for this time
            if (!_sameEventAgain && [_localScheduleEvent._name length] != 0)
            {
                [_allGoalScheduleEventArray     addObject: _localScheduleEvent];
                [_localFormerScheduleEventArray addObject: _localScheduleEvent];
            }
        } // end if dates of event fits into desired time intervall
    } // end looping over all events of current day
    
    // no event for given time intervall found, create an empty one and return it
    if ([_allGoalScheduleEventArray count] == 0)
    {
        _goalScheduleEvent = [[ScheduleEventDto alloc]init:@"":_fromTime:_toTime:@"empty":_emptyArray:@"empty":_emptyArray];
        [_allGoalScheduleEventArray addObject: _goalScheduleEvent];
        //_toLocalScheduleEvent   = [[_dateFormatter _timeFormatter] stringFromDate: _goalScheduleEvent._endTime];
        //_fromLocalScheduleEvent = [[_dateFormatter _timeFormatter] stringFromDate: _goalScheduleEvent._startTime];
        //NSLog(@"_goalScheduleEvent._name: %@ from %@ to %@", _goalScheduleEvent._name, _fromLocalScheduleEvent, _toLocalScheduleEvent);
    }
    return _allGoalScheduleEventArray;
}



- (NSMutableArray *)addToSortedScheduleEventArray:(NSMutableArray *)spottedScheduleEventArray
                      withScheduleEventArrayToAdd:(NSMutableArray *)formerSheduleEventArray
                               withDatesToDisplay:(NSString *)datesToDisplay
{
    int scheduleEventArrayI;
    NSMutableArray   *_returnEventArray = [[NSMutableArray alloc]init];
    ScheduleEventDto *_oneScheduleEvent = [[ScheduleEventDto alloc] init:nil :nil :nil :nil :nil :nil :nil];
    //NSString         *_fromLocalScheduleEvent;
    //NSString         *_toLocalScheduleEvent;
    
    // add former events
    for (scheduleEventArrayI = 0; scheduleEventArrayI < [formerSheduleEventArray count]; scheduleEventArrayI ++)
    {
        _oneScheduleEvent = [formerSheduleEventArray objectAtIndex:scheduleEventArrayI];
        [_returnEventArray  addObject:_oneScheduleEvent];
    }
    
    // add new events
    for (scheduleEventArrayI = 0; scheduleEventArrayI < [spottedScheduleEventArray count]; scheduleEventArrayI ++)
    {
        _oneScheduleEvent = [spottedScheduleEventArray objectAtIndex:scheduleEventArrayI];
        if ([_oneScheduleEvent._name compare: @"same"] != NSOrderedSame)
        {
            //_toLocalScheduleEvent   = [[_dateFormatter _timeFormatter] stringFromDate: _oneScheduleEvent._endTime];
            //_fromLocalScheduleEvent = [[_dateFormatter _timeFormatter] stringFromDate: _oneScheduleEvent._startTime];
            //NSLog(@"%@ => %@ from %@ to %@", datesToDisplay, _oneScheduleEvent._name, _fromLocalScheduleEvent, _toLocalScheduleEvent);
            [_returnEventArray  addObject:_oneScheduleEvent];
        }
    }
    
    return _returnEventArray;
}




- (NSMutableArray *)getSortedScheduleEvent:(DayDto *)currentDay
{
    ScheduleEventDto    *_oneScheduleEvent          = [[ScheduleEventDto alloc] init:nil :nil :nil :nil :nil :nil :nil];
    NSMutableArray      *_firstScheduleEventArray   = [[NSMutableArray alloc]init];
    NSMutableArray      *_nextScheduleEventArray    = nil;
    BOOL                _foundHoliday         = NO;
    
    // check for exceptional holiday first
    // also consider problem for days where there are no events, but neither holidays
    if ([currentDay._events count] > 0)
    {   int eventArrayI = 0;
        ScheduleEventDto *_holidayEvent = [currentDay._events objectAtIndex:eventArrayI];
    
        //NSLog(@"event._type: %@", _holidayEvent._type);
        if ([_holidayEvent._type isEqualToString:@"Holiday"])
        {
            //_fromTime           = [[_dateFormatter _timeFormatter] dateFromString:@"00:00"];
            //_toTime             = [[_dateFormatter _timeFormatter] dateFromString:@"23:59"];
            NSString       *_fromString = @"00:00"; //[[_dateFormatter _timeFormatter] stringFromDate: _fromTime];
            NSString       *_toString   = @"23:59"; // [[_dateFormatter _timeFormatter] stringFromDate: _toTime];
            
            _oneScheduleEvent = [currentDay._events objectAtIndex:0];
            NSString       *_fromHoliday = [[_dateFormatter _timeFormatter] stringFromDate: _oneScheduleEvent._startTime];
            NSString       *_toHoliday   = [[_dateFormatter _timeFormatter] stringFromDate: _oneScheduleEvent._endTime];
            
            //NSLog(@"(_fromHoliday) %@ = (_fromString) %@, (_toHoliday) %@ = (_toString) %@ _toString", _fromHoliday, _fromString, _toHoliday, _toString);
            
            if ([_fromHoliday isEqualToString:_fromString] &&
                [_toHoliday   isEqualToString:_toString])
            {
                [_firstScheduleEventArray addObject:_holidayEvent];
                _foundHoliday = YES;
            }
        }
    }
    
    if (!_foundHoliday)
    {
        _nextScheduleEventArray = [self getCurrentScheduleEventArrayWithDay  :currentDay
                                                withFromTimeString        :@"08:00"
                                                withToTimeString          :@"08:45"
                                                withFormerScheduleEventArray   :_firstScheduleEventArray];
        
        _firstScheduleEventArray = [self addToSortedScheduleEventArray:_nextScheduleEventArray
                                           withScheduleEventArrayToAdd:_firstScheduleEventArray
                                                    withDatesToDisplay:@"08:00-08:45"];
        
        
        _nextScheduleEventArray  = [self getCurrentScheduleEventArrayWithDay  :currentDay
                                                withFromTimeString        :@"08:50"
                                                withToTimeString          :@"09:35"
                                                withFormerScheduleEventArray   :_firstScheduleEventArray];
        
        _firstScheduleEventArray = [self addToSortedScheduleEventArray:_nextScheduleEventArray
                                           withScheduleEventArrayToAdd:_firstScheduleEventArray
                                                    withDatesToDisplay:@"08:50-09:35"];
        
        _nextScheduleEventArray  = [self getCurrentScheduleEventArrayWithDay  :currentDay
                                                withFromTimeString        :@"10:00"
                                                withToTimeString          :@"10:45"
                                                withFormerScheduleEventArray   :_firstScheduleEventArray];
        
        _firstScheduleEventArray = [self addToSortedScheduleEventArray:_nextScheduleEventArray
                                           withScheduleEventArrayToAdd:_firstScheduleEventArray
                                                    withDatesToDisplay:@"10:00-10:45"];
    
        _nextScheduleEventArray  = [self getCurrentScheduleEventArrayWithDay  :currentDay
                                                          withFromTimeString        :@"10:50"
                                                          withToTimeString          :@"11:35"
                                                          withFormerScheduleEventArray   :_firstScheduleEventArray];
        
        _firstScheduleEventArray = [self addToSortedScheduleEventArray:_nextScheduleEventArray
                                           withScheduleEventArrayToAdd:_firstScheduleEventArray
                                                    withDatesToDisplay:@"10:50-11:35"];
            
        _nextScheduleEventArray  = [self getCurrentScheduleEventArrayWithDay  :currentDay
                                                          withFromTimeString        :@"12:00"
                                                          withToTimeString          :@"12:45"
                                                          withFormerScheduleEventArray   :_firstScheduleEventArray];
        
        _firstScheduleEventArray = [self addToSortedScheduleEventArray:_nextScheduleEventArray
                                           withScheduleEventArrayToAdd:_firstScheduleEventArray
                                                    withDatesToDisplay:@"12:00-12:45"];
    
        _nextScheduleEventArray  = [self getCurrentScheduleEventArrayWithDay  :currentDay
                                                          withFromTimeString        :@"12:50"
                                                          withToTimeString          :@"13:35"
                                                          withFormerScheduleEventArray   :_firstScheduleEventArray];
        
        _firstScheduleEventArray = [self addToSortedScheduleEventArray:_nextScheduleEventArray
                                           withScheduleEventArrayToAdd:_firstScheduleEventArray
                                                    withDatesToDisplay:@"12:50-13:35"];
    
        _nextScheduleEventArray  = [self getCurrentScheduleEventArrayWithDay  :currentDay
                                                          withFromTimeString        :@"14:00"
                                                          withToTimeString          :@"14:45"
                                                          withFormerScheduleEventArray   :_firstScheduleEventArray];
        
        _firstScheduleEventArray = [self addToSortedScheduleEventArray:_nextScheduleEventArray
                                           withScheduleEventArrayToAdd:_firstScheduleEventArray
                                                    withDatesToDisplay:@"14:00-14:45"];
        
        _nextScheduleEventArray  = [self getCurrentScheduleEventArrayWithDay  :currentDay
                                                          withFromTimeString        :@"14:50"
                                                          withToTimeString          :@"15:35"
                                                          withFormerScheduleEventArray   :_firstScheduleEventArray];
        
        _firstScheduleEventArray = [self addToSortedScheduleEventArray:_nextScheduleEventArray
                                           withScheduleEventArrayToAdd:_firstScheduleEventArray
                                                    withDatesToDisplay:@"14:50-15:35"];
        
        _nextScheduleEventArray  = [self getCurrentScheduleEventArrayWithDay  :currentDay
                                                          withFromTimeString        :@"16:00"
                                                          withToTimeString          :@"16:45"
                                                          withFormerScheduleEventArray   :_firstScheduleEventArray];
        
        _firstScheduleEventArray = [self addToSortedScheduleEventArray:_nextScheduleEventArray
                                           withScheduleEventArrayToAdd:_firstScheduleEventArray
                                                    withDatesToDisplay:@"16:00-16:45"];
        
        _nextScheduleEventArray  = [self getCurrentScheduleEventArrayWithDay  :currentDay
                                                          withFromTimeString        :@"16:50"
                                                          withToTimeString          :@"17:35"
                                                          withFormerScheduleEventArray   :_firstScheduleEventArray];
        
        _firstScheduleEventArray = [self addToSortedScheduleEventArray:_nextScheduleEventArray
                                           withScheduleEventArrayToAdd:_firstScheduleEventArray
                                                    withDatesToDisplay:@"16:50-17:35"];
    
        _nextScheduleEventArray  = [self getCurrentScheduleEventArrayWithDay  :currentDay
                                                          withFromTimeString        :@"18:00"
                                                          withToTimeString          :@"18:45"
                                                          withFormerScheduleEventArray   :_firstScheduleEventArray];
        
        _firstScheduleEventArray = [self addToSortedScheduleEventArray:_nextScheduleEventArray
                                           withScheduleEventArrayToAdd:_firstScheduleEventArray
                                                    withDatesToDisplay:@"18:00-18:45"];
    
        _nextScheduleEventArray  = [self getCurrentScheduleEventArrayWithDay  :currentDay
                                                          withFromTimeString        :@"18:50"
                                                          withToTimeString          :@"19:35"
                                                          withFormerScheduleEventArray   :_firstScheduleEventArray];
        
        _firstScheduleEventArray = [self addToSortedScheduleEventArray:_nextScheduleEventArray
                                           withScheduleEventArrayToAdd:_firstScheduleEventArray
                                                    withDatesToDisplay:@"18:50-19:35"];
        
        _nextScheduleEventArray  = [self getCurrentScheduleEventArrayWithDay  :currentDay
                                                          withFromTimeString        :@"19:45"
                                                          withToTimeString          :@"20:30"
                                                          withFormerScheduleEventArray   :_firstScheduleEventArray];
        
        _firstScheduleEventArray = [self addToSortedScheduleEventArray:_nextScheduleEventArray
                                           withScheduleEventArrayToAdd:_firstScheduleEventArray
                                                    withDatesToDisplay:@"19:45-20:30"];
        
        _nextScheduleEventArray  = [self getCurrentScheduleEventArrayWithDay  :currentDay
                                                          withFromTimeString        :@"20:35"
                                                          withToTimeString          :@"21:20"
                                                          withFormerScheduleEventArray   :_firstScheduleEventArray];
        
        
        _firstScheduleEventArray = [self addToSortedScheduleEventArray:_nextScheduleEventArray
                                           withScheduleEventArrayToAdd:_firstScheduleEventArray
                                                    withDatesToDisplay:@"20:35-21:20"];
    }
    
    //NSLog(@"-################################-");
    //int sortedEventsI;
    //NSString            *_fromLocalScheduleEvent;
    //NSString            *_toLocalScheduleEvent;
    //for (sortedEventsI = 0; sortedEventsI < [_firstScheduleEventArray count]; sortedEventsI ++)
    //{
    //    _oneScheduleEvent     = [_firstScheduleEventArray objectAtIndex:sortedEventsI];
    //    _toLocalScheduleEvent   = [[_dateFormatter _timeFormatter] stringFromDate: _oneScheduleEvent._endTime];
    //    _fromLocalScheduleEvent = [[_dateFormatter _timeFormatter] stringFromDate: _oneScheduleEvent._startTime];
    //    NSLog(@"_sortedEvents: %@ from %@ to %@", _oneScheduleEvent._name, _fromLocalScheduleEvent, _toLocalScheduleEvent);
    //}
    //NSLog(@"-################################-");
    
    //NSLog(@"getSortedScheduleEvent %i", [_sortedEvents count] );
    return _firstScheduleEventArray;
}



- (DayDto *)getDayDto
{
    DayDto         *_oneDay   = nil;
    DayDto         *_foundDay = nil;
    DayDto         *_newDay   = nil;
    NSMutableArray *_newEvents = [[NSMutableArray alloc]init];
    NSMutableArray *_newSlots  = [[NSMutableArray alloc]init];
    
    //NSLog(@"how many days %i", [_schedule._days count]);
    int      dayCount;
    for (dayCount = 0; dayCount < [_schedule._days count]; dayCount++) 
    {
      _oneDay = [_schedule._days objectAtIndex:dayCount];
    
      NSString *_oneDayString    = [[_dateFormatter _dayFormatter] stringFromDate:_oneDay._date];
      NSString *_actualDayString = [[_dateFormatter _dayFormatter] stringFromDate:_actualDate];
      
      //NSLog(@"getDayDto %@ = %@?", _oneDayString, _actualDayString);
      
      if ([_oneDayString isEqualToString: _actualDayString]) 
      {
          _foundDay = _oneDay;
          //NSString * _foundDayString = [[self dayFormatter] stringFromDate:_foundDay._date];
          //NSLog(@"_foundDayString %@", _foundDayString);
      }
    }
    
    _newEvents = [self getSortedScheduleEvent:_foundDay];
    _newDay    = [[DayDto alloc]init: _foundDay._date :_newEvents: _newSlots];
    
    return _newDay;
}



- (BOOL) isActualDayAndTime:(NSDate *)actualDate
              withStartTimeString:(NSString *)startTimeString
                withEndTimeString:(NSString *)endTimeString
{

    NSDate *_today = [NSDate date];
    
    //NSDate *_today   = [[_dateFormatter _dayFormatter] dateFromString:@"07.10.2013"];
 
    NSString *_actualDayString    = [[_dateFormatter _dayFormatter] stringFromDate:_actualDate];
    NSString *_todayString        = [[_dateFormatter _dayFormatter] stringFromDate:_today];
    
    //NSLog(@"get actual Date: %@ and today: %@", _actualDayString, _todayString);
    
    // compare dates
    if ([_actualDayString isEqualToString: _todayString]) 
    {
        // compare time slots
        NSString *_todayTimeString     = [[_dateFormatter _timeFormatter] stringFromDate:_today];
        //NSString *_todayTimeString = @"14:05";
        
        // _todayTimeString is later in time than _fromString
        // and _todayTimeString is earlier in time than _toString
        if (    [_todayTimeString          compare: startTimeString  ] == NSOrderedDescending
            &&  [_todayTimeString          compare: endTimeString    ] == NSOrderedAscending
            )
        {
          //NSLog(@"YES _fromString: %@ _toString: %@ _todayTimeString: %@", startTimeString, endTimeString, _todayTimeString);
          return YES;
        }
    }
   // return YES;
    return NO;
}



- (void) setLectureButtonWithCell:(UITableViewCell *)cell
        withTag            :(int)       indexTag
        withTitle          :(NSString *)title
        doEnable           :(BOOL)      enable
{

    UIButton  *_lectureButton = (UIButton *)[cell viewWithTag:indexTag];
    
    NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:title];
    
    [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
    
    [_lectureButton setAttributedTitle:_titleString forState:UIControlStateNormal];
    
    _lectureButton.enabled = enable;
    
    if (enable)
    {
       [_lectureButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}


- (void) setRoomButtonWithCell:(UITableViewCell *)cell
              withTag            :(int)       indexTag
              withTitle          :(NSString *)title
              withSelector       :(int)       selector
{
     UIButton *_roomButton = (UIButton *)[cell viewWithTag:indexTag];
    [_roomButton    setTitle:@"" forState:UIControlStateNormal];
    
    if ([title length] > 0)
    {
    
        _roomButton.enabled     = TRUE;
    
        NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:title];
        [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
        [_roomButton    setAttributedTitle:_titleString forState:UIControlStateNormal];
    
        if (selector == 1)
        {
            [_roomButton    addTarget:self action:@selector(changeToRoomSchedule1   :event:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (selector == 2)
        {
            [_roomButton   addTarget:self action:@selector(changeToRoomSchedule2   :event:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (selector == 3)
        {
            [_roomButton   addTarget:self action:@selector(changeToRoomSchedule3   :event:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (selector == 4)
        {
            [_roomButton   addTarget:self action:@selector(changeToRoomSchedule4   :event:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (selector == 5)
        {
            [_roomButton   addTarget:self action:@selector(changeToRoomSchedule5   :event:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (selector == 6)
        {
            [_roomButton   addTarget:self action:@selector(changeToRoomSchedule6   :event:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (selector == 7)
        {
            [_roomButton   addTarget:self action:@selector(changeToRoomSchedule7   :event:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (selector == 8)
        {
            [_roomButton   addTarget:self action:@selector(changeToRoomSchedule8   :event:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}


- (void) setDetailButtonWithCell:(UITableViewCell *)cell
              withTag            :(int)       indexTag
{
    UIButton  *_detailButton  = (UIButton *)[cell viewWithTag:indexTag];  // with arrow image, leading to detail page
    
    _detailButton.enabled   = TRUE;
    _detailButton.hidden    = NO;
    
    [_detailButton  addTarget:self action:@selector(showScheduleDetails     :event:) forControlEvents:UIControlEventTouchUpInside];
}



- (void) setDateLabelWithCell:(UITableViewCell *)cell
             withTag            :(int)       indexTag
             withStartTime      :(NSDate *)  startTime
             withEndTime        :(NSDate *)  endTime
{
    UILabel          *_labelDate     = (UILabel  *)[cell viewWithTag:indexTag];
    NSString *_startTimeString = [[_dateFormatter _timeFormatter] stringFromDate:startTime];
    NSString *_endTimeString   = [[_dateFormatter _timeFormatter] stringFromDate:endTime];
    
    _labelDate.text = [NSString stringWithFormat:@"%@ - %@",
                       _startTimeString,
                       _endTimeString
                       ];
}


- (void)setActualLectureButtonWithCell:(UITableViewCell *)cell
                   withTag            :(int)       indexTag
                   withStartTime      :(NSDate *)  startTime
                   withEndTime        :(NSDate *)  endTime
{

    UIButton         *_actualLessonButton   = (UIButton *)[cell viewWithTag:indexTag];
    _actualLessonButton.hidden = YES;
    
    NSString *_startTimeString = [[_dateFormatter _timeFormatter] stringFromDate:startTime];
    NSString *_endTimeString   = [[_dateFormatter _timeFormatter] stringFromDate:endTime];
        
    if([self isActualDayAndTime:_actualDate
            withStartTimeString:_startTimeString
              withEndTimeString:_endTimeString])
    {
            _actualLessonButton.hidden = NO;
    }
}


- (void) setBackgroundColorOfCell:(UITableViewCell *)cell
                    withIsLecture:(BOOL)isLecture
{
    if (isLecture)
    {
        cell.contentView.backgroundColor = _zhawColor._zhawLightestBlue;
        cell.backgroundColor = cell.contentView.backgroundColor;
    }
    else
    {
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = cell.contentView.backgroundColor;
    }
}


- (UITableViewCell *)cellErrorMessage
    :(UITableView      *)actualTableView
    :(NSUInteger        )actualSelection
    :(NSString         *)errorMessage
{
    static NSString *_cellIdentifier = @"ErrorMessageCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"ErrorMessageCell" owner:self options:nil];
        _cell = _errorMessageCell;
        self._errorMessageCell = nil;
    }

    UILabel          *_messageLabel     = (UILabel  *)[_cell viewWithTag:1];
    
    if (actualSelection == 0)
    {
        _messageLabel.text = [_translator getGermanErrorMessageTranslation:errorMessage];
    }
    else
    {
        _messageLabel.text = [NSString stringWithFormat:@""];
    }
    [self setBackgroundColorOfCell:_cell
                     withIsLecture:NO
    ];
    return _cell;
}


- (UITableViewCell *)emptyCellOrHoliday
    :(UITableView      *)actualTableView
    :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"EmptyTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"EmptyTableCell" owner:self options:nil];
        _cell = _emptyTableCell;
        self._emptyTableCell = nil;
    }

    UILabel          *_labelDate            = (UILabel  *)[_cell viewWithTag:1];
    UIButton         *_lectureButton        = (UIButton *)[_cell viewWithTag:2];
    UIButton         *_actualLessonButton   = (UIButton *)[_cell viewWithTag:3];
    NSDate           *_startTime;
    NSDate           *_endTime;
    
    // initially always disable detail button
    _lectureButton.enabled = FALSE;
    _actualLessonButton.hidden = YES;
    
    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    
    if (actualScheduleEvent == nil)
    {
        _labelDate.text = [NSString stringWithFormat:@"xxx - xxx"];
        NSLog(@"return xxx because actualScheduleEvent is nil");
    }
    else
    {
        
       // NSLog(@"actualScheduleEvent._type: %@", actualScheduleEvent._type);
        //NSLog(@"actualScheduleEvent._name: %@", actualScheduleEvent._name);

        // exception: holiday and therefore no scheduleEvents on this day
        if ([actualScheduleEvent._type  isEqualToString:@"Holiday"])
        {
            [_lectureButton    setTitle:actualScheduleEvent._name  forState:UIControlStateNormal];
            _labelDate.text = [NSString stringWithFormat:@""];
            _startTime  = [[_dateFormatter _timeFormatter] dateFromString:@"08:00"];
            _endTime    = [[_dateFormatter _timeFormatter] dateFromString:@"08:45"];
        }
        else
        {
           [_lectureButton  setTitle:@"" forState:UIControlStateNormal];
            _startTime  = actualScheduleEvent._startTime;
            _endTime    = actualScheduleEvent._endTime;
            NSString *_startTimeString = [[_dateFormatter _timeFormatter] stringFromDate:_startTime];
            NSString *_endTimeString   = [[_dateFormatter _timeFormatter] stringFromDate:_endTime];
            
            _labelDate.text = [NSString stringWithFormat:@"%@ - %@",
                               _startTimeString,
                               _endTimeString
                               ];
            
            if([self isActualDayAndTime:_actualDate
                    withStartTimeString:_startTimeString
                      withEndTimeString:_endTimeString])
            {
                _actualLessonButton.hidden = NO;
                //_labelDate.backgroundColor = _zhawColor._zhawRed;
            }
            else
            {
                _actualLessonButton.hidden = YES;
            }
        }
    }
    
    [self setBackgroundColorOfCell:_cell
                     withIsLecture:NO
     ];
    return _cell;
}



- (UITableViewCell *)oneSlotOneRoomWithView:(UITableView *)actualTableView
    withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"OneSlotOneRoomTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"OneSlotOneRoomTableCell" owner:self options:nil];
        _cell = _oneSlotOneRoomTableCell;
        self._oneSlotOneRoomTableCell = nil;
    }

    ScheduleEventRealizationDto *_localRealization = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    
    [self setDateLabelWithCell:_cell
                       withTag:1
                 withStartTime:actualScheduleEvent._startTime
                   withEndTime:actualScheduleEvent._endTime
     ];
    
    [self setLectureButtonWithCell:_cell withTag:2 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:3 withTitle:_localRealization._room._name withSelector:1];    

    [self setDetailButtonWithCell:_cell withTag:4];

    [self  setActualLectureButtonWithCell:_cell
                      withTag            :5
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}



- (UITableViewCell *)twoSlotsOneRoomWithView:(UITableView *)actualTableView
                            withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"TwoSlotsOneRoomTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];

    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"TwoSlotsOneRoomTableCell" owner:self options:nil];
        _cell = _twoSlotsOneRoomTableCell;
        self._twoSlotsOneRoomTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];

    [self setLectureButtonWithCell:_cell withTag:3 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:4 withTitle:_localRealization._room._name withSelector:1];
    
    [self setDetailButtonWithCell:_cell withTag:5];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :6
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}


- (UITableViewCell *)threeSlotsOneRoomWithView:(UITableView *)actualTableView
                                withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"ThreeSlotsOneRoomTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"ThreeSlotsOneRoomTableCell" owner:self options:nil];
        _cell = _threeSlotsOneRoomTableCell;
        self._threeSlotsOneRoomTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];
    [self setDateLabelWithCell:_cell withTag:3 withStartTime:_timeSlot3._startTime withEndTime:_timeSlot3._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:4 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:5 withTitle:_localRealization._room._name withSelector:1];
    
    [self setDetailButtonWithCell:_cell withTag:6];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :7
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;        
}


- (UITableViewCell *)oneSlotTwoRoomsWithView:(UITableView *)actualTableView
                                            withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"OneSlotTwoRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"OneSlotTwoRoomsTableCell" owner:self options:nil];
        _cell = _oneSlotTwoRoomsTableCell;
        self._oneSlotTwoRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:2 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:3 withTitle:_localRealization1._room._name withSelector:1];

    [self setRoomButtonWithCell:_cell withTag:4 withTitle:_localRealization2._room._name withSelector:2];
    
    [self setDetailButtonWithCell:_cell withTag:5];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :6
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}


- (UITableViewCell *)twoSlotsTwoRoomsWithView           :(UITableView *)     actualTableView
                                    withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"TwoSlotsTwoRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"TwoSlotsTwoRoomsTableCell" owner:self options:nil];
        _cell = _twoSlotsTwoRoomsTableCell;
        self._twoSlotsTwoRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:3 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:4 withTitle:_localRealization1._room._name withSelector:1];
    
    [self setRoomButtonWithCell:_cell withTag:5 withTitle:_localRealization2._room._name withSelector:2];
    
    [self setDetailButtonWithCell:_cell withTag:6];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :7
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}




- (UITableViewCell *)oneSlotThreeRoomsWithView:(UITableView *)actualTableView
                                        withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"OneSlotThreeRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];

    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"OneSlotThreeRoomsTableCell" owner:self options:nil];
        _cell = _oneSlotThreeRoomsTableCell;
        self._oneSlotThreeRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];    
     
    [self setLectureButtonWithCell:_cell withTag:2 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:3 withTitle:_localRealization1._room._name withSelector:1];
    [self setRoomButtonWithCell:_cell withTag:4 withTitle:_localRealization2._room._name withSelector:2];
    [self setRoomButtonWithCell:_cell withTag:5 withTitle:_localRealization3._room._name withSelector:3];
    
    [self setDetailButtonWithCell:_cell withTag:6];

    [self  setActualLectureButtonWithCell:_cell
                      withTag            :7
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}



- (UITableViewCell *)oneSlotFourRoomsWithView:(UITableView *)actualTableView
                                    withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"OneSlotFourRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"OneSlotFourRoomsTableCell" owner:self options:nil];
        _cell = _oneSlotFourRoomsTableCell;
        self._oneSlotFourRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    ScheduleEventRealizationDto *_localRealization4 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:3];
    SlotDto *_timeSlot = [actualScheduleEvent._slots objectAtIndex:0];    
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot._startTime withEndTime:_timeSlot._endTime];        
    
    [self setLectureButtonWithCell:_cell withTag:2 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:3 withTitle:_localRealization1._room._name withSelector:1];
    [self setRoomButtonWithCell:_cell withTag:4 withTitle:_localRealization2._room._name withSelector:2];
    [self setRoomButtonWithCell:_cell withTag:5 withTitle:_localRealization3._room._name withSelector:3];
    [self setRoomButtonWithCell:_cell withTag:6 withTitle:_localRealization4._room._name withSelector:4];
    
    [self setDetailButtonWithCell:_cell withTag:7];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :8
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}




- (UITableViewCell *)oneSlotFiveRoomsWithView       :(UITableView *)     actualTableView
                                withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"OneSlotFiveRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"OneSlotFiveRoomsTableCell" owner:self options:nil];
        _cell = _oneSlotFiveRoomsTableCell;
        self._oneSlotFiveRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    ScheduleEventRealizationDto *_localRealization4 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:3];
    ScheduleEventRealizationDto *_localRealization5 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:4];
    SlotDto *_timeSlot = [actualScheduleEvent._slots objectAtIndex:0];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot._startTime withEndTime:_timeSlot._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:2 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:3 withTitle:_localRealization1._room._name withSelector:1];
    [self setRoomButtonWithCell:_cell withTag:4 withTitle:_localRealization2._room._name withSelector:2];
    [self setRoomButtonWithCell:_cell withTag:5 withTitle:_localRealization3._room._name withSelector:3];
    [self setRoomButtonWithCell:_cell withTag:6 withTitle:_localRealization4._room._name withSelector:4];
    [self setRoomButtonWithCell:_cell withTag:7 withTitle:_localRealization5._room._name withSelector:5];
    
    [self setDetailButtonWithCell:_cell withTag:8 ];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :9
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}



- (UITableViewCell *)oneSlotSixRoomsWithView            :(UITableView *)     actualTableView
                                    withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"OneSlotSixRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"OneSlotSixRoomsTableCell" owner:self options:nil];
        _cell = _oneSlotSixRoomsTableCell;
        self._oneSlotSixRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    ScheduleEventRealizationDto *_localRealization4 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:3];
    ScheduleEventRealizationDto *_localRealization5 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:4];
    ScheduleEventRealizationDto *_localRealization6 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:5];
    SlotDto *_timeSlot = [actualScheduleEvent._slots objectAtIndex:0];

    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot._startTime withEndTime:_timeSlot._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:2 withTitle:actualScheduleEvent._name doEnable:TRUE];

    [self setRoomButtonWithCell:_cell withTag:3 withTitle:_localRealization1._room._name withSelector:1];
    [self setRoomButtonWithCell:_cell withTag:4 withTitle:_localRealization2._room._name withSelector:2];
    [self setRoomButtonWithCell:_cell withTag:5 withTitle:_localRealization3._room._name withSelector:3];
    [self setRoomButtonWithCell:_cell withTag:6 withTitle:_localRealization4._room._name withSelector:4];
    [self setRoomButtonWithCell:_cell withTag:7 withTitle:_localRealization5._room._name withSelector:5];
    [self setRoomButtonWithCell:_cell withTag:8 withTitle:_localRealization6._room._name withSelector:6];
    
    [self setDetailButtonWithCell:_cell withTag:9];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :10
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}



- (UITableViewCell *)twoSlotsThreeRoomsWithView           :(UITableView *)     actualTableView
                                     withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"TwoSlotsThreeRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"TwoSlotsThreeRoomsTableCell" owner:self options:nil];
        _cell = _twoSlotsThreeRoomsTableCell;
        self._twoSlotsThreeRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:3 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:4 withTitle:_localRealization1._room._name withSelector:1];
    [self setRoomButtonWithCell:_cell withTag:5 withTitle:_localRealization2._room._name withSelector:2];
    [self setRoomButtonWithCell:_cell withTag:6 withTitle:_localRealization3._room._name withSelector:3];
    
    [self setDetailButtonWithCell:_cell withTag:7];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :8
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}



- (UITableViewCell *)twoSlotsFourRoomsWithView           :(UITableView *)     actualTableView
                                     withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"TwoSlotsFourRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"TwoSlotsFourRoomsTableCell" owner:self options:nil];
        _cell = _twoSlotsFourRoomsTableCell;
        self._twoSlotsFourRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    ScheduleEventRealizationDto *_localRealization4 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:3];
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:3 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:4 withTitle:_localRealization1._room._name withSelector:1];
    [self setRoomButtonWithCell:_cell withTag:5 withTitle:_localRealization2._room._name withSelector:2];
    [self setRoomButtonWithCell:_cell withTag:6 withTitle:_localRealization3._room._name withSelector:3];
    [self setRoomButtonWithCell:_cell withTag:7 withTitle:_localRealization4._room._name withSelector:4];
    
    [self setDetailButtonWithCell:_cell withTag:8];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :9
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}


- (UITableViewCell *)twoSlotsSixRoomsWithView            :(UITableView *)     actualTableView
                                    withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"TwoSlotSixRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"TwoSlotSixRoomsTableCell" owner:self options:nil];
        _cell = _twoSlotsSixRoomsTableCell;
        self._twoSlotsSixRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    ScheduleEventRealizationDto *_localRealization4 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:3];
    ScheduleEventRealizationDto *_localRealization5 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:4];
    ScheduleEventRealizationDto *_localRealization6 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:5];
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:3 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:4 withTitle:_localRealization1._room._name withSelector:1];
    [self setRoomButtonWithCell:_cell withTag:5 withTitle:_localRealization2._room._name withSelector:2];
    [self setRoomButtonWithCell:_cell withTag:6 withTitle:_localRealization3._room._name withSelector:3];
    [self setRoomButtonWithCell:_cell withTag:7 withTitle:_localRealization4._room._name withSelector:4];
    [self setRoomButtonWithCell:_cell withTag:8 withTitle:_localRealization5._room._name withSelector:5];
    [self setRoomButtonWithCell:_cell withTag:9 withTitle:_localRealization6._room._name withSelector:6];
    
    [self setDetailButtonWithCell:_cell withTag:10];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :11
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}



- (UITableViewCell *)oneSlotSevenRoomsWithView  :(UITableView *)     actualTableView
                            withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"OneSlotSevenRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"OneSlotSevenRoomsTableCell" owner:self options:nil];
        _cell = _oneSlotSevenRoomsTableCell;
        self._oneSlotSevenRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    ScheduleEventRealizationDto *_localRealization4 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:3];
    ScheduleEventRealizationDto *_localRealization5 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:4];
    ScheduleEventRealizationDto *_localRealization6 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:5];
    ScheduleEventRealizationDto *_localRealization7 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:6];
    SlotDto *_timeSlot = [actualScheduleEvent._slots objectAtIndex:0];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot._startTime withEndTime:_timeSlot._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:2 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:3 withTitle:_localRealization1._room._name withSelector:1];
    [self setRoomButtonWithCell:_cell withTag:4 withTitle:_localRealization2._room._name withSelector:2];
    [self setRoomButtonWithCell:_cell withTag:5 withTitle:_localRealization3._room._name withSelector:3];
    [self setRoomButtonWithCell:_cell withTag:6 withTitle:_localRealization4._room._name withSelector:4];
    [self setRoomButtonWithCell:_cell withTag:7 withTitle:_localRealization5._room._name withSelector:5];
    [self setRoomButtonWithCell:_cell withTag:8 withTitle:_localRealization6._room._name withSelector:6];
    [self setRoomButtonWithCell:_cell withTag:9 withTitle:_localRealization7._room._name withSelector:7];
    
    [self setDetailButtonWithCell:_cell withTag:10];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :11
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}



- (UITableViewCell *)oneSlotEightRoomsWithView      :(UITableView *)     actualTableView
                                withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"OneSlotEightRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"OneSlotEightRoomsTableCell" owner:self options:nil];
        _cell = _oneSlotEightRoomsTableCell;
        self._oneSlotEightRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    ScheduleEventRealizationDto *_localRealization4 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:3];
    ScheduleEventRealizationDto *_localRealization5 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:4];
    ScheduleEventRealizationDto *_localRealization6 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:5];
    ScheduleEventRealizationDto *_localRealization7 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:6];
    ScheduleEventRealizationDto *_localRealization8 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:7];
    SlotDto *_timeSlot = [actualScheduleEvent._slots objectAtIndex:0];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot._startTime withEndTime:_timeSlot._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:2 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:3 withTitle:_localRealization1._room._name withSelector:1];
    [self setRoomButtonWithCell:_cell withTag:4 withTitle:_localRealization2._room._name withSelector:2];
    [self setRoomButtonWithCell:_cell withTag:5 withTitle:_localRealization3._room._name withSelector:3];
    [self setRoomButtonWithCell:_cell withTag:6 withTitle:_localRealization4._room._name withSelector:4];
    [self setRoomButtonWithCell:_cell withTag:7 withTitle:_localRealization5._room._name withSelector:5];
    [self setRoomButtonWithCell:_cell withTag:8 withTitle:_localRealization6._room._name withSelector:6];
    [self setRoomButtonWithCell:_cell withTag:9 withTitle:_localRealization7._room._name withSelector:7];
    [self setRoomButtonWithCell:_cell withTag:10 withTitle:_localRealization8._room._name withSelector:8];
    
    [self setDetailButtonWithCell:_cell withTag:11];
        
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :12
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}

- (UITableViewCell *)threeSlotsTwoRoomsWithView     :(UITableView *)     actualTableView
                                withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"ThreeSlotsTwoRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"ThreeSlotsTwoRoomsTableCell" owner:self options:nil];
        _cell = _threeSlotsTwoRoomsTableCell;
        self._threeSlotsTwoRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];
    [self setDateLabelWithCell:_cell withTag:3 withStartTime:_timeSlot3._startTime withEndTime:_timeSlot3._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:4 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:5 withTitle:_localRealization1._room._name withSelector:1];
    [self setRoomButtonWithCell:_cell withTag:6 withTitle:_localRealization2._room._name withSelector:2];
    
    [self setDetailButtonWithCell:_cell withTag:7];
        
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :8
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}




- (UITableViewCell *)fourSlotsOneRoomWithView       :(UITableView *)actualTableView
                                withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"FourSlotsOneRoomTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"FourSlotsOneRoomTableCell" owner:self options:nil];
        _cell = _fourSlotsOneRoomTableCell;
        self._fourSlotsOneRoomTableCell = nil;
    }
    
    // setting the labels with infos
    // 1 => _labelTimeSlot1 -> first  timeslot
    // 2 => _labelTimeSlot2 -> second timeslot
    // 3 => _lectureButton  -> lecture title
    // 4 => _roomButton     -> short room
    // 5 => _detailButton   -> leads to detail page
    
    ScheduleEventRealizationDto *_localRealization = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    SlotDto *_timeSlot4 = [actualScheduleEvent._slots objectAtIndex:3];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];
    [self setDateLabelWithCell:_cell withTag:3 withStartTime:_timeSlot3._startTime withEndTime:_timeSlot3._endTime];
    [self setDateLabelWithCell:_cell withTag:4 withStartTime:_timeSlot4._startTime withEndTime:_timeSlot4._endTime];

    [self setLectureButtonWithCell:_cell withTag:5 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:6 withTitle:_localRealization._room._name withSelector:1];
    
    [self setDetailButtonWithCell:_cell withTag:7];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :8
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}



- (UITableViewCell *)fiveSlotsOneRoomWithView       :(UITableView *)     actualTableView
                                withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"FiveSlotsOneRoomTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"FiveSlotsOneRoomTableCell" owner:self options:nil];
        _cell = _fiveSlotsOneRoomTableCell; 
        self._fiveSlotsOneRoomTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    SlotDto *_timeSlot4 = [actualScheduleEvent._slots objectAtIndex:3];
    SlotDto *_timeSlot5 = [actualScheduleEvent._slots objectAtIndex:4];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];
    [self setDateLabelWithCell:_cell withTag:3 withStartTime:_timeSlot3._startTime withEndTime:_timeSlot3._endTime];
    [self setDateLabelWithCell:_cell withTag:4 withStartTime:_timeSlot4._startTime withEndTime:_timeSlot4._endTime];
    [self setDateLabelWithCell:_cell withTag:5 withStartTime:_timeSlot5._startTime withEndTime:_timeSlot5._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:6 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:7 withTitle:_localRealization._room._name withSelector:1];
    
    [self setDetailButtonWithCell:_cell withTag:8];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :9
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}


- (UITableViewCell *)sixSlotsOneRoomWithView        :(UITableView *)     actualTableView
                                withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"SixSlotsOneRoomTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"SixSlotsOneRoomTableCell" owner:self options:nil];
        _cell = _sixSlotsOneRoomTableCell;
        self._sixSlotsOneRoomTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    SlotDto *_timeSlot4 = [actualScheduleEvent._slots objectAtIndex:3];
    SlotDto *_timeSlot5 = [actualScheduleEvent._slots objectAtIndex:4];
    SlotDto *_timeSlot6 = [actualScheduleEvent._slots objectAtIndex:5];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];
    [self setDateLabelWithCell:_cell withTag:3 withStartTime:_timeSlot3._startTime withEndTime:_timeSlot3._endTime];
    [self setDateLabelWithCell:_cell withTag:4 withStartTime:_timeSlot4._startTime withEndTime:_timeSlot4._endTime];
    [self setDateLabelWithCell:_cell withTag:5 withStartTime:_timeSlot5._startTime withEndTime:_timeSlot5._endTime];
    [self setDateLabelWithCell:_cell withTag:6 withStartTime:_timeSlot6._startTime withEndTime:_timeSlot6._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:7 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:8 withTitle:_localRealization1._room._name withSelector:1];
    
    [self setDetailButtonWithCell:_cell withTag:9];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :10
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}



- (UITableViewCell *)sixSlotsTwoRoomsWithView       :(UITableView *)     actualTableView
                                withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"SixSlotsTwoRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"SixSlotsTwoRoomsTableCell" owner:self options:nil];
        _cell = _sixSlotsTwoRoomsTableCell;
        self._sixSlotsTwoRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];

    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    SlotDto *_timeSlot4 = [actualScheduleEvent._slots objectAtIndex:3];
    SlotDto *_timeSlot5 = [actualScheduleEvent._slots objectAtIndex:4];
    SlotDto *_timeSlot6 = [actualScheduleEvent._slots objectAtIndex:5];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];
    [self setDateLabelWithCell:_cell withTag:3 withStartTime:_timeSlot3._startTime withEndTime:_timeSlot3._endTime];
    [self setDateLabelWithCell:_cell withTag:4 withStartTime:_timeSlot4._startTime withEndTime:_timeSlot4._endTime];
    [self setDateLabelWithCell:_cell withTag:5 withStartTime:_timeSlot5._startTime withEndTime:_timeSlot5._endTime];
    [self setDateLabelWithCell:_cell withTag:6 withStartTime:_timeSlot6._startTime withEndTime:_timeSlot6._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:7 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:8 withTitle:_localRealization1._room._name withSelector:1];
    [self setRoomButtonWithCell:_cell withTag:9 withTitle:_localRealization2._room._name withSelector:2];
    
    [self setDetailButtonWithCell:_cell withTag:10];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :11
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}


- (UITableViewCell *)fourSlotsTwoRoomsWithView      :(UITableView *)     actualTableView
                                withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"FourSlotsTwoRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"FourSlotsTwoRoomsTableCell" owner:self options:nil];
        _cell = _fourSlotsTwoRoomsTableCell; 
        self._fourSlotsTwoRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    SlotDto *_timeSlot4 = [actualScheduleEvent._slots objectAtIndex:3];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];
    [self setDateLabelWithCell:_cell withTag:3 withStartTime:_timeSlot3._startTime withEndTime:_timeSlot3._endTime];
    [self setDateLabelWithCell:_cell withTag:4 withStartTime:_timeSlot4._startTime withEndTime:_timeSlot4._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:5 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:6 withTitle:_localRealization1._room._name withSelector:1];
    [self setRoomButtonWithCell:_cell withTag:7 withTitle:_localRealization2._room._name withSelector:2];

    [self setDetailButtonWithCell:_cell withTag:8];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :9
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}


- (UITableViewCell *)threeSlotsThreeRoomsWithView       :(UITableView *)     actualTableView
                           withScheduleEvent            :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"ThreeSlotsThreeRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"ThreeSlotsThreeRoomsTableCell" owner:self options:nil];
        _cell = _threeSlotsThreeRoomsTableCell;
        self._threeSlotsThreeRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];
    [self setDateLabelWithCell:_cell withTag:3 withStartTime:_timeSlot3._startTime withEndTime:_timeSlot3._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:4 withTitle:actualScheduleEvent._name doEnable:TRUE];

    [self setRoomButtonWithCell:_cell withTag:5 withTitle:_localRealization1._room._name withSelector:1];
    [self setRoomButtonWithCell:_cell withTag:6 withTitle:_localRealization2._room._name withSelector:2];
    [self setRoomButtonWithCell:_cell withTag:7 withTitle:_localRealization3._room._name withSelector:3];
    
    [self setDetailButtonWithCell:_cell withTag:8];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :9
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}



- (UITableViewCell *)fourSlotsThreeRoomsWithView      :(UITableView *)     actualTableView
                                  withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"FourSlotsThreeRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"FourSlotsThreeRoomsTableCell" owner:self options:nil];
        _cell = _fourSlotsThreeRoomsTableCell; 
        self._fourSlotsThreeRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    SlotDto *_timeSlot4 = [actualScheduleEvent._slots objectAtIndex:3];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];
    [self setDateLabelWithCell:_cell withTag:3 withStartTime:_timeSlot3._startTime withEndTime:_timeSlot3._endTime];
    [self setDateLabelWithCell:_cell withTag:4 withStartTime:_timeSlot4._startTime withEndTime:_timeSlot4._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:5 withTitle:actualScheduleEvent._name doEnable:TRUE];

    [self setRoomButtonWithCell:_cell withTag:6 withTitle:_localRealization1._room._name withSelector:1];
    [self setRoomButtonWithCell:_cell withTag:7 withTitle:_localRealization2._room._name withSelector:2];
    [self setRoomButtonWithCell:_cell withTag:8 withTitle:_localRealization3._room._name withSelector:3];
    
    [self setDetailButtonWithCell:_cell withTag:9];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :10
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}


- (UITableViewCell *)fourSlotsFourRoomsWithView       :(UITableView *)     actualTableView
                                  withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"FourSlotsFourRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"FourSlotsFourRoomsTableCell" owner:self options:nil];
        _cell = _fourSlotsFourRoomsTableCell;
        self._fourSlotsFourRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    ScheduleEventRealizationDto *_localRealization4 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:3];
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    SlotDto *_timeSlot4 = [actualScheduleEvent._slots objectAtIndex:3];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];
    [self setDateLabelWithCell:_cell withTag:3 withStartTime:_timeSlot3._startTime withEndTime:_timeSlot3._endTime];
    [self setDateLabelWithCell:_cell withTag:4 withStartTime:_timeSlot4._startTime withEndTime:_timeSlot4._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:5 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:6 withTitle:_localRealization1._room._name withSelector:1];
    [self setRoomButtonWithCell:_cell withTag:7 withTitle:_localRealization2._room._name withSelector:2];
    [self setRoomButtonWithCell:_cell withTag:8 withTitle:_localRealization3._room._name withSelector:3];
    [self setRoomButtonWithCell:_cell withTag:9 withTitle:_localRealization4._room._name withSelector:3];
    
    [self setDetailButtonWithCell:_cell withTag:10];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :11
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}



- (UITableViewCell *)fourSlotsFiveRoomsWithView     :(UITableView *)     actualTableView
                                withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"FourSlotsFiveRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"FourSlotsFiveRoomsTableCell" owner:self options:nil];
        _cell = _fourSlotsFiveRoomsTableCell;
        self._fourSlotsFiveRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    ScheduleEventRealizationDto *_localRealization4 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:3];
    ScheduleEventRealizationDto *_localRealization5 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:4];
    
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    SlotDto *_timeSlot4 = [actualScheduleEvent._slots objectAtIndex:3];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];
    [self setDateLabelWithCell:_cell withTag:3 withStartTime:_timeSlot3._startTime withEndTime:_timeSlot3._endTime];
    [self setDateLabelWithCell:_cell withTag:4 withStartTime:_timeSlot4._startTime withEndTime:_timeSlot4._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:5 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:6 withTitle:_localRealization1._room._name withSelector:1];
    [self setRoomButtonWithCell:_cell withTag:7 withTitle:_localRealization2._room._name withSelector:2];
    [self setRoomButtonWithCell:_cell withTag:8 withTitle:_localRealization3._room._name withSelector:3];
    [self setRoomButtonWithCell:_cell withTag:9 withTitle:_localRealization4._room._name withSelector:4];
    [self setRoomButtonWithCell:_cell withTag:10 withTitle:_localRealization5._room._name withSelector:5];
    
    [self setDetailButtonWithCell:_cell withTag:11];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :12
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}


- (UITableViewCell *)sevenSlotsOneRoomWithView      :(UITableView *)     actualTableView
                                 withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"SevenSlotsOneRoomTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"SevenSlotsOneRoomTableCell" owner:self options:nil];
        _cell = _sevenSlotsOneRoomTableCell;
        self._sevenSlotsOneRoomTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    SlotDto *_timeSlot4 = [actualScheduleEvent._slots objectAtIndex:3];
    SlotDto *_timeSlot5 = [actualScheduleEvent._slots objectAtIndex:4];
    SlotDto *_timeSlot6 = [actualScheduleEvent._slots objectAtIndex:5];
    SlotDto *_timeSlot7 = [actualScheduleEvent._slots objectAtIndex:6];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];
    [self setDateLabelWithCell:_cell withTag:3 withStartTime:_timeSlot3._startTime withEndTime:_timeSlot3._endTime];
    [self setDateLabelWithCell:_cell withTag:4 withStartTime:_timeSlot4._startTime withEndTime:_timeSlot4._endTime];
    [self setDateLabelWithCell:_cell withTag:5 withStartTime:_timeSlot5._startTime withEndTime:_timeSlot5._endTime];
    [self setDateLabelWithCell:_cell withTag:6 withStartTime:_timeSlot6._startTime withEndTime:_timeSlot6._endTime];
    [self setDateLabelWithCell:_cell withTag:7 withStartTime:_timeSlot7._startTime withEndTime:_timeSlot7._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:8 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:9 withTitle:_localRealization._room._name withSelector:1];
    
    [self setDetailButtonWithCell:_cell withTag:10];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :11
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}


- (UITableViewCell *)sevenSlotsEightRoomsWithView   :(UITableView *)     actualTableView
                                withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"SevenSlotsEightRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"SevenSlotsEightRoomsTableCell" owner:self options:nil];
        _cell = _sevenSlotsEightRoomsTableCell;
        self._sevenSlotsEightRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    ScheduleEventRealizationDto *_localRealization4 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:3];
    ScheduleEventRealizationDto *_localRealization5 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:4];
    ScheduleEventRealizationDto *_localRealization6 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:5];
    ScheduleEventRealizationDto *_localRealization7 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:6];
    ScheduleEventRealizationDto *_localRealization8 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:7];
    
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    SlotDto *_timeSlot4 = [actualScheduleEvent._slots objectAtIndex:3];
    SlotDto *_timeSlot5 = [actualScheduleEvent._slots objectAtIndex:4];
    SlotDto *_timeSlot6 = [actualScheduleEvent._slots objectAtIndex:5];
    SlotDto *_timeSlot7 = [actualScheduleEvent._slots objectAtIndex:6];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];
    [self setDateLabelWithCell:_cell withTag:3 withStartTime:_timeSlot3._startTime withEndTime:_timeSlot3._endTime];
    [self setDateLabelWithCell:_cell withTag:4 withStartTime:_timeSlot4._startTime withEndTime:_timeSlot4._endTime];
    [self setDateLabelWithCell:_cell withTag:5 withStartTime:_timeSlot5._startTime withEndTime:_timeSlot5._endTime];
    [self setDateLabelWithCell:_cell withTag:6 withStartTime:_timeSlot6._startTime withEndTime:_timeSlot6._endTime];
    [self setDateLabelWithCell:_cell withTag:7 withStartTime:_timeSlot7._startTime withEndTime:_timeSlot7._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:8 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:9 withTitle:_localRealization1._room._name withSelector:1];
    [self setRoomButtonWithCell:_cell withTag:10 withTitle:_localRealization2._room._name withSelector:2];
    [self setRoomButtonWithCell:_cell withTag:11 withTitle:_localRealization3._room._name withSelector:3];
    [self setRoomButtonWithCell:_cell withTag:12 withTitle:_localRealization4._room._name withSelector:4];
    [self setRoomButtonWithCell:_cell withTag:13 withTitle:_localRealization5._room._name withSelector:5];
    [self setRoomButtonWithCell:_cell withTag:14 withTitle:_localRealization6._room._name withSelector:6];
    [self setRoomButtonWithCell:_cell withTag:15 withTitle:_localRealization7._room._name withSelector:7];
    [self setRoomButtonWithCell:_cell withTag:16 withTitle:_localRealization8._room._name withSelector:8];
    
    [self setDetailButtonWithCell:_cell withTag:17];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :18
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}


- (UITableViewCell *)eightSlotsOneRoomWithView      :(UITableView *)     actualTableView
                                withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"EightSlotsOneRoomTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"EightSlotsOneRoomTableCell" owner:self options:nil];
        _cell = _eightSlotsOneRoomTableCell;
        self._eightSlotsOneRoomTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    SlotDto *_timeSlot4 = [actualScheduleEvent._slots objectAtIndex:3];
    SlotDto *_timeSlot5 = [actualScheduleEvent._slots objectAtIndex:4];
    SlotDto *_timeSlot6 = [actualScheduleEvent._slots objectAtIndex:5];
    SlotDto *_timeSlot7 = [actualScheduleEvent._slots objectAtIndex:6];
    SlotDto *_timeSlot8 = [actualScheduleEvent._slots objectAtIndex:7];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];
    [self setDateLabelWithCell:_cell withTag:3 withStartTime:_timeSlot3._startTime withEndTime:_timeSlot3._endTime];
    [self setDateLabelWithCell:_cell withTag:4 withStartTime:_timeSlot4._startTime withEndTime:_timeSlot4._endTime];
    [self setDateLabelWithCell:_cell withTag:5 withStartTime:_timeSlot5._startTime withEndTime:_timeSlot5._endTime];
    [self setDateLabelWithCell:_cell withTag:6 withStartTime:_timeSlot6._startTime withEndTime:_timeSlot6._endTime];
    [self setDateLabelWithCell:_cell withTag:7 withStartTime:_timeSlot7._startTime withEndTime:_timeSlot7._endTime];
    [self setDateLabelWithCell:_cell withTag:8 withStartTime:_timeSlot8._startTime withEndTime:_timeSlot8._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:9 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:10 withTitle:_localRealization._room._name withSelector:1];
    
    [self setDetailButtonWithCell:_cell withTag:11];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :12
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}

- (UITableViewCell *)nineSlotsThreeRoomsWithView    :(UITableView *)     actualTableView
                                withScheduleEvent   :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"NineSlotsThreeRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"NineSlotsThreeRoomsTableCell" owner:self options:nil];
        _cell = _nineSlotsThreeRoomsTableCell;
        self._nineSlotsThreeRoomsTableCell = nil;
    }
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    SlotDto *_timeSlot4 = [actualScheduleEvent._slots objectAtIndex:3];
    SlotDto *_timeSlot5 = [actualScheduleEvent._slots objectAtIndex:4];
    SlotDto *_timeSlot6 = [actualScheduleEvent._slots objectAtIndex:5];
    SlotDto *_timeSlot7 = [actualScheduleEvent._slots objectAtIndex:6];
    SlotDto *_timeSlot8 = [actualScheduleEvent._slots objectAtIndex:7];
    SlotDto *_timeSlot9 = [actualScheduleEvent._slots objectAtIndex:8];
    
    [self setDateLabelWithCell:_cell withTag:1 withStartTime:_timeSlot1._startTime withEndTime:_timeSlot1._endTime];
    [self setDateLabelWithCell:_cell withTag:2 withStartTime:_timeSlot2._startTime withEndTime:_timeSlot2._endTime];
    [self setDateLabelWithCell:_cell withTag:3 withStartTime:_timeSlot3._startTime withEndTime:_timeSlot3._endTime];
    [self setDateLabelWithCell:_cell withTag:4 withStartTime:_timeSlot4._startTime withEndTime:_timeSlot4._endTime];
    [self setDateLabelWithCell:_cell withTag:5 withStartTime:_timeSlot5._startTime withEndTime:_timeSlot5._endTime];
    [self setDateLabelWithCell:_cell withTag:6 withStartTime:_timeSlot6._startTime withEndTime:_timeSlot6._endTime];
    [self setDateLabelWithCell:_cell withTag:7 withStartTime:_timeSlot7._startTime withEndTime:_timeSlot7._endTime];
    [self setDateLabelWithCell:_cell withTag:8 withStartTime:_timeSlot8._startTime withEndTime:_timeSlot8._endTime];
    [self setDateLabelWithCell:_cell withTag:9 withStartTime:_timeSlot9._startTime withEndTime:_timeSlot9._endTime];
    
    [self setLectureButtonWithCell:_cell withTag:10 withTitle:actualScheduleEvent._name doEnable:TRUE];
    
    [self setRoomButtonWithCell:_cell withTag:11 withTitle:_localRealization1._room._name withSelector:1];
    [self setRoomButtonWithCell:_cell withTag:12 withTitle:_localRealization2._room._name withSelector:2];
    [self setRoomButtonWithCell:_cell withTag:13 withTitle:_localRealization3._room._name withSelector:3];
    
    [self setDetailButtonWithCell:_cell withTag:14];
    
    [self  setActualLectureButtonWithCell:_cell
                      withTag            :15
                      withStartTime      :actualScheduleEvent._startTime
                      withEndTime        :actualScheduleEvent._endTime
     ];
    
    [self setBackgroundColorOfCell:_cell withIsLecture:YES];
    return _cell;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    
    NSUInteger        _cellSelection = indexPath.section;
    ScheduleEventDto *_scheduleEvent = nil;

    if (    _schedule._type                  == nil 
        || [_schedule._type length]          == 0
        ||  _schedule._connectionEstablished == nil
        || ([_schedule._connectionEstablished compare: @"NO"] == NSOrderedSame)
        ) 
    {
        // VERY IMPORTANT, OTHERWISE, NO NEW DATA
        [self viewWillAppear:YES];
    }
    
    // ONE CELL = ONE SCHEDULE_EVENT
    // kind of cell depends on the scheduleEvent
    
    // no lectures at all
    if (_actualDayDto != nil) 
    {
        //NSLog(@"_cellSelection: %i, event count: %i", _cellSelection, [_actualDayDto._events count]);
        if ([_actualDayDto._events count] >= _cellSelection)
        {
            //_scheduleEvent = [self getScheduleEventDto:_cellSelection];
            _scheduleEvent   = [_actualDayDto._events objectAtIndex:_cellSelection];
            
            if (_scheduleEvent != nil) 
            {
                //NSLog(@"scheduleEvent IS NOT NIL");
                if (_schedule._errorMessage != nil)
                {
                    return [self cellErrorMessage:tableView:_cellSelection:_schedule._errorMessage];
                }

                // check for holidays first
                if ([_scheduleEvent._type isEqualToString:@"Holiday"])
                {
                    return [self emptyCellOrHoliday:tableView:_scheduleEvent];
                }
                
                // depending on how many rooms and time slots there are take cell
                if (   [_scheduleEvent._slots                     count] == 0
                    && [_scheduleEvent._scheduleEventRealizations count] == 0)
                {
                    //NSLog(@"slots and events are null => emptyCellOrHoliday is called");
                    return [self emptyCellOrHoliday:tableView:_scheduleEvent];
                }
                
                //NSLog(@"---- _scheduleEvent %@ _slot count %i realization count %i",
                //      _scheduleEvent._name,
                //      [_scheduleEvent._slots count],
                //      [_scheduleEvent._scheduleEventRealizations count]
                //      );
                
                //----------------------------
                // one slot, one or more rooms
                if (   [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 1)
                {
                    return [self oneSlotOneRoomWithView :tableView
                                      withScheduleEvent :_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 2
                    )
                {
                    return [self oneSlotTwoRoomsWithView:tableView
                                    withScheduleEvent   :_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 3
                    )
                {
                    return [self oneSlotThreeRoomsWithView  :tableView
                                    withScheduleEvent       :_scheduleEvent];
                }
                
                if (   [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 4)
                {
                    return [self oneSlotFourRoomsWithView   :tableView
                                        withScheduleEvent   :_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 5)
                {
                    return [self oneSlotFiveRoomsWithView   :tableView
                                           withScheduleEvent:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 6)
                {
                    return [self oneSlotSixRoomsWithView    :tableView
                                        withScheduleEvent   :_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 7)
                {
                    return [self oneSlotSevenRoomsWithView  :tableView
                                        withScheduleEvent   :_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 8)
                {
                    return [self oneSlotEightRoomsWithView  :tableView
                                    withScheduleEvent       :_scheduleEvent];
                }
                
                //----------------------------
                // two slots, one or more rooms
                if (   [_scheduleEvent._slots                     count] == 2
                    && [_scheduleEvent._scheduleEventRealizations count] == 1)
                {
                    return [self twoSlotsOneRoomWithView:tableView
                                       withScheduleEvent:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 2
                    && [_scheduleEvent._scheduleEventRealizations count] == 2
                    )
                {
                    return [self twoSlotsTwoRoomsWithView:tableView
                                    withScheduleEvent   :_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 2
                    && [_scheduleEvent._scheduleEventRealizations count] == 3
                    )
                {
                    return [self twoSlotsThreeRoomsWithView:tableView
                                     withScheduleEvent   :_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 2
                    && [_scheduleEvent._scheduleEventRealizations count] == 4)
                {
                    return [self twoSlotsFourRoomsWithView:tableView
                                       withScheduleEvent:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 2
                    && [_scheduleEvent._scheduleEventRealizations count] == 6)
                {
                    return [self twoSlotsSixRoomsWithView    :tableView
                                        withScheduleEvent   :_scheduleEvent];
                }
                
                //----------------------------
                // three slots, one or more rooms
                if (   [_scheduleEvent._slots                     count] == 3
                    && [_scheduleEvent._scheduleEventRealizations count] == 1)
                {
                    return [self threeSlotsOneRoomWithView  :tableView
                                        withScheduleEvent   :_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 3
                    && [_scheduleEvent._scheduleEventRealizations count] == 2
                    )
                {
                    return [self threeSlotsTwoRoomsWithView     :tableView
                                        withScheduleEvent       :_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 3
                    && [_scheduleEvent._scheduleEventRealizations count] == 3
                    )
                {
                    return [self threeSlotsThreeRoomsWithView     :tableView
                                          withScheduleEvent       :_scheduleEvent];
                }
                
                //----------------------------
                // four slots, one or more rooms
                if (   [_scheduleEvent._slots                     count] == 4
                    && [_scheduleEvent._scheduleEventRealizations count] == 1)
                {
                    return [self fourSlotsOneRoomWithView   :tableView
                                        withScheduleEvent   :_scheduleEvent];
                }

                if (   [_scheduleEvent._slots                     count] == 4
                    && [_scheduleEvent._scheduleEventRealizations count] == 2
                   )
                {
                    return [self fourSlotsTwoRoomsWithView   :tableView
                                         withScheduleEvent   :_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 4
                    && [_scheduleEvent._scheduleEventRealizations count] == 3
                    )
                {
                    return [self fourSlotsThreeRoomsWithView   :tableView
                                           withScheduleEvent   :_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 4
                    && [_scheduleEvent._scheduleEventRealizations count] == 4
                    )
                {
                    return [self fourSlotsFourRoomsWithView   :tableView
                                           withScheduleEvent  :_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 4
                    && [_scheduleEvent._scheduleEventRealizations count] == 5
                    )
                {
                    return [self fourSlotsFiveRoomsWithView   :tableView
                                           withScheduleEvent   :_scheduleEvent];
                }
                
                //----------------------------
                // five slots, one or more rooms
                if (   [_scheduleEvent._slots                     count] == 5
                    && [_scheduleEvent._scheduleEventRealizations count] == 1
                    )
                {
                    return [self fiveSlotsOneRoomWithView       :tableView
                                            withScheduleEvent   :_scheduleEvent];
                }
                
                //----------------------------
                // six slots, one or more rooms
                if (   [_scheduleEvent._slots                     count] == 6
                    && [_scheduleEvent._scheduleEventRealizations count] == 1
                    )
                {
                    return [self sixSlotsOneRoomWithView       :tableView
                                            withScheduleEvent   :_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 6
                    && [_scheduleEvent._scheduleEventRealizations count] == 2
                    )
                {
                    return [self sixSlotsTwoRoomsWithView       :tableView
                                            withScheduleEvent   :_scheduleEvent];
                }

                //----------------------------
                // seven slots, one or more rooms
                if (   [_scheduleEvent._slots                     count] == 7
                    && [_scheduleEvent._scheduleEventRealizations count] == 1)
                {
                    return [self sevenSlotsOneRoomWithView  :tableView
                                    withScheduleEvent       :_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 7
                    && [_scheduleEvent._scheduleEventRealizations count] == 8)
                {
                    return [self sevenSlotsEightRoomsWithView:tableView
                                    withScheduleEvent       :_scheduleEvent];
                }
                
                //----------------------------
                // eight slots, one or more rooms
                if (   [_scheduleEvent._slots                     count] == 8
                    && [_scheduleEvent._scheduleEventRealizations count] == 1)
                {
                    return [self eightSlotsOneRoomWithView  :tableView
                                    withScheduleEvent       :_scheduleEvent];
                }

                //----------------------------
                // nine slots, several rooms
                if (   [_scheduleEvent._slots                     count] == 9
                    && [_scheduleEvent._scheduleEventRealizations count] == 3)
                {
                    return [self nineSlotsThreeRoomsWithView:tableView
                                    withScheduleEvent       :_scheduleEvent];
                }
                
                //----------------------------
                // workaround for more than eight slots
                if (   [_scheduleEvent._slots                     count] > 8)
                {
                    return [self eightSlotsOneRoomWithView  :tableView
                                    withScheduleEvent       :_scheduleEvent];
                }
            }
        }
    }
    NSLog(@" NO MATCH FOUND _scheduleEvent %@ _slot count %i realization count %i",
          _scheduleEvent._name,
          [_scheduleEvent._slots count],
          [_scheduleEvent._scheduleEventRealizations count]
          );
    return [self emptyCellOrHoliday:tableView:nil];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger        _cellSelection = indexPath.section;
    ScheduleEventDto *_scheduleEvent = nil;
    
    /*
    if (    _schedule._type                  == nil 
        || [_schedule._type length]          == 0
        ||  _schedule._connectionEstablished == nil
        || ([_schedule._connectionEstablished compare: @"NO"] == NSOrderedSame)
        ) 
    {
        // VERY IMPORTANT, OTHERWISE, NO NEW DATA
        [self viewWillAppear:YES];
    }
     */
    
    // ONE CELL = ONE SCHEDULE_EVENT
    // kind of cell depending on the scheduleEvent
    
    // no lectures at all
    if (_actualDayDto != nil) 
    {
        //NSString *_dayString = [[self dayFormatter] stringFromDate:_actualDayDto._date];
        //NSLog(@"_dayString %@ with event count %i", _dayString, [_actualDayDto._events count]);
        
        if ([_actualDayDto._events count] > _cellSelection)
        {
            _scheduleEvent   = [_actualDayDto._events objectAtIndex:_cellSelection];
            
            if (_scheduleEvent != nil) 
            {  
                // depending on how many rooms and time slots there are take cell
                if (   [_scheduleEvent._slots                     count] >= 9
                    || [_scheduleEvent._scheduleEventRealizations count] >= 9
                    )
                {
                    return 315;
                }
                
                if (   [_scheduleEvent._slots                     count] == 8
                    || [_scheduleEvent._scheduleEventRealizations count] == 8
                    )
                {
                    return 280;
                }
                
                if (   [_scheduleEvent._slots                     count] == 7
                    || [_scheduleEvent._scheduleEventRealizations count] == 7
                   )
                {
                    return 245;
                }
                
                if (   [_scheduleEvent._slots                     count] == 6
                    || [_scheduleEvent._scheduleEventRealizations count] == 6
                    )
                {
                    return 210;
                }
                
                if (    [_scheduleEvent._slots                     count] == 5
                     || [_scheduleEvent._scheduleEventRealizations count] == 5
                   )                    
                {
                    return 175;
                }

                if (   [_scheduleEvent._slots                     count] == 4
                    || [_scheduleEvent._scheduleEventRealizations count] == 4
                    || _schedule._errorMessage != nil
                   )
                {
                  return 140;
                }
            
                if (    [_scheduleEvent._slots                     count] == 3
                     || [_scheduleEvent._scheduleEventRealizations count] == 3
                   )
                {
                    return 104;
                }
                
                if (   [_scheduleEvent._slots                     count] == 2
                    || [_scheduleEvent._scheduleEventRealizations count] == 2
                   )
                {
                    return 70;
                }
    
                if (   [_scheduleEvent._slots                     count] == 1
                    || [_scheduleEvent._scheduleEventRealizations count] == 1)
                {
                    return 44;
                }

            }
        }
    }
    
    //NSLog(@"found no match for cell size slot count: %i event count: %i", [_scheduleEvent._slots count], [_scheduleEvent._scheduleEventRealizations count]);
    return 44;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"didSelectRowAtIndexPath");
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}


@end
