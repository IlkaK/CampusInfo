//
//  TimeTableOverviewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TimeTableOverviewController.h"
#import "AcronymViewController.h"
#import "ScheduleDto.h"
#import "TimeTableDetailController.h"
#import "ScheduleEventDto.h"
#import "SlotDto.h"
#import "DayDto.h"
#import "SchoolClassDto.h"
#import "RoomDto.h"
#import "PersonDto.h"
#import "ScheduleEventRealizationDto.h"


@implementation TimeTableOverviewController

@synthesize _timeTable;
@synthesize _actualDate;
@synthesize _schedule;
@synthesize _actualDayDto; 
@synthesize _acronymVC;
@synthesize _dayNavigator;
@synthesize _detailsVC;

@synthesize _ownStoredAcronymLabel;
@synthesize _acronymLabel;

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

@synthesize _threeSlotsOneRoomTableCell;
@synthesize _threeSlotsTwoRoomsTableCell;
@synthesize _threeSlotsThreeRoomsTableCell;

@synthesize _fourSlotsOneRoomTableCell;
@synthesize _fourSlotsTwoRoomsTableCell;
@synthesize _fourSlotsThreeRoomsTableCell;

@synthesize _fiveSlotsOneRoomTableCell;

@synthesize _eightSlotsOneRoomTableCell;

@synthesize _noConnectionButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{   
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}


- (void)dealloc
{
    [_timeTable                release];
    [_actualDate               release];
    [_schedule                 release];
    [_dayNavigator             release];
    [_acronymLabel             release];
    [_detailsVC                release];
    [_actualDayDto             release];
    
    [_ownStoredAcronymString   release];
    [_ownStoredAcronymType     release];
    [_actualShownAcronymString release];
    [_actualShownAcronymType   release];
    
    [_oneSlotOneRoomTableCell    release];
    [_oneSlotTwoRoomsTableCell   release];
    [_oneSlotThreeRoomsTableCell release];
    [_oneSlotFourRoomsTableCell  release];
    [_oneSlotFiveRoomsTableCell  release];
    [_oneSlotSixRoomsTableCell   release];
    [_oneSlotSevenRoomsTableCell release];
    [_oneSlotEightRoomsTableCell release];
    
    [_twoSlotsOneRoomTableCell   release];
    [_twoSlotsTwoRoomsTableCell  release];
    
    [_threeSlotsOneRoomTableCell release];
    [_threeSlotsTwoRoomsTableCell release];
    [_threeSlotsThreeRoomsTableCell release];
    
    [_fourSlotsOneRoomTableCell    release];
    [_fourSlotsTwoRoomsTableCell   release];
    [_fourSlotsThreeRoomsTableCell release];

    [_fiveSlotsOneRoomTableCell    release];
    
    [_noConnectionButton       release];
    [_ownStoredAcronymLabel    release];
    
    [_eightSlotsOneRoomTableCell release];
    [_oneSlotFourRoomsTableCell release];
    [_oneSlotSevenRoomsTableCell release];
    [_threeSlotsTwoRoomsTableCell release];
    [_threeSlotsThreeRoomsTableCell release];
    [super dealloc];
}

- (NSDateFormatter *)dayFormatter {
    NSDateFormatter *_dayFormatter = [[[NSDateFormatter alloc]init]autorelease];
    [_dayFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CEST"]];
    [_dayFormatter setDateFormat:@"dd.MM.yyyy"]; 
    return _dayFormatter;
} 

- (NSDateFormatter *)weekDayFormatter {
    NSDateFormatter *_weekDayFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [_weekDayFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [_weekDayFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CEST"]];    
    [_weekDayFormatter setDateFormat:@"EEEE"];
    return _weekDayFormatter;
}


- (NSDateFormatter *)timeFormatter {
    NSDateFormatter *timeFormatter = [[[NSDateFormatter alloc]init]autorelease];
    [timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CEST"]];
	[timeFormatter setDateFormat:@"HH:mm"]; 
    [timeFormatter setDefaultDate:[NSDate date]];
    return timeFormatter;
}



-(void) setNewScheduleWithAcronym:(NSString *)newAcronym:(NSString *)newAcronymType
{
    self._actualShownAcronymTrials = 1;
    self._actualShownAcronymString = newAcronym;
    self._actualShownAcronymType   = newAcronymType;
    self._schedule                 = nil;
    self._schedule                 = [[ScheduleDto alloc] initWithAcronym:newAcronym:newAcronymType:_actualDate];
    self._actualDayDto             = [self getDayDto];
    [_timeTable reloadData];
    _detailsVC._dayAndAcronymString = [NSString stringWithFormat:@" für den %@ von %@ (%@)"
                                       ,[[self dayFormatter] stringFromDate:_actualDate]
                                       , self._actualShownAcronymString
                                       ,[self getGermanTypeTranslation:self._actualShownAcronymType]
                                       ];
}



-(void) setNewScheduleWithDate:(NSDate *)newDate
{
    _actualShownAcronymTrials   = 1;
    DayDto   *_localDay;
    NSString *_localDateString;
    NSString *_newDateString    = [[self dayFormatter] stringFromDate:newDate];
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
            _localDateString = [[self dayFormatter] stringFromDate:_localDay._date];
            
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
            NSDateComponents *_components         = [[[NSDateComponents alloc] init] autorelease];
            [_components setDay:-7];
            NSCalendar       *_gregorian          = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
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
            NSLog(@"done loading schedule!");
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
        }
    }
}


- (IBAction)tryConnectionAgain:(id)sender
{
    [self setNewScheduleWithDate:_actualDate];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (NSString *)getGermanTypeTranslation:(NSString*)acronymType
{
    NSString *_localTranslation;
    
    if ([acronymType isEqualToString:@"classes"])
    {
        _localTranslation = @"Klasse";
    }
    if ([acronymType isEqualToString:@"students"])
    {
        _localTranslation = @"Student";
    }
    if ([acronymType isEqualToString:@"rooms"])
    {
        _localTranslation = @"Raum";
    }
    if ([acronymType isEqualToString:@"lecturers"])
    {
        _localTranslation = @"Dozent";
    }
    if ([acronymType isEqualToString:@"courses"])
    {
        _localTranslation = @"Kurs";
    }    
    return _localTranslation;
}



- (void) dayBefore:(id)sender 
{
    int daysToAdd = -1;  
    
    // set up date components
    NSDateComponents *_components = [[[NSDateComponents alloc] init] autorelease];
    [_components setDay:daysToAdd];
    
    NSCalendar *_gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDate     *_newDate   = [_gregorian dateByAddingComponents:_components toDate:self._actualDate options:0];
    
    self._actualDate      = _newDate;
    [self setNewScheduleWithDate:_newDate];

    //NSLog(@"Day before: %@", timeTableViewController._actualDate);
    
    _dayNavigator.title = [NSString stringWithFormat:@"%@, %@"
                           ,[[self weekDayFormatter] stringFromDate:self._actualDate]
                           ,[[self dayFormatter]     stringFromDate:self._actualDate]];
    _actualDayDto        = [self getDayDto];

    //[self viewWillAppear:YES];
    [_timeTable reloadData];
}



- (void) dayAfter:(id)sender
{
    
    NSDate *_newDate = [self._actualDate dateByAddingTimeInterval:(1*24*60*60)];
    self._actualDate = _newDate;
    [self setNewScheduleWithDate:_newDate];

    _dayNavigator.title = [NSString stringWithFormat:@"%@, %@"
                           ,[[self weekDayFormatter] stringFromDate:self._actualDate]
                           ,[[self dayFormatter]     stringFromDate:self._actualDate]];
    
    //NSLog(@"title: %@", _dayNavigator.title);
    
    _actualDayDto       = [self getDayDto];
    //[self viewWillAppear:YES];
    [_timeTable reloadData];
}


/*
- (void) popUpAcronymView:(NSString *)newMessage
{
    UIAlertView *_acronymAlertView = [[UIAlertView alloc] 
                                      initWithTitle:@"Kürzeleingabe"
                                      message:newMessage
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
    
    UITextField *_acronymTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    _acronymTextField.placeholder=@"Bitte Kürzel eingeben:";
    [_acronymTextField becomeFirstResponder];
    [_acronymTextField setBackgroundColor:[UIColor whiteColor]];
    _acronymTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    _acronymTextField.textAlignment=UITextAlignmentCenter;
    _acronymTextField.tag = 1001;
    
    [_acronymAlertView addSubview:_acronymTextField];        
    [_acronymAlertView show];
    [_acronymAlertView release];
}
 */


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
      NSLog(@"Nur Kürzel von Studenten und Dozenten sind möglich.");
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
        [_acronymUserDefaults setObject:_ownStoredAcronymString forKey:@"TimeTableAcronym"];
        [_acronymUserDefaults synchronize];
       
        _acronymLabel.text          = [NSString stringWithFormat:@"von %@ (%@)"            
                                       ,_ownStoredAcronymString
                                       ,[self getGermanTypeTranslation:_ownStoredAcronymType]
                                      ];
        _ownStoredAcronymLabel.text = [NSString stringWithFormat:@"eigenes Kürzel: %@",_ownStoredAcronymString];
        
        // SET NEW ACRONYM WITH ACTUAL DATE
        [self setNewScheduleWithAcronym:_ownStoredAcronymString:_ownStoredAcronymType];
    
        //NSLog(@"setAcronymLabel new acronym %@",_ownStoredAcronymString);
    }    
}



- (void) setTitleToActualDate 
{
    NSDateFormatter* df_local = [[[NSDateFormatter alloc] init] autorelease];
    [df_local setTimeZone:[NSTimeZone timeZoneWithName:@"CEST"]];
    [df_local setDateFormat:@"yyyy.MM.dd G 'at' HH:mm:ss zzz"];    

    //----- Navigation Bar ----
    // set current day
    //self._actualDate = [NSDate date];
    self._actualDate    = [[self dayFormatter] dateFromString:@"17.12.2012"];
    _dayNavigator.title = [NSString stringWithFormat:@"%@, %@"
                           ,[[self weekDayFormatter] stringFromDate:self._actualDate]
                           ,[[self dayFormatter]     stringFromDate:self._actualDate]];
    NSLog(@"set actual Date: %@", [[self dayFormatter] stringFromDate:self._actualDate]);
    
}



-(void) setNewAcronym:(NSString *)newAcronym:(NSString *)newAcronymType
{
    //NSLog(@"setNewAcronym");
    self._acronymLabel.text  = [NSString stringWithFormat:@"von %@ (%@)"
                           ,newAcronym
                           ,[self getGermanTypeTranslation:newAcronymType]
                          ];
    
    self._detailsVC._dayAndAcronymString = [NSString stringWithFormat:@" für den %@ von %@ (%@)"
                                       ,[[self dayFormatter] stringFromDate:_actualDate]
                                       , newAcronym
                                       ,[self getGermanTypeTranslation:newAcronymType]
                                       ];
    
    // SET NEW ACRONYM WITH ACTUAL DATE
    [self setNewScheduleWithAcronym:newAcronym :newAcronymType];
    
}



- (void)viewDidLoad
{

    [super viewDidLoad];
    
    //----- TimeTableViewController ----
    // set table controller
    if (_timeTable == nil) {
		_timeTable = [[UITableView alloc] init];
	}
    // clear border colour between table cells
    //_timeTable.separatorColor = [UIColor clearColor];    
    //_timeTable.style = UITableViewStylePlain;
    //_timeTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
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
    
    [_dayNavigator setLeftBarButtonItem :_leftButton animated :true];
    [_dayNavigator setRightBarButtonItem:_rightButton animated:true];

    [_leftButton  release];
    [_rightButton release];
    
    // ----- DETAIL PAGE -----
    if (_detailsVC == nil) 
    {
		_detailsVC = [[TimeTableDetailController alloc] init];
	}
    _detailsVC._timeTableDetailViewDelegate = self;
    _detailsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    // ----- ACRONYM -----
    if (_acronymVC == nil) 
    {
		_acronymVC = [[AcronymViewController alloc] init];
	}
    
    _acronymVC._acronymViewDelegate = self;
    _acronymVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    //----- USER DEFAULTS -----
    // get acronym from user defaults
    NSUserDefaults *_acronymUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString       *_acronym             = [_acronymUserDefaults stringForKey:@"TimeTableAcronym"];
    [self setAcronymLabel:(NSString *)_acronym];
    
    
    //NSLog(@"current acronym length: %i", [_storedAcronym length]);
    
    // go to acronym page to enforce setting an acronym
    if (_ownStoredAcronymString == nil || [_ownStoredAcronymString length] == 0)
    {   
        //NSLog(@"viewDidLoad noch kein Kürzel für den Stundenplan");
        //[self popUpAcronymView:@"Kürzel für den Stundenplan"];
         [self presentModalViewController:_acronymVC animated:YES];
    }
    
    if (_noConnectionButton == nil) {
		_noConnectionButton = [[UIButton alloc] init];
	}
    _noConnectionButton.hidden = YES;
    
}




// IMPORTANT, OTHERWISE DATA WILL NOT BE UPDATED, WHEN APP IS STARTED FIRST TIME
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    

    
    //NSLog(@"viewWillAppear schedule type %@",_schedule._type);
    
    // only reload, if acronym or date has changed
    if ( _schedule._type                  == nil 
     || [_schedule._type length]          == 0
     ||  _schedule._connectionEstablished == nil
     || ([_schedule._connectionEstablished compare: @"NO"] == NSOrderedSame)
     ) 
    {
        if (_actualShownAcronymTrials < 20)
        {
          //NSLog(@"viewWillAppear try connecting");
          _actualShownAcronymTrials++;
          self._schedule             = [_schedule initWithAcronym:_actualShownAcronymString:_actualShownAcronymType:_actualDate];
          _actualDayDto              = [self getDayDto];            
          _noConnectionButton.hidden = YES;
          [_timeTable reloadData];
            
           // NSLog(@"time table is reloaded");
        }
        else
        {
            //NSLog(@"50 mal versucht mit diesem Kürzel.");
            _noConnectionButton.hidden = NO;
            //[self popUpAcronymView:@"Kein valides Kürzel."];
        }
    }
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
            _acronymLabel.text                   = [NSString stringWithFormat:@"von %@",_actualShownAcronymString];
            NSUserDefaults *_acronymUserDefaults = [NSUserDefaults standardUserDefaults];
            [_acronymUserDefaults setObject:_actualShownAcronymString forKey:@"TimeTableAcronym"];
            [_acronymUserDefaults synchronize];
        }
       // NSLog(@"ok button is pushed: %@ %@", _textField.text, _acronymString);
    }
}


// needed for shaking
-(BOOL)canBecomeFirstResponder {
    return YES;
}

// also needed for shaking
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

// also needed for shaking
- (void)viewWillDisappear:(BOOL)animated 
{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}


//this one is also needed for shaking
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [self setTitleToActualDate];
        [self setNewAcronym:self._ownStoredAcronymString:self._ownStoredAcronymType];
    }
}


- (void)viewDidUnload
{
    [_dayNavigator release];
    _dayNavigator = nil;
    [_acronymLabel release];
    _acronymLabel = nil;
    [_acronymVC release];
    _acronymVC = nil;
    [_detailsVC release];
    _detailsVC = nil;
    
    [_oneSlotOneRoomTableCell    release];
    [_oneSlotTwoRoomsTableCell   release];
    [_oneSlotThreeRoomsTableCell release];
    [_oneSlotFiveRoomsTableCell  release];
    [_oneSlotSixRoomsTableCell   release];
    [_oneSlotEightRoomsTableCell release];

    [_twoSlotsOneRoomTableCell   release];
    [_twoSlotsTwoRoomsTableCell  release];

    [_threeSlotsOneRoomTableCell release];
    
    [_fourSlotsOneRoomTableCell    release];
    [_fourSlotsTwoRoomsTableCell   release];
    [_fourSlotsThreeRoomsTableCell release];

    [_fiveSlotsOneRoomTableCell    release];
    
    _oneSlotOneRoomTableCell    = nil;
    _oneSlotTwoRoomsTableCell   = nil;
    _oneSlotThreeRoomsTableCell = nil;
    _oneSlotFiveRoomsTableCell  = nil;
    _oneSlotSixRoomsTableCell   = nil;
    _oneSlotEightRoomsTableCell = nil;
    
    _twoSlotsOneRoomTableCell   = nil;
    _twoSlotsTwoRoomsTableCell  = nil;

    _threeSlotsOneRoomTableCell = nil;
    _threeSlotsTwoRoomsTableCell = nil;
    
    _fourSlotsTwoRoomsTableCell   = nil;
    _fourSlotsThreeRoomsTableCell = nil;
    _fourSlotsOneRoomTableCell    = nil;

    _fiveSlotsOneRoomTableCell    = nil;
    
    [_noConnectionButton release];
    _noConnectionButton = nil;
    [_ownStoredAcronymLabel release];
    _ownStoredAcronymLabel = nil;

    [_eightSlotsOneRoomTableCell release];
    _eightSlotsOneRoomTableCell = nil;
    [_oneSlotFourRoomsTableCell release];
    _oneSlotFourRoomsTableCell = nil;
    [_oneSlotSevenRoomsTableCell release];
    _oneSlotSevenRoomsTableCell = nil;
    [_threeSlotsTwoRoomsTableCell release];
    _threeSlotsTwoRoomsTableCell = nil;
    [_threeSlotsThreeRoomsTableCell release];
    _threeSlotsThreeRoomsTableCell = nil;
    [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



// ----- ACRONYM HANDLING -----
- (IBAction)enterAcronym:(id)sender 
{
    [self presentModalViewController:_acronymVC animated:YES];
}


// ---------------------------



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
        //NSLog(@"showScheduleDetails acronym: %@", _acronymString);
    
        _detailsVC._dayAndAcronymString = [NSString stringWithFormat:@" für den %@ von %@ (%@)"
                                           ,[[self dayFormatter] stringFromDate:_actualDate]
                                           , self._actualShownAcronymString
                                           ,[self getGermanTypeTranslation:self._actualShownAcronymType]
                                           ];
    
        NSString *_fromString           = [[self timeFormatter] stringFromDate: _detailsVC._scheduleEvent._startTime];
        NSString *_toString             = [[self timeFormatter] stringFromDate: _detailsVC._scheduleEvent._endTime  ];
        
        //NSLog(@"schedule event end time %@", _toString);
        
        _detailsVC._timeString          = [NSString stringWithFormat:@"Modul von %@ bis %@",_fromString, _toString];
        _detailsVC._timeLabel.text      = _detailsVC._timeString;
        [_detailsVC._detailTable reloadData];
        [self presentModalViewController:_detailsVC animated:YES];
    }
}





//-(void) changeToRoomSchedule:(id)sender event:(id)event:(int)realizationIndex
-(void) changeToRoomSchedule:(id)sender :(id)event:(int)realizationIndex
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
        _acronymLabel.text  = [NSString stringWithFormat:@"von %@ (Raum)",_roomString];
        
        // SET NEW ACRONYM WITH ACTUAL DATE
        [self setNewScheduleWithAcronym:_roomString :@"rooms"];
    }
}

-(void) changeToRoomSchedule1:(id)sender event:(id)event
{   
    [self changeToRoomSchedule:sender:event:0];
}

-(void) changeToRoomSchedule2:(id)sender event:(id)event
{   
    [self changeToRoomSchedule:sender:event:1];
}

-(void) changeToRoomSchedule3:(id)sender event:(id)event
{   
    [self changeToRoomSchedule:sender:event:2];
}

-(void) changeToRoomSchedule4:(id)sender event:(id)event
{   
    [self changeToRoomSchedule:sender:event:3];
}

-(void) changeToRoomSchedule5:(id)sender event:(id)event
{   
    [self changeToRoomSchedule:sender:event:4];
}

-(void) changeToRoomSchedule6:(id)sender event:(id)event
{   
    [self changeToRoomSchedule:sender:event:5];
}

-(void) changeToRoomSchedule7:(id)sender event:(id)event
{   
    [self changeToRoomSchedule:sender:event:6];
}

-(void) changeToRoomSchedule8:(id)sender event:(id)event
{   
    [self changeToRoomSchedule:sender:event:7];
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
        _acronymLabel.text  = [NSString stringWithFormat:@"von %@ (Kurs)",_courseString];
        
        // SET NEW ACRONYM WITH ACTUAL DATE
        [self setNewScheduleWithAcronym:_courseString :@"courses"];
    }
}


// --------------------------------



// ------- MANAGE TABLE CELLS ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_actualDayDto._events count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"in numberOfRowsInSection");
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1; //[_schedule._days count]; //first 1 // [_timeTableSlotArray count];
}
 

- (ScheduleEventDto *)getCurrentScheduleEvent:(DayDto *)currentDay: (NSDate *)fromTime:(NSDate *)toTime:(ScheduleEventDto *)formerScheduleEvent    
{   
    ScheduleEventDto *_localScheduleEvent   = nil;
    ScheduleEventDto *_goalScheduleEvent    = nil;
    
    NSString         *_fromLocalScheduleEvent;
    NSString         *_toLocalScheduleEvent;   
    
    NSString         *_formerToEvent;
    NSString         *_formerFromEvent;
    
    BOOL              _sameEventAgain       = NO;
    
    NSString         *_fromString           = [[self timeFormatter] stringFromDate: fromTime];
    NSString         *_toString             = [[self timeFormatter] stringFromDate: toTime  ];
    
    int dayI;
        
    for (dayI = 0; dayI < [currentDay._events count]; dayI ++)
    {   
        _localScheduleEvent     = [currentDay._events objectAtIndex:dayI];     
        _toLocalScheduleEvent   = [[self timeFormatter] stringFromDate: _localScheduleEvent._endTime];
        _fromLocalScheduleEvent = [[self timeFormatter] stringFromDate: _localScheduleEvent._startTime];
        
        if (formerScheduleEvent != nil) 
        {
            _formerToEvent   = [[self timeFormatter] stringFromDate: formerScheduleEvent._endTime];
            _formerFromEvent = [[self timeFormatter] stringFromDate: formerScheduleEvent._startTime];
            
            // if the same lecture comes again, don't list it again
            
            //NSLog(@"_localScheduleEvent._name: %@ from %@ to %@ former event %@ from %@ to %@"
            //      , _localScheduleEvent._name
            //      , _fromLocalScheduleEvent
            //      , _toLocalScheduleEvent
            //      ,formerScheduleEvent._name
            //      ,_formerFromEvent
            //      ,_formerToEvent
            //      );
            
            // actual time slot is defined by fromString and toString
            // the local schedule event must be either between them or be one of them
            if (
                 (  [_fromString compare: _fromLocalScheduleEvent] == NSOrderedSame 
                  ||[_toString   compare: _toLocalScheduleEvent  ] == NSOrderedSame
                  ||(
                     [_fromString          compare: _fromLocalScheduleEvent  ] == NSOrderedDescending 
                     &&[_toString          compare: _toLocalScheduleEvent    ] == NSOrderedAscending
                     )
                 )
                &&
            // the time of the former event must be between them or one of the them
                 (    [_formerFromEvent          compare: _fromLocalScheduleEvent  ] == NSOrderedSame 
                    ||[_formerToEvent            compare: _toLocalScheduleEvent    ] == NSOrderedSame
                    ||(
                        [_formerFromEvent          compare: _fromLocalScheduleEvent  ] == NSOrderedDescending 
                      &&[_formerToEvent            compare: _toLocalScheduleEvent    ] == NSOrderedAscending
                      )
                    //||[formerScheduleEvent._name compare: _localScheduleEvent._name] == NSOrderedSame
                 )
                )
            {
                // also compare the rooms, mabye the next lecture is somewhere else
                if (  [_localScheduleEvent._scheduleEventRealizations count] == 1
                   && [formerScheduleEvent._scheduleEventRealizations count] == 1
                    ) 
                {
                    ScheduleEventRealizationDto *_formerRealization = 
                      [formerScheduleEvent._scheduleEventRealizations objectAtIndex:0];
                    ScheduleEventRealizationDto *_localRealization = 
                    [_localScheduleEvent._scheduleEventRealizations objectAtIndex:0];    
                    
                    if  ([_formerRealization._room._name compare: _localRealization._room._name] == NSOrderedSame)
                    {
                        NSMutableArray *_emptyArray = [[NSMutableArray alloc]init];
                        _goalScheduleEvent = [[ScheduleEventDto alloc]init:@"":fromTime:toTime:@"same":_emptyArray:@"same":_emptyArray];
                        _sameEventAgain    = YES;
                    }
                   
                }
                else 
                {
                    NSMutableArray *_emptyArray = [[NSMutableArray alloc]init];
                    _goalScheduleEvent = [[ScheduleEventDto alloc]init:@"":fromTime:toTime:@"same":_emptyArray:@"same":_emptyArray];
                    _sameEventAgain    = YES;
            
                }
            }
        }
        
        // found a schedule event for this time
        if (([_fromString compare: _fromLocalScheduleEvent] == NSOrderedSame ||[_toString   compare: _toLocalScheduleEvent  ] == NSOrderedSame)
             && (!_sameEventAgain) )
        {
            _goalScheduleEvent = _localScheduleEvent;
        }
    }
    
    if([_goalScheduleEvent._name length] == 0)
    {
        NSMutableArray *_emptyArray = [[NSMutableArray alloc]init];
        _goalScheduleEvent = [[ScheduleEventDto alloc]init:@"":fromTime:toTime:@"empty":_emptyArray:@"empty":_emptyArray];
    }
    
    //_toLocalScheduleEvent   = [[self timeFormatter] stringFromDate: _goalScheduleEvent._endTime];
    //_fromLocalScheduleEvent = [[self timeFormatter] stringFromDate: _goalScheduleEvent._startTime];
    //NSLog(@"_goalScheduleEvent._name: %@ from %@ to %@", _goalScheduleEvent._name, _fromLocalScheduleEvent, _toLocalScheduleEvent);
    return _goalScheduleEvent;
}


- (NSMutableArray *)getSortedScheduleEvent:(DayDto *)currentDay
{
    //NSLog(@"getSortedScheduleEvent");
    NSMutableArray   *_sortedEvents       = [[NSMutableArray alloc]init];      
    ScheduleEventDto *_firstScheduleEvent = nil;    
    ScheduleEventDto *_nextScheduleEvent  = nil;    
    NSDate           *_fromTime           = nil;
    NSDate           *_toTime             = nil;    
    
    _fromTime           = [[self timeFormatter] dateFromString:@"08:00"];
    _toTime             = [[self timeFormatter] dateFromString:@"08:45"]; 
    _firstScheduleEvent = [self getCurrentScheduleEvent:currentDay:_fromTime:_toTime:nil];
    [_sortedEvents addObject:_firstScheduleEvent];
    
    _fromTime           = [[self timeFormatter] dateFromString:@"08:50"];
    _toTime             = [[self timeFormatter] dateFromString:@"09:35"];
    _nextScheduleEvent  = [self getCurrentScheduleEvent:currentDay:_fromTime:_toTime:_firstScheduleEvent];
    if ([_nextScheduleEvent._name compare: @"same"] != NSOrderedSame)
    {
        [_sortedEvents addObject:_nextScheduleEvent];
        _firstScheduleEvent = _nextScheduleEvent;
    }
    
    _fromTime   = [[self timeFormatter] dateFromString:@"10:00"];
    _toTime     = [[self timeFormatter] dateFromString:@"10:45"];
    _nextScheduleEvent  = [self getCurrentScheduleEvent:currentDay:_fromTime:_toTime:_firstScheduleEvent];
    if ([_nextScheduleEvent._name compare: @"same"] != NSOrderedSame)
    {
        [_sortedEvents addObject:_nextScheduleEvent];
        _firstScheduleEvent = _nextScheduleEvent;
    }
    
    _fromTime   = [[self timeFormatter] dateFromString:@"10:50"];
    _toTime     = [[self timeFormatter] dateFromString:@"11:35"];
    _nextScheduleEvent  = [self getCurrentScheduleEvent:currentDay:_fromTime:_toTime:_firstScheduleEvent];
    if ([_nextScheduleEvent._name compare: @"same"] != NSOrderedSame)
    {
        [_sortedEvents addObject:_nextScheduleEvent];
        _firstScheduleEvent = _nextScheduleEvent;
    }
    
    _fromTime   = [[self timeFormatter] dateFromString:@"12:00"];
    _toTime     = [[self timeFormatter] dateFromString:@"12:45"];
    _nextScheduleEvent  = [self getCurrentScheduleEvent:currentDay:_fromTime:_toTime:_firstScheduleEvent];
    if ([_nextScheduleEvent._name compare: @"same"] != NSOrderedSame)
    {
        [_sortedEvents addObject:_nextScheduleEvent];
        _firstScheduleEvent = _nextScheduleEvent;
    }
    
    _fromTime   = [[self timeFormatter] dateFromString:@"12:50"];
    _toTime     = [[self timeFormatter] dateFromString:@"13:35"];
    _nextScheduleEvent  = [self getCurrentScheduleEvent:currentDay:_fromTime:_toTime:_firstScheduleEvent];
    if ([_nextScheduleEvent._name compare: @"same"] != NSOrderedSame)
    {
        [_sortedEvents addObject:_nextScheduleEvent];
    }
    _firstScheduleEvent = _nextScheduleEvent;
    
    _fromTime   = [[self timeFormatter] dateFromString:@"14:00"];
    _toTime     = [[self timeFormatter] dateFromString:@"14:45"];
    _nextScheduleEvent  = [self getCurrentScheduleEvent:currentDay:_fromTime:_toTime:_firstScheduleEvent];
    if ([_nextScheduleEvent._name compare: @"same"] != NSOrderedSame)
    {
        [_sortedEvents addObject:_nextScheduleEvent];
    }
    _firstScheduleEvent = _nextScheduleEvent;
    
    _fromTime   = [[self timeFormatter] dateFromString:@"14:50"];
    _toTime     = [[self timeFormatter] dateFromString:@"15:35"];
    _nextScheduleEvent  = [self getCurrentScheduleEvent:currentDay:_fromTime:_toTime:_firstScheduleEvent];
    if ([_nextScheduleEvent._name compare: @"same"] != NSOrderedSame)
    {
        [_sortedEvents addObject:_nextScheduleEvent];
    }
    _firstScheduleEvent = _nextScheduleEvent;
    
    _fromTime   = [[self timeFormatter] dateFromString:@"16:00"];
    _toTime     = [[self timeFormatter] dateFromString:@"16:45"];
    _nextScheduleEvent  = [self getCurrentScheduleEvent:currentDay:_fromTime:_toTime:_firstScheduleEvent];
    if ([_nextScheduleEvent._name compare: @"same"] != NSOrderedSame)
    {
        [_sortedEvents addObject:_nextScheduleEvent];
    }
    _firstScheduleEvent = _nextScheduleEvent;
    
    _fromTime   = [[self timeFormatter] dateFromString:@"16:50"];
    _toTime     = [[self timeFormatter] dateFromString:@"17:35"];
    _nextScheduleEvent  = [self getCurrentScheduleEvent:currentDay:_fromTime:_toTime:_firstScheduleEvent];
    if ([_nextScheduleEvent._name compare: @"same"] != NSOrderedSame)
    {
        [_sortedEvents addObject:_nextScheduleEvent];
    }
    _firstScheduleEvent = _nextScheduleEvent;
    
    _fromTime   = [[self timeFormatter] dateFromString:@"18:00"];
    _toTime     = [[self timeFormatter] dateFromString:@"18:45"];
    _nextScheduleEvent  = [self getCurrentScheduleEvent:currentDay:_fromTime:_toTime:_firstScheduleEvent];
    if ([_nextScheduleEvent._name compare: @"same"] != NSOrderedSame)
    {
        [_sortedEvents addObject:_nextScheduleEvent];
    }
    _firstScheduleEvent = _nextScheduleEvent;
    
    _fromTime   = [[self timeFormatter] dateFromString:@"18:50"];
    _toTime     = [[self timeFormatter] dateFromString:@"19:35"];
    _nextScheduleEvent  = [self getCurrentScheduleEvent:currentDay:_fromTime:_toTime:_firstScheduleEvent];
    if ([_nextScheduleEvent._name compare: @"same"] != NSOrderedSame)
    {
        [_sortedEvents addObject:_nextScheduleEvent];
    }
    _firstScheduleEvent = _nextScheduleEvent;
    
    _fromTime   = [[self timeFormatter] dateFromString:@"19:45"];
    _toTime     = [[self timeFormatter] dateFromString:@"20:30"];
    _nextScheduleEvent  = [self getCurrentScheduleEvent:currentDay:_fromTime:_toTime:_firstScheduleEvent];
    if ([_nextScheduleEvent._name compare: @"same"] != NSOrderedSame)
    {
        [_sortedEvents addObject:_nextScheduleEvent];
    }
    _firstScheduleEvent = _nextScheduleEvent;
    
    _fromTime   = [[self timeFormatter] dateFromString:@"20:35"];
    _toTime     = [[self timeFormatter] dateFromString:@"21:20"];
    _nextScheduleEvent  = [self getCurrentScheduleEvent:currentDay:_fromTime:_toTime:_firstScheduleEvent];
    if ([_nextScheduleEvent._name compare: @"same"] != NSOrderedSame)
    {
        [_sortedEvents addObject:_nextScheduleEvent];
    }
    //NSLog(@"getSortedScheduleEvent %i", [_sortedEvents count] );
    return _sortedEvents;
}



- (DayDto *)getDayDto
{
    DayDto         *_oneDay   = nil;
    DayDto         *_foundDay = nil;
    DayDto         *_newDay   = nil;
    NSMutableArray *_newEvents = [[NSMutableArray alloc]init];
    NSMutableArray *_newSlots  = [[NSMutableArray alloc]init];
    
    //NSLog(@" how many days %i", [_schedule._days count]);
    
    int      dayCount;
    for (dayCount = 0; dayCount < [_schedule._days count]; dayCount++) 
    {
      _oneDay = [_schedule._days objectAtIndex:dayCount];
    
      NSString *_oneDayString    = [[self dayFormatter] stringFromDate:_oneDay._date];
      NSString *_actualDayString = [[self dayFormatter] stringFromDate:_actualDate];
      
       // NSLog(@"getDayDto %@ = %@?", _oneDayString, _actualDayString);
      
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




- (NSMutableArray *)getTimeArray: (NSUInteger )cellSelection 
{
    NSMutableArray *_timeArray = [[NSMutableArray alloc]init];
    
    NSDate *_from;
    NSDate *_to;
    
    switch ((int)cellSelection) {
        case 0:  _from = [[self timeFormatter] dateFromString:@"08:00"];  _to = [[self timeFormatter] dateFromString:@"08:45"]; break;
        case 1:  _from = [[self timeFormatter] dateFromString:@"08:50"];  _to = [[self timeFormatter] dateFromString:@"09:35"]; break;
        case 2:  _from = [[self timeFormatter] dateFromString:@"10:00"];  _to = [[self timeFormatter] dateFromString:@"10:45"]; break;
        case 3:  _from = [[self timeFormatter] dateFromString:@"10:50"];  _to = [[self timeFormatter] dateFromString:@"11:35"]; break;
        case 4:  _from = [[self timeFormatter] dateFromString:@"12:00"];  _to = [[self timeFormatter] dateFromString:@"12:45"]; break;
        case 5:  _from = [[self timeFormatter] dateFromString:@"12:50"];  _to = [[self timeFormatter] dateFromString:@"13:35"]; break;
        case 6:  _from = [[self timeFormatter] dateFromString:@"14:00"];  _to = [[self timeFormatter] dateFromString:@"14:45"]; break;
        case 7:  _from = [[self timeFormatter] dateFromString:@"14:50"];  _to = [[self timeFormatter] dateFromString:@"15:35"]; break;
        case 8:  _from = [[self timeFormatter] dateFromString:@"16:00"];  _to = [[self timeFormatter] dateFromString:@"16:45"]; break;
        case 9:  _from = [[self timeFormatter] dateFromString:@"16:50"];  _to = [[self timeFormatter] dateFromString:@"17:35"]; break;
        case 10: _from = [[self timeFormatter] dateFromString:@"18:00"];  _to = [[self timeFormatter] dateFromString:@"18:45"]; break;
        case 11: _from = [[self timeFormatter] dateFromString:@"18:50"];  _to = [[self timeFormatter] dateFromString:@"19:35"]; break;
        case 12: _from = [[self timeFormatter] dateFromString:@"19:45"];  _to = [[self timeFormatter] dateFromString:@"20:30"]; break;
        case 13: _from = [[self timeFormatter] dateFromString:@"20:35"];  _to = [[self timeFormatter] dateFromString:@"21:20"]; break;
    }
    
    [_timeArray addObject:_from];
    [_timeArray addObject:_to  ];
    return _timeArray;
}





- (BOOL) isActualDayAndTime: (NSDate *)actualDate:(NSUInteger )cellSelection{

    NSDate *_today = [NSDate date];
    //NSDate *_today    = [[self dayFormatter] dateFromString:@"19.03.2012"];


    //NSLog(@"set actual Date: %@",timeTableViewController._actualDate);
    //NSLog(@"set actual Date: %@", [[self dayFormatter] stringFromDate:self._actualDate]);

    NSString *_actualDayString    = [[self dayFormatter] stringFromDate:_actualDate];
    NSString *_todayString        = [[self dayFormatter] stringFromDate:_today];
    
    
    // compare dates
    if ([_actualDayString isEqualToString: _todayString]) 
    {
        // compare time slots
        NSString *_todayTimeString     = [[self timeFormatter] stringFromDate:_today];
        //NSString *_todayTimeString = @"17:05";
        
        NSMutableArray *_timeArray  = [self getTimeArray:cellSelection];
        NSDate         *_from       = [_timeArray objectAtIndex:0]; 
        NSString       *_fromString = [[self timeFormatter] stringFromDate: _from];
        NSDate         *_to         = [_timeArray objectAtIndex:1]; 
        NSString       *_toString   = [[self timeFormatter] stringFromDate: _to];
          
        if ([_fromString      compare: _todayTimeString] == NSOrderedAscending && 
            [_todayTimeString compare: _toString]        == NSOrderedAscending) 
        {
         // NSLog(@"YES _fromString: %@ _toString: %@ _todayTimeString: %@", _fromString, _toString, _todayTimeString);
          return YES;
        }
    }
   // return YES;
    return NO;
}


- (UITableViewCell *)emptyCell
    :(UITableView      *)actualTableView
    :(NSUInteger        )actualSelection
    :(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"OneSlotOneRoomTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"OneSlotOneRoomTableCell" owner:self options:nil];
        _cell = _oneSlotOneRoomTableCell;
        self._oneSlotOneRoomTableCell = nil;
    }

    UILabel          *_labelDate     = (UILabel  *)[_cell viewWithTag:1];
    UIButton         *_lectureButton = (UIButton *)[_cell viewWithTag:2];  
    UIButton         *_roomButton    = (UIButton *)[_cell viewWithTag:3];  
    UIButton         *_detailButton  = (UIButton *)[_cell viewWithTag:4];  // with arrow image, leading to detail page
    
    // initially always disable detail button
    _detailButton.enabled  = FALSE;
    _detailButton.hidden   = YES;
    _lectureButton.enabled = FALSE;
    _roomButton.enabled    = FALSE;
    
    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    [_roomButton    setTitle:@"" forState:UIControlStateNormal];
    [_labelDate     setBackgroundColor:[UIColor clearColor]];
    [_lectureButton setBackgroundColor:[UIColor clearColor]];
    [_roomButton    setBackgroundColor:[UIColor clearColor]];
    [_cell          setBackgroundColor:[UIColor clearColor]];
    
    if (actualScheduleEvent == nil)
    {
        _labelDate.text = [NSString stringWithFormat:@"xxx - xxx"];
    }
    else
    {
        _labelDate.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:actualScheduleEvent._startTime],  
                            [[self timeFormatter] stringFromDate:actualScheduleEvent._endTime  ]
                           ];  
    }
    
    // for actual day and time slot mark with background colour
    if ([self isActualDayAndTime:_actualDate:actualSelection]) 
    {    
        [_labelDate     setBackgroundColor:[UIColor lightGrayColor]];
        [_lectureButton setBackgroundColor:[UIColor lightGrayColor]];
        [_roomButton    setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    [_lectureButton  setTitle:@"" forState:UIControlStateNormal];
    
    return _cell;
}



- (UITableViewCell *)oneSlotOneRoom:(UITableView *)actualTableView:(NSUInteger)actualSelection:(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"OneSlotOneRoomTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"OneSlotOneRoomTableCell" owner:self options:nil];
        _cell = _oneSlotOneRoomTableCell;
        self._oneSlotOneRoomTableCell = nil;
    }
    
    UILabel          *_labelDate     = (UILabel  *)[_cell viewWithTag:1];
    UIButton         *_lectureButton = (UIButton *)[_cell viewWithTag:2];  
    UIButton         *_roomButton    = (UIButton *)[_cell viewWithTag:3];  
    UIButton         *_detailButton  = (UIButton *)[_cell viewWithTag:4];  // with arrow image, leading to detail page
    
    // initially always disable detail button
    _detailButton.enabled  = FALSE;
    _lectureButton.enabled = FALSE;
    _roomButton.enabled    = FALSE;
    
    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    [_roomButton    setTitle:@"" forState:UIControlStateNormal];
    [_labelDate     setBackgroundColor:[UIColor clearColor]];
    [_lectureButton setBackgroundColor:[UIColor clearColor]];
    [_roomButton    setBackgroundColor:[UIColor clearColor]];
    [_cell          setBackgroundColor:[UIColor clearColor]];
    
    _labelDate.text = [NSString stringWithFormat:@"%@ - %@",  
                       [[self timeFormatter] stringFromDate:actualScheduleEvent._startTime],  
                       [[self timeFormatter] stringFromDate:actualScheduleEvent._endTime  ]
                       ];  
    
    // for actual day and time slot mark with background colour
    if ([self isActualDayAndTime:_actualDate:actualSelection]) 
    {    
        [_labelDate     setBackgroundColor:[UIColor lightGrayColor]];
        [_lectureButton setBackgroundColor:[UIColor lightGrayColor]];
        [_roomButton    setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    _lectureButton.enabled  = TRUE;
    _roomButton.enabled     = TRUE;
    _detailButton.enabled   = TRUE;
    _detailButton.hidden    = NO;

    ScheduleEventRealizationDto *_localRealization = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    [_roomButton    setTitle:_localRealization._room._name  forState:UIControlStateNormal];
    [_lectureButton setTitle:actualScheduleEvent._name      forState:UIControlStateNormal];
    
    [_detailButton  addTarget:self action:@selector(showScheduleDetails     :event:) forControlEvents:UIControlEventTouchUpInside];
    [_lectureButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [_roomButton    addTarget:self action:@selector(changeToRoomSchedule1   :event:) forControlEvents:UIControlEventTouchUpInside];
    return _cell;
}



- (UITableViewCell *)twoSlotsOneRoom:(UITableView *)actualTableView:(NSUInteger)actualSelection:(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"TwoSlotsOneRoomTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];

    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"TwoSlotsOneRoomTableCell" owner:self options:nil];
        _cell = _twoSlotsOneRoomTableCell;
        self._twoSlotsOneRoomTableCell = nil;
    }

    UILabel          *_labelTimeSlot1 = (UILabel  *)[_cell viewWithTag:1];
    UILabel          *_labelTimeSlot2 = (UILabel  *)[_cell viewWithTag:2];
    UIButton         *_lectureButton  = (UIButton *)[_cell viewWithTag:3];  
    UIButton         *_roomButton     = (UIButton *)[_cell viewWithTag:4];  
    UIButton         *_detailButton   = (UIButton *)[_cell viewWithTag:5];  // with arrow image, leading to detail page

    // initially always disable detail button
    _detailButton.enabled  = FALSE;
    _lectureButton.enabled = FALSE;
    _roomButton.enabled    = FALSE;

    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    [_roomButton    setTitle:@"" forState:UIControlStateNormal];
    
    [_labelTimeSlot1 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot2 setBackgroundColor:[UIColor clearColor]];
    [_lectureButton  setBackgroundColor:[UIColor clearColor]];
    [_roomButton     setBackgroundColor:[UIColor clearColor]];
    [_cell           setBackgroundColor:[UIColor clearColor]];

    if ([self isActualDayAndTime:_actualDate:actualSelection]) 
    {    
        [_labelTimeSlot1 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot2 setBackgroundColor:[UIColor lightGrayColor]];
        [_lectureButton  setBackgroundColor:[UIColor lightGrayColor]];
        [_roomButton     setBackgroundColor:[UIColor lightGrayColor]];
    }

    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];

    _labelTimeSlot1.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot1._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot1._endTime  ]
                            ];  
    _labelTimeSlot2.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot2._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot2._endTime  ]
                            ];  
    
    ScheduleEventRealizationDto *_localRealization = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    
    _lectureButton.enabled  = TRUE;
    _roomButton.enabled     = TRUE;    
    _detailButton.enabled   = TRUE;
    
    [_lectureButton setTitle:actualScheduleEvent._name      forState:UIControlStateNormal];
    [_roomButton    setTitle:_localRealization._room._name  forState:UIControlStateNormal];
    
    [_roomButton    addTarget:self action:@selector(changeToRoomSchedule1   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_lectureButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [_detailButton  addTarget:self action:@selector(showScheduleDetails     :event:) forControlEvents:UIControlEventTouchUpInside];
            
    return _cell;        
}


- (UITableViewCell *)threeSlotsOneRoom:(UITableView *)actualTableView:(NSUInteger)actualSelection:(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"ThreeSlotsOneRoomTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"ThreeSlotsOneRoomTableCell" owner:self options:nil];
        _cell = _threeSlotsOneRoomTableCell;
        self._threeSlotsOneRoomTableCell = nil;
    }
    
    UILabel          *_labelTimeSlot1 = (UILabel  *)[_cell viewWithTag:1];
    UILabel          *_labelTimeSlot2 = (UILabel  *)[_cell viewWithTag:2];
    UILabel          *_labelTimeSlot3 = (UILabel  *)[_cell viewWithTag:3];
    UIButton         *_lectureButton  = (UIButton *)[_cell viewWithTag:4];  
    UIButton         *_roomButton     = (UIButton *)[_cell viewWithTag:5];  
    UIButton         *_detailButton   = (UIButton *)[_cell viewWithTag:6];  // with arrow image, leading to detail page
    
    // initially always disable detail button
    _detailButton.enabled  = FALSE;
    _lectureButton.enabled = FALSE;
    _roomButton.enabled    = FALSE;
    
    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    [_roomButton    setTitle:@"" forState:UIControlStateNormal];
    
    [_labelTimeSlot1 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot2 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot3 setBackgroundColor:[UIColor clearColor]];
    [_lectureButton  setBackgroundColor:[UIColor clearColor]];
    [_roomButton     setBackgroundColor:[UIColor clearColor]];
    [_cell           setBackgroundColor:[UIColor clearColor]];
    
    if ([self isActualDayAndTime:_actualDate:actualSelection]) 
    {    
        [_labelTimeSlot1 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot2 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot3 setBackgroundColor:[UIColor lightGrayColor]];
        [_lectureButton  setBackgroundColor:[UIColor lightGrayColor]];
        [_roomButton     setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    
    _labelTimeSlot1.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot1._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot1._endTime  ]
                            ];  
    _labelTimeSlot2.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot2._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot2._endTime  ]
                            ];  
    _labelTimeSlot3.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot3._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot3._endTime  ]
                            ];  
    
    _lectureButton.enabled  = TRUE;
    _roomButton.enabled     = TRUE;    
    _detailButton.enabled   = TRUE;
    
    ScheduleEventRealizationDto *_localRealization = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    [_roomButton    setTitle:_localRealization._room._name  forState:UIControlStateNormal];
    [_lectureButton setTitle:actualScheduleEvent._name      forState:UIControlStateNormal];
    
    [_roomButton    addTarget:self action:@selector(changeToRoomSchedule1   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_lectureButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [_detailButton  addTarget:self action:@selector(showScheduleDetails     :event:) forControlEvents:UIControlEventTouchUpInside];
    
    return _cell;        
}


- (UITableViewCell *)oneSlotTwoRooms:(UITableView *)actualTableView:(NSUInteger)actualSelection:(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"OneSlotTwoRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"OneSlotTwoRoomsTableCell" owner:self options:nil];
        _cell = _oneSlotTwoRoomsTableCell;
        self._oneSlotTwoRoomsTableCell = nil;
    }
    
    UILabel          *_labelTimeSlot1 = (UILabel  *)[_cell viewWithTag:1];
    UIButton         *_lectureButton  = (UIButton *)[_cell viewWithTag:2];  
    UIButton         *_room1Button    = (UIButton *)[_cell viewWithTag:3];  
    UIButton         *_room2Button    = (UIButton *)[_cell viewWithTag:4];  
    UIButton         *_detailButton   = (UIButton *)[_cell viewWithTag:5];  // with arrow image, leading to detail page
    
    // initially always disable detail button
    _detailButton.enabled  = FALSE;
    _lectureButton.enabled = FALSE;
    _room1Button.enabled   = FALSE;
    _room2Button.enabled   = FALSE;
    
    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    [_room1Button   setTitle:@"" forState:UIControlStateNormal];
    [_room2Button   setTitle:@"" forState:UIControlStateNormal];
    
    [_labelTimeSlot1 setBackgroundColor:[UIColor clearColor]];
    [_lectureButton  setBackgroundColor:[UIColor clearColor]];
    [_room1Button    setBackgroundColor:[UIColor clearColor]];
    [_room2Button    setBackgroundColor:[UIColor clearColor]];
    [_cell           setBackgroundColor:[UIColor clearColor]];
    
    if ([self isActualDayAndTime:_actualDate:actualSelection]) 
    {    
        [_labelTimeSlot1 setBackgroundColor:[UIColor lightGrayColor]];
        [_lectureButton  setBackgroundColor:[UIColor lightGrayColor]];
        [_room1Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room2Button    setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    
    _labelTimeSlot1.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot1._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot1._endTime  ]
                            ];  
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    
    [_room1Button   setTitle:_localRealization1._room._name  forState:UIControlStateNormal];
    [_room2Button   setTitle:_localRealization2._room._name  forState:UIControlStateNormal];
    [_lectureButton setTitle:actualScheduleEvent._name       forState:UIControlStateNormal];
    
    _lectureButton.enabled  = TRUE;
    _room1Button.enabled    = TRUE;    
    _room2Button.enabled    = TRUE;    
    _detailButton.enabled   = TRUE;
    
    [_room1Button   addTarget:self action:@selector(changeToRoomSchedule1   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room2Button   addTarget:self action:@selector(changeToRoomSchedule2   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_lectureButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [_detailButton  addTarget:self action:@selector(showScheduleDetails     :event:) forControlEvents:UIControlEventTouchUpInside];
    
    return _cell;        
}


- (UITableViewCell *)twoSlotsTwoRooms:(UITableView *)actualTableView:(NSUInteger)actualSelection:(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"TwoSlotsTwoRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"TwoSlotsTwoRoomsTableCell" owner:self options:nil];
        _cell = _twoSlotsTwoRoomsTableCell;
        self._twoSlotsTwoRoomsTableCell = nil;
    }
    
    UILabel          *_labelTimeSlot1 = (UILabel  *)[_cell viewWithTag:1];
    UILabel          *_labelTimeSlot2 = (UILabel  *)[_cell viewWithTag:2];
    UIButton         *_lectureButton  = (UIButton *)[_cell viewWithTag:3];  
    UIButton         *_room1Button    = (UIButton *)[_cell viewWithTag:4];  
    UIButton         *_room2Button    = (UIButton *)[_cell viewWithTag:5];  
    UIButton         *_detailButton   = (UIButton *)[_cell viewWithTag:6];  // with arrow image, leading to detail page
    
    // initially always disable detail button
    _detailButton.enabled  = FALSE;
    _lectureButton.enabled = FALSE;
    _room1Button.enabled   = FALSE;
    _room2Button.enabled   = FALSE;
    
    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    [_room1Button   setTitle:@"" forState:UIControlStateNormal];
    [_room2Button   setTitle:@"" forState:UIControlStateNormal];
    
    [_labelTimeSlot1 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot2 setBackgroundColor:[UIColor clearColor]];
    [_lectureButton  setBackgroundColor:[UIColor clearColor]];
    [_room1Button    setBackgroundColor:[UIColor clearColor]];
    [_room2Button    setBackgroundColor:[UIColor clearColor]];
    [_cell           setBackgroundColor:[UIColor clearColor]];
    
    if ([self isActualDayAndTime:_actualDate:actualSelection]) 
    {    
        [_labelTimeSlot1 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot2 setBackgroundColor:[UIColor lightGrayColor]];
        [_lectureButton  setBackgroundColor:[UIColor lightGrayColor]];
        [_room1Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room2Button    setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    
    _labelTimeSlot1.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot1._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot1._endTime  ]
                            ];  
    _labelTimeSlot2.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot2._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot2._endTime  ]
                            ];  
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    
    [_room1Button   setTitle:_localRealization1._room._name  forState:UIControlStateNormal];
    [_room2Button   setTitle:_localRealization2._room._name  forState:UIControlStateNormal];
    [_lectureButton setTitle:actualScheduleEvent._name       forState:UIControlStateNormal];
    
    _lectureButton.enabled  = TRUE;
    _room1Button.enabled    = TRUE;    
    _room2Button.enabled    = TRUE;    
    _detailButton.enabled   = TRUE;
    
    [_room1Button   addTarget:self action:@selector(changeToRoomSchedule1   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room2Button   addTarget:self action:@selector(changeToRoomSchedule2   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_lectureButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [_detailButton  addTarget:self action:@selector(showScheduleDetails     :event:) forControlEvents:UIControlEventTouchUpInside];
    
    return _cell;        
}





- (UITableViewCell *)oneSlotThreeRooms:(UITableView *)actualTableView:(NSUInteger)actualSelection:(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"OneSlotThreeRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];

    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"OneSlotThreeRoomsTableCell" owner:self options:nil];
        _cell = _oneSlotThreeRoomsTableCell;
        self._oneSlotThreeRoomsTableCell = nil;
    }

    UILabel          *_labelTimeSlot1 = (UILabel  *)[_cell viewWithTag:1];
    UIButton         *_lectureButton  = (UIButton *)[_cell viewWithTag:2];  
    UIButton         *_room1Button    = (UIButton *)[_cell viewWithTag:3];  
    UIButton         *_room2Button    = (UIButton *)[_cell viewWithTag:4];  
    UIButton         *_room3Button    = (UIButton *)[_cell viewWithTag:5];  
    UIButton         *_detailButton   = (UIButton *)[_cell viewWithTag:6];  // with arrow image, leading to detail page

    // initially always disable detail button
    _detailButton.enabled  = FALSE;
    _lectureButton.enabled = FALSE;
    _room1Button.enabled   = FALSE;
    _room2Button.enabled   = FALSE;
    _room3Button.enabled   = FALSE;

    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    [_room1Button   setTitle:@"" forState:UIControlStateNormal];
    [_room2Button   setTitle:@"" forState:UIControlStateNormal];
    [_room3Button   setTitle:@"" forState:UIControlStateNormal];

    [_labelTimeSlot1 setBackgroundColor:[UIColor clearColor]];
    [_lectureButton  setBackgroundColor:[UIColor clearColor]];
    [_room1Button    setBackgroundColor:[UIColor clearColor]];
    [_room2Button    setBackgroundColor:[UIColor clearColor]];
    [_room3Button    setBackgroundColor:[UIColor clearColor]];
    [_cell           setBackgroundColor:[UIColor clearColor]];

    if ([self isActualDayAndTime:_actualDate:actualSelection]) 
    {    
        [_labelTimeSlot1 setBackgroundColor:[UIColor lightGrayColor]];
        [_lectureButton  setBackgroundColor:[UIColor lightGrayColor]];
        [_room1Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room2Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room3Button    setBackgroundColor:[UIColor lightGrayColor]];
    }

    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];

    _labelTimeSlot1.text = [NSString stringWithFormat:@"%@ - %@",  
                        [[self timeFormatter] stringFromDate:_timeSlot1._startTime],  
                        [[self timeFormatter] stringFromDate:_timeSlot1._endTime  ]
                        ];  

    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    
    [_room1Button   setTitle:_localRealization1._room._name  forState:UIControlStateNormal];
    [_room2Button   setTitle:_localRealization2._room._name  forState:UIControlStateNormal];
    [_room3Button   setTitle:_localRealization3._room._name  forState:UIControlStateNormal];
    [_lectureButton setTitle:actualScheduleEvent._name       forState:UIControlStateNormal];

    _lectureButton.enabled  = TRUE;
    _room1Button.enabled    = TRUE;    
    _room2Button.enabled    = TRUE;    
    _room3Button.enabled    = TRUE;    
    _detailButton.enabled   = TRUE;

    [_room1Button   addTarget:self action:@selector(changeToRoomSchedule1   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room2Button   addTarget:self action:@selector(changeToRoomSchedule2   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room3Button   addTarget:self action:@selector(changeToRoomSchedule3   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_lectureButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [_detailButton  addTarget:self action:@selector(showScheduleDetails     :event:) forControlEvents:UIControlEventTouchUpInside];

    return _cell;        
}

- (UITableViewCell *)oneSlotFiveRooms:(UITableView *)actualTableView:(NSUInteger)actualSelection:(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"OneSlotFiveRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"OneSlotFiveRoomsTableCell" owner:self options:nil];
        _cell = _oneSlotFiveRoomsTableCell;
        self._oneSlotFiveRoomsTableCell = nil;
    }
    
    UILabel          *_labelTimeSlot  = (UILabel  *)[_cell viewWithTag:1];
    
    UIButton         *_lectureButton  = (UIButton *)[_cell viewWithTag:2];
    UIButton         *_room1Button    = (UIButton *)[_cell viewWithTag:3];
    UIButton         *_room2Button    = (UIButton *)[_cell viewWithTag:4];
    UIButton         *_room3Button    = (UIButton *)[_cell viewWithTag:5];
    UIButton         *_room4Button    = (UIButton *)[_cell viewWithTag:6];
    UIButton         *_room5Button    = (UIButton *)[_cell viewWithTag:7];
    UIButton         *_detailButton   = (UIButton *)[_cell viewWithTag:8];  // with arrow image, leading to detail page
    
    
    // initially always disable detail button
    _detailButton.enabled  = FALSE;
    _lectureButton.enabled = FALSE;
    _room1Button.enabled   = FALSE;
    _room2Button.enabled   = FALSE;
    _room3Button.enabled   = FALSE;
    _room4Button.enabled   = FALSE;
    _room5Button.enabled   = FALSE;
    
    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    [_room1Button   setTitle:@"" forState:UIControlStateNormal];
    [_room2Button   setTitle:@"" forState:UIControlStateNormal];
    [_room3Button   setTitle:@"" forState:UIControlStateNormal];
    [_room4Button   setTitle:@"" forState:UIControlStateNormal];
    [_room5Button   setTitle:@"" forState:UIControlStateNormal];
    
    [_labelTimeSlot  setBackgroundColor:[UIColor clearColor]];
    [_lectureButton  setBackgroundColor:[UIColor clearColor]];
    [_room1Button    setBackgroundColor:[UIColor clearColor]];
    [_room2Button    setBackgroundColor:[UIColor clearColor]];
    [_room3Button    setBackgroundColor:[UIColor clearColor]];
    [_room4Button    setBackgroundColor:[UIColor clearColor]];
    [_room5Button    setBackgroundColor:[UIColor clearColor]];
    [_cell           setBackgroundColor:[UIColor clearColor]];
    
    
    if ([self isActualDayAndTime:_actualDate:actualSelection])
    {
        [_labelTimeSlot  setBackgroundColor:[UIColor lightGrayColor]];
        [_lectureButton  setBackgroundColor:[UIColor lightGrayColor]];
        [_room1Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room2Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room3Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room4Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room5Button    setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    SlotDto *_timeSlot = [actualScheduleEvent._slots objectAtIndex:0];
    
    
    _labelTimeSlot.text = [NSString stringWithFormat:@"%@ - %@",
                           [[self timeFormatter] stringFromDate:_timeSlot._startTime],
                           [[self timeFormatter] stringFromDate:_timeSlot._endTime  ]
                           ];
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    ScheduleEventRealizationDto *_localRealization4 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:3];
    ScheduleEventRealizationDto *_localRealization5 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:4];
    
    [_room1Button   setTitle:_localRealization1._room._name  forState:UIControlStateNormal];
    [_room2Button   setTitle:_localRealization2._room._name  forState:UIControlStateNormal];
    [_room3Button   setTitle:_localRealization3._room._name  forState:UIControlStateNormal];
    [_room4Button   setTitle:_localRealization4._room._name  forState:UIControlStateNormal];
    [_room5Button   setTitle:_localRealization5._room._name  forState:UIControlStateNormal];
    
    [_lectureButton setTitle:actualScheduleEvent._name       forState:UIControlStateNormal];
    
    _lectureButton.enabled  = TRUE;
    _room1Button.enabled    = TRUE;
    _room2Button.enabled    = TRUE;
    _room3Button.enabled    = TRUE;
    _room4Button.enabled    = TRUE;
    _room5Button.enabled    = TRUE;
    _detailButton.enabled   = TRUE;
    
    [_room1Button   addTarget:self action:@selector(changeToRoomSchedule1   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room2Button   addTarget:self action:@selector(changeToRoomSchedule2   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room3Button   addTarget:self action:@selector(changeToRoomSchedule3   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room4Button   addTarget:self action:@selector(changeToRoomSchedule4   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room5Button   addTarget:self action:@selector(changeToRoomSchedule5   :event:) forControlEvents:UIControlEventTouchUpInside];
    
    [_lectureButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [_detailButton  addTarget:self action:@selector(showScheduleDetails     :event:) forControlEvents:UIControlEventTouchUpInside];
    
    return _cell;
}



- (UITableViewCell *)oneSlotFourRooms:(UITableView *)actualTableView:(NSUInteger)actualSelection:(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"OneSlotFourRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"OneSlotFourRoomsTableCell" owner:self options:nil];
        _cell = _oneSlotFourRoomsTableCell;
        self._oneSlotFourRoomsTableCell = nil;
    }
    
    UILabel          *_labelTimeSlot  = (UILabel  *)[_cell viewWithTag:1];
    UIButton         *_lectureButton  = (UIButton *)[_cell viewWithTag:2];  
    UIButton         *_room1Button    = (UIButton *)[_cell viewWithTag:3];  
    UIButton         *_room2Button    = (UIButton *)[_cell viewWithTag:4];  
    UIButton         *_room3Button    = (UIButton *)[_cell viewWithTag:5];  
    UIButton         *_room4Button    = (UIButton *)[_cell viewWithTag:6];  
    UIButton         *_detailButton   = (UIButton *)[_cell viewWithTag:7];
    
    
    // initially always disable detail button
    _detailButton.enabled  = FALSE;
    _lectureButton.enabled = FALSE;
    _room1Button.enabled   = FALSE;
    _room2Button.enabled   = FALSE;
    _room3Button.enabled   = FALSE;
    _room4Button.enabled   = FALSE;
    
    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    [_room1Button   setTitle:@"" forState:UIControlStateNormal];
    [_room2Button   setTitle:@"" forState:UIControlStateNormal];
    [_room3Button   setTitle:@"" forState:UIControlStateNormal];
    [_room4Button   setTitle:@"" forState:UIControlStateNormal];
    
    [_labelTimeSlot  setBackgroundColor:[UIColor clearColor]];
    [_lectureButton  setBackgroundColor:[UIColor clearColor]];
    [_room1Button    setBackgroundColor:[UIColor clearColor]];
    [_room2Button    setBackgroundColor:[UIColor clearColor]];
    [_room3Button    setBackgroundColor:[UIColor clearColor]];
    [_room4Button    setBackgroundColor:[UIColor clearColor]];
    [_cell           setBackgroundColor:[UIColor clearColor]];
    
    
    if ([self isActualDayAndTime:_actualDate:actualSelection]) 
    {    
        [_labelTimeSlot  setBackgroundColor:[UIColor lightGrayColor]];
        [_lectureButton  setBackgroundColor:[UIColor lightGrayColor]];
        [_room1Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room2Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room3Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room4Button    setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    SlotDto *_timeSlot = [actualScheduleEvent._slots objectAtIndex:0];
    
    
    _labelTimeSlot.text = [NSString stringWithFormat:@"%@ - %@",  
                           [[self timeFormatter] stringFromDate:_timeSlot._startTime],  
                           [[self timeFormatter] stringFromDate:_timeSlot._endTime  ]
                           ];  
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    ScheduleEventRealizationDto *_localRealization4 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:3];
    
    [_room1Button   setTitle:_localRealization1._room._name  forState:UIControlStateNormal];
    [_room2Button   setTitle:_localRealization2._room._name  forState:UIControlStateNormal];
    [_room3Button   setTitle:_localRealization3._room._name  forState:UIControlStateNormal];
    [_room4Button   setTitle:_localRealization4._room._name  forState:UIControlStateNormal];
    
    [_lectureButton setTitle:actualScheduleEvent._name       forState:UIControlStateNormal];
    
    _lectureButton.enabled  = TRUE;
    _room1Button.enabled    = TRUE;    
    _room2Button.enabled    = TRUE;    
    _room3Button.enabled    = TRUE;    
    _room4Button.enabled    = TRUE;    
    _detailButton.enabled   = TRUE;
    
    [_room1Button   addTarget:self action:@selector(changeToRoomSchedule1   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room2Button   addTarget:self action:@selector(changeToRoomSchedule2   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room3Button   addTarget:self action:@selector(changeToRoomSchedule3   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room4Button   addTarget:self action:@selector(changeToRoomSchedule4   :event:) forControlEvents:UIControlEventTouchUpInside];
    
    [_lectureButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [_detailButton  addTarget:self action:@selector(showScheduleDetails     :event:) forControlEvents:UIControlEventTouchUpInside];
    
    return _cell;        
}


- (UITableViewCell *)oneSlotSixRooms:(UITableView *)actualTableView:(NSUInteger)actualSelection:(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"OneSlotSixRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"OneSlotSixRoomsTableCell" owner:self options:nil];
        _cell = _oneSlotSixRoomsTableCell;
        self._oneSlotSixRoomsTableCell = nil;
    }
    
    UILabel          *_labelTimeSlot  = (UILabel  *)[_cell viewWithTag:1];
    UIButton         *_lectureButton  = (UIButton *)[_cell viewWithTag:2];  
    UIButton         *_room1Button    = (UIButton *)[_cell viewWithTag:3];  
    UIButton         *_room2Button    = (UIButton *)[_cell viewWithTag:4];  
    UIButton         *_room3Button    = (UIButton *)[_cell viewWithTag:5];  
    UIButton         *_room4Button    = (UIButton *)[_cell viewWithTag:6];  
    UIButton         *_room5Button    = (UIButton *)[_cell viewWithTag:7];  
    UIButton         *_room6Button    = (UIButton *)[_cell viewWithTag:8];   
    UIButton         *_detailButton   = (UIButton *)[_cell viewWithTag:9];  // with arrow image, leading to detail page
    
    
    // initially always disable detail button
    _detailButton.enabled  = FALSE;
    _lectureButton.enabled = FALSE;
    _room1Button.enabled   = FALSE;
    _room2Button.enabled   = FALSE;
    _room3Button.enabled   = FALSE;
    _room4Button.enabled   = FALSE;
    _room5Button.enabled   = FALSE;
    _room6Button.enabled   = FALSE;
    
    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    [_room1Button   setTitle:@"" forState:UIControlStateNormal];
    [_room2Button   setTitle:@"" forState:UIControlStateNormal];
    [_room3Button   setTitle:@"" forState:UIControlStateNormal];
    [_room4Button   setTitle:@"" forState:UIControlStateNormal];
    [_room5Button   setTitle:@"" forState:UIControlStateNormal];
    [_room6Button   setTitle:@"" forState:UIControlStateNormal];
    
    [_labelTimeSlot  setBackgroundColor:[UIColor clearColor]];
    [_lectureButton  setBackgroundColor:[UIColor clearColor]];
    [_room1Button    setBackgroundColor:[UIColor clearColor]];
    [_room2Button    setBackgroundColor:[UIColor clearColor]];
    [_room3Button    setBackgroundColor:[UIColor clearColor]];
    [_room4Button    setBackgroundColor:[UIColor clearColor]];
    [_room5Button    setBackgroundColor:[UIColor clearColor]];
    [_room6Button    setBackgroundColor:[UIColor clearColor]];
    [_cell           setBackgroundColor:[UIColor clearColor]];
    
    
    if ([self isActualDayAndTime:_actualDate:actualSelection]) 
    {    
        [_labelTimeSlot  setBackgroundColor:[UIColor lightGrayColor]];
        [_lectureButton  setBackgroundColor:[UIColor lightGrayColor]];
        [_room1Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room2Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room3Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room4Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room5Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room6Button    setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    SlotDto *_timeSlot = [actualScheduleEvent._slots objectAtIndex:0];
    
    
    _labelTimeSlot.text = [NSString stringWithFormat:@"%@ - %@",  
                           [[self timeFormatter] stringFromDate:_timeSlot._startTime],  
                           [[self timeFormatter] stringFromDate:_timeSlot._endTime  ]
                           ];  
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    ScheduleEventRealizationDto *_localRealization4 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:3];
    ScheduleEventRealizationDto *_localRealization5 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:4];
    ScheduleEventRealizationDto *_localRealization6 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:5];
    
    [_room1Button   setTitle:_localRealization1._room._name  forState:UIControlStateNormal];
    [_room2Button   setTitle:_localRealization2._room._name  forState:UIControlStateNormal];
    [_room3Button   setTitle:_localRealization3._room._name  forState:UIControlStateNormal];
    [_room4Button   setTitle:_localRealization4._room._name  forState:UIControlStateNormal];
    [_room5Button   setTitle:_localRealization5._room._name  forState:UIControlStateNormal];
    [_room6Button   setTitle:_localRealization6._room._name  forState:UIControlStateNormal];
    
    [_lectureButton setTitle:actualScheduleEvent._name       forState:UIControlStateNormal];
    
    _lectureButton.enabled  = TRUE;
    _room1Button.enabled    = TRUE;    
    _room2Button.enabled    = TRUE;    
    _room3Button.enabled    = TRUE;    
    _room4Button.enabled    = TRUE;    
    _room5Button.enabled    = TRUE;    
    _room6Button.enabled    = TRUE;    
    _detailButton.enabled   = TRUE;
    
    [_room1Button   addTarget:self action:@selector(changeToRoomSchedule1   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room2Button   addTarget:self action:@selector(changeToRoomSchedule2   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room3Button   addTarget:self action:@selector(changeToRoomSchedule3   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room4Button   addTarget:self action:@selector(changeToRoomSchedule4   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room5Button   addTarget:self action:@selector(changeToRoomSchedule5   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room6Button   addTarget:self action:@selector(changeToRoomSchedule6   :event:) forControlEvents:UIControlEventTouchUpInside];
    
    [_lectureButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [_detailButton  addTarget:self action:@selector(showScheduleDetails     :event:) forControlEvents:UIControlEventTouchUpInside];
    
    return _cell;        
}



- (UITableViewCell *)oneSlotSevenRooms:(UITableView *)actualTableView:(NSUInteger)actualSelection:(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"OneSlotSevenRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"OneSlotSevenRoomsTableCell" owner:self options:nil];
        _cell = _oneSlotSevenRoomsTableCell;
        self._oneSlotSevenRoomsTableCell = nil;
    }
    
    UILabel          *_labelTimeSlot  = (UILabel  *)[_cell viewWithTag:1];
    UIButton         *_lectureButton  = (UIButton *)[_cell viewWithTag:2];
    UIButton         *_room1Button    = (UIButton *)[_cell viewWithTag:3];
    UIButton         *_room2Button    = (UIButton *)[_cell viewWithTag:4];
    UIButton         *_room3Button    = (UIButton *)[_cell viewWithTag:5];
    UIButton         *_room4Button    = (UIButton *)[_cell viewWithTag:6];
    UIButton         *_room5Button    = (UIButton *)[_cell viewWithTag:7];
    UIButton         *_room6Button    = (UIButton *)[_cell viewWithTag:8];
    UIButton         *_room7Button    = (UIButton *)[_cell viewWithTag:9];
    UIButton         *_detailButton   = (UIButton *)[_cell viewWithTag:10];
    
    // initially always disable detail button
    _detailButton.enabled  = FALSE;
    _lectureButton.enabled = FALSE;
    _room1Button.enabled   = FALSE;
    _room2Button.enabled   = FALSE;
    _room3Button.enabled   = FALSE;
    _room4Button.enabled   = FALSE;
    _room5Button.enabled   = FALSE;
    _room6Button.enabled   = FALSE;
    _room7Button.enabled   = FALSE;
    
    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    [_room1Button   setTitle:@"" forState:UIControlStateNormal];
    [_room2Button   setTitle:@"" forState:UIControlStateNormal];
    [_room3Button   setTitle:@"" forState:UIControlStateNormal];
    [_room4Button   setTitle:@"" forState:UIControlStateNormal];
    [_room5Button   setTitle:@"" forState:UIControlStateNormal];
    [_room6Button   setTitle:@"" forState:UIControlStateNormal];
    [_room7Button   setTitle:@"" forState:UIControlStateNormal];
    
    [_labelTimeSlot  setBackgroundColor:[UIColor clearColor]];
    [_lectureButton  setBackgroundColor:[UIColor clearColor]];
    [_room1Button    setBackgroundColor:[UIColor clearColor]];
    [_room2Button    setBackgroundColor:[UIColor clearColor]];
    [_room3Button    setBackgroundColor:[UIColor clearColor]];
    [_room4Button    setBackgroundColor:[UIColor clearColor]];
    [_room5Button    setBackgroundColor:[UIColor clearColor]];
    [_room6Button    setBackgroundColor:[UIColor clearColor]];
    [_room7Button    setBackgroundColor:[UIColor clearColor]];
    [_cell           setBackgroundColor:[UIColor clearColor]];
    
    
    if ([self isActualDayAndTime:_actualDate:actualSelection])
    {
        [_labelTimeSlot  setBackgroundColor:[UIColor lightGrayColor]];
        [_lectureButton  setBackgroundColor:[UIColor lightGrayColor]];
        [_room1Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room2Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room3Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room4Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room5Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room6Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room7Button    setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    SlotDto *_timeSlot = [actualScheduleEvent._slots objectAtIndex:0];
    
    
    _labelTimeSlot.text = [NSString stringWithFormat:@"%@ - %@",
                           [[self timeFormatter] stringFromDate:_timeSlot._startTime],
                           [[self timeFormatter] stringFromDate:_timeSlot._endTime  ]
                           ];
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    ScheduleEventRealizationDto *_localRealization4 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:3];
    ScheduleEventRealizationDto *_localRealization5 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:4];
    ScheduleEventRealizationDto *_localRealization6 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:5];
    ScheduleEventRealizationDto *_localRealization7 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:6];
    
    [_room1Button   setTitle:_localRealization1._room._name  forState:UIControlStateNormal];
    [_room2Button   setTitle:_localRealization2._room._name  forState:UIControlStateNormal];
    [_room3Button   setTitle:_localRealization3._room._name  forState:UIControlStateNormal];
    [_room4Button   setTitle:_localRealization4._room._name  forState:UIControlStateNormal];
    [_room5Button   setTitle:_localRealization5._room._name  forState:UIControlStateNormal];
    [_room6Button   setTitle:_localRealization6._room._name  forState:UIControlStateNormal];
    [_room7Button   setTitle:_localRealization7._room._name  forState:UIControlStateNormal];
    
    [_lectureButton setTitle:actualScheduleEvent._name       forState:UIControlStateNormal];
    
    _lectureButton.enabled  = TRUE;
    _room1Button.enabled    = TRUE;
    _room2Button.enabled    = TRUE;
    _room3Button.enabled    = TRUE;
    _room4Button.enabled    = TRUE;
    _room5Button.enabled    = TRUE;
    _room6Button.enabled    = TRUE;
    _room7Button.enabled    = TRUE;
    _detailButton.enabled   = TRUE;
    
    [_room1Button   addTarget:self action:@selector(changeToRoomSchedule1   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room2Button   addTarget:self action:@selector(changeToRoomSchedule2   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room3Button   addTarget:self action:@selector(changeToRoomSchedule3   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room4Button   addTarget:self action:@selector(changeToRoomSchedule4   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room5Button   addTarget:self action:@selector(changeToRoomSchedule5   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room6Button   addTarget:self action:@selector(changeToRoomSchedule6   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room7Button   addTarget:self action:@selector(changeToRoomSchedule7   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_lectureButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [_detailButton  addTarget:self action:@selector(showScheduleDetails     :event:) forControlEvents:UIControlEventTouchUpInside];
    
    return _cell;
}



- (UITableViewCell *)oneSlotEightRooms:(UITableView *)actualTableView:(NSUInteger)actualSelection:(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"OneSlotEightRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"OneSlotEightRoomsTableCell" owner:self options:nil];
        _cell = _oneSlotEightRoomsTableCell;
        self._oneSlotEightRoomsTableCell = nil;
    }
    
    UILabel          *_labelTimeSlot  = (UILabel  *)[_cell viewWithTag:1];
    
    UIButton         *_lectureButton  = (UIButton *)[_cell viewWithTag:2];  
    UIButton         *_room1Button    = (UIButton *)[_cell viewWithTag:3];  
    UIButton         *_room2Button    = (UIButton *)[_cell viewWithTag:4];  
    UIButton         *_room3Button    = (UIButton *)[_cell viewWithTag:5];  
    UIButton         *_room4Button    = (UIButton *)[_cell viewWithTag:6];  
    UIButton         *_room5Button    = (UIButton *)[_cell viewWithTag:7];  
    UIButton         *_room6Button    = (UIButton *)[_cell viewWithTag:8];  
    UIButton         *_room7Button    = (UIButton *)[_cell viewWithTag:9];  
    UIButton         *_room8Button    = (UIButton *)[_cell viewWithTag:10];  
    UIButton         *_detailButton   = (UIButton *)[_cell viewWithTag:11];  // with arrow image, leading to detail page
    
    
    // initially always disable detail button
    _detailButton.enabled  = FALSE;
    _lectureButton.enabled = FALSE;
    _room1Button.enabled   = FALSE;
    _room2Button.enabled   = FALSE;
    _room3Button.enabled   = FALSE;
    _room4Button.enabled   = FALSE;
    _room5Button.enabled   = FALSE;
    _room6Button.enabled   = FALSE;
    _room7Button.enabled   = FALSE;
    _room8Button.enabled   = FALSE;
    
    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    [_room1Button   setTitle:@"" forState:UIControlStateNormal];
    [_room2Button   setTitle:@"" forState:UIControlStateNormal];
    [_room3Button   setTitle:@"" forState:UIControlStateNormal];
    [_room4Button   setTitle:@"" forState:UIControlStateNormal];
    [_room5Button   setTitle:@"" forState:UIControlStateNormal];
    [_room6Button   setTitle:@"" forState:UIControlStateNormal];
    [_room7Button   setTitle:@"" forState:UIControlStateNormal];
    [_room8Button   setTitle:@"" forState:UIControlStateNormal];
    
    [_labelTimeSlot  setBackgroundColor:[UIColor clearColor]];
    [_lectureButton  setBackgroundColor:[UIColor clearColor]];
    [_room1Button    setBackgroundColor:[UIColor clearColor]];
    [_room2Button    setBackgroundColor:[UIColor clearColor]];
    [_room3Button    setBackgroundColor:[UIColor clearColor]];
    [_room4Button    setBackgroundColor:[UIColor clearColor]];
    [_room5Button    setBackgroundColor:[UIColor clearColor]];
    [_room6Button    setBackgroundColor:[UIColor clearColor]];
    [_room7Button    setBackgroundColor:[UIColor clearColor]];
    [_room8Button    setBackgroundColor:[UIColor clearColor]];
    [_cell           setBackgroundColor:[UIColor clearColor]];
    
    
    if ([self isActualDayAndTime:_actualDate:actualSelection]) 
    {    
        [_labelTimeSlot  setBackgroundColor:[UIColor lightGrayColor]];
        [_lectureButton  setBackgroundColor:[UIColor lightGrayColor]];
        [_room1Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room2Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room3Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room4Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room5Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room6Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room7Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room8Button    setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    SlotDto *_timeSlot = [actualScheduleEvent._slots objectAtIndex:0];
    
    
    _labelTimeSlot.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot._endTime  ]
                            ];  
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    ScheduleEventRealizationDto *_localRealization4 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:3];
    ScheduleEventRealizationDto *_localRealization5 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:4];
    ScheduleEventRealizationDto *_localRealization6 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:5];
    ScheduleEventRealizationDto *_localRealization7 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:6];
    ScheduleEventRealizationDto *_localRealization8 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:7];
    
    [_room1Button   setTitle:_localRealization1._room._name  forState:UIControlStateNormal];
    [_room2Button   setTitle:_localRealization2._room._name  forState:UIControlStateNormal];
    [_room3Button   setTitle:_localRealization3._room._name  forState:UIControlStateNormal];
    [_room4Button   setTitle:_localRealization4._room._name  forState:UIControlStateNormal];
    [_room5Button   setTitle:_localRealization5._room._name  forState:UIControlStateNormal];
    [_room6Button   setTitle:_localRealization6._room._name  forState:UIControlStateNormal];
    [_room7Button   setTitle:_localRealization7._room._name  forState:UIControlStateNormal];
    [_room8Button   setTitle:_localRealization8._room._name  forState:UIControlStateNormal];

    [_lectureButton setTitle:actualScheduleEvent._name       forState:UIControlStateNormal];
    
    _lectureButton.enabled  = TRUE;
    _room1Button.enabled    = TRUE;    
    _room2Button.enabled    = TRUE;    
    _room3Button.enabled    = TRUE;    
    _room4Button.enabled    = TRUE;    
    _room5Button.enabled    = TRUE;    
    _room6Button.enabled    = TRUE;    
    _room7Button.enabled    = TRUE;    
    _room8Button.enabled    = TRUE;    
    _detailButton.enabled   = TRUE;
    
    [_room1Button   addTarget:self action:@selector(changeToRoomSchedule1   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room2Button   addTarget:self action:@selector(changeToRoomSchedule2   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room3Button   addTarget:self action:@selector(changeToRoomSchedule3   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room4Button   addTarget:self action:@selector(changeToRoomSchedule4   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room5Button   addTarget:self action:@selector(changeToRoomSchedule5   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room6Button   addTarget:self action:@selector(changeToRoomSchedule6   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room7Button   addTarget:self action:@selector(changeToRoomSchedule7   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room8Button   addTarget:self action:@selector(changeToRoomSchedule8   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_lectureButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [_detailButton  addTarget:self action:@selector(showScheduleDetails     :event:) forControlEvents:UIControlEventTouchUpInside];
    
    return _cell;        
}

- (UITableViewCell *)threeSlotsTwoRooms:(UITableView *)actualTableView:(NSUInteger)actualSelection:(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"ThreeSlotsTwoRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"ThreeSlotsTwoRoomsTableCell" owner:self options:nil];
        _cell = _threeSlotsTwoRoomsTableCell;
        self._threeSlotsTwoRoomsTableCell = nil;
    }
    
    UILabel          *_labelTimeSlot1 = (UILabel  *)[_cell viewWithTag:1];
    UILabel          *_labelTimeSlot2 = (UILabel  *)[_cell viewWithTag:2];
    UILabel          *_labelTimeSlot3 = (UILabel  *)[_cell viewWithTag:3];
    UIButton         *_lectureButton  = (UIButton *)[_cell viewWithTag:4];
    UIButton         *_room1Button    = (UIButton *)[_cell viewWithTag:5];
    UIButton         *_room2Button    = (UIButton *)[_cell viewWithTag:6];
    UIButton         *_detailButton   = (UIButton *)[_cell viewWithTag:7];  // with arrow image, leading to detail page
    
    // initially always disable detail button
    _detailButton.enabled  = FALSE;
    _lectureButton.enabled = FALSE;
    _room1Button.enabled   = FALSE;
    _room2Button.enabled   = FALSE;
    
    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    [_room1Button   setTitle:@"" forState:UIControlStateNormal];
    [_room2Button   setTitle:@"" forState:UIControlStateNormal];
    
    [_labelTimeSlot1 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot2 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot3 setBackgroundColor:[UIColor clearColor]];
    [_lectureButton  setBackgroundColor:[UIColor clearColor]];
    [_room1Button    setBackgroundColor:[UIColor clearColor]];
    [_room2Button    setBackgroundColor:[UIColor clearColor]];
    [_cell           setBackgroundColor:[UIColor clearColor]];
    
    if ([self isActualDayAndTime:_actualDate:actualSelection])
    {
        [_labelTimeSlot1 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot2 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot3 setBackgroundColor:[UIColor lightGrayColor]];
        [_lectureButton  setBackgroundColor:[UIColor lightGrayColor]];
        [_room1Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room2Button    setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    
    _labelTimeSlot1.text = [NSString stringWithFormat:@"%@ - %@",
                            [[self timeFormatter] stringFromDate:_timeSlot1._startTime],
                            [[self timeFormatter] stringFromDate:_timeSlot1._endTime  ]
                            ];
    _labelTimeSlot2.text = [NSString stringWithFormat:@"%@ - %@",
                            [[self timeFormatter] stringFromDate:_timeSlot2._startTime],
                            [[self timeFormatter] stringFromDate:_timeSlot2._endTime  ]
                            ];
    _labelTimeSlot3.text = [NSString stringWithFormat:@"%@ - %@",
                            [[self timeFormatter] stringFromDate:_timeSlot3._startTime],
                            [[self timeFormatter] stringFromDate:_timeSlot3._endTime  ]
                            ];
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    
    [_room1Button   setTitle:_localRealization1._room._name  forState:UIControlStateNormal];
    [_room2Button   setTitle:_localRealization2._room._name  forState:UIControlStateNormal];
    [_lectureButton setTitle:actualScheduleEvent._name       forState:UIControlStateNormal];
    
    _lectureButton.enabled  = TRUE;
    _room1Button.enabled    = TRUE;
    _room2Button.enabled    = TRUE;
    _detailButton.enabled   = TRUE;
    
    [_room1Button   addTarget:self action:@selector(changeToRoomSchedule1   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room2Button   addTarget:self action:@selector(changeToRoomSchedule2   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_lectureButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [_detailButton  addTarget:self action:@selector(showScheduleDetails     :event:) forControlEvents:UIControlEventTouchUpInside];
    
    return _cell;
}




- (UITableViewCell *)fourSlots:(UITableView *)actualTableView:(NSUInteger)actualSelection:(ScheduleEventDto *)actualScheduleEvent
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
    
    UILabel          *_labelTimeSlot1 = (UILabel  *)[_cell viewWithTag:1];
    UILabel          *_labelTimeSlot2 = (UILabel  *)[_cell viewWithTag:2];
    UILabel          *_labelTimeSlot3 = (UILabel  *)[_cell viewWithTag:3];
    UILabel          *_labelTimeSlot4 = (UILabel  *)[_cell viewWithTag:4];

    UIButton         *_lectureButton  = (UIButton *)[_cell viewWithTag:5];  
    UIButton         *_roomButton     = (UIButton *)[_cell viewWithTag:6];  
    UIButton         *_detailButton   = (UIButton *)[_cell viewWithTag:7];  // with arrow image, leading to detail page
    
    
    // initially always disable detail button
    _detailButton.enabled  = FALSE;
    _lectureButton.enabled = FALSE;
    _roomButton.enabled    = FALSE;
    
    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    [_roomButton    setTitle:@"" forState:UIControlStateNormal];
    
    [_labelTimeSlot1 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot2 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot3 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot4 setBackgroundColor:[UIColor clearColor]];
    [_lectureButton  setBackgroundColor:[UIColor clearColor]];
    [_roomButton     setBackgroundColor:[UIColor clearColor]];
    [_cell           setBackgroundColor:[UIColor clearColor]];
    
    
    if ([self isActualDayAndTime:_actualDate:actualSelection]) 
    {    
        [_labelTimeSlot1 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot2 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot3 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot4 setBackgroundColor:[UIColor lightGrayColor]];
        [_lectureButton  setBackgroundColor:[UIColor lightGrayColor]];
        [_roomButton     setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    SlotDto *_timeSlot4 = [actualScheduleEvent._slots objectAtIndex:3];
    
    
    _labelTimeSlot1.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot1._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot1._endTime  ]
                            ];  
    _labelTimeSlot2.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot2._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot2._endTime  ]
                            ];  
    _labelTimeSlot3.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot3._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot3._endTime  ]
                            ];  
    _labelTimeSlot4.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot4._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot4._endTime  ]
                            ];  

    _lectureButton.enabled  = TRUE;
    _roomButton.enabled     = TRUE;    
    _detailButton.enabled   = TRUE;
    
    ScheduleEventRealizationDto *_localRealization = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    [_roomButton    setTitle:_localRealization._room._name  forState:UIControlStateNormal];
    [_lectureButton setTitle:actualScheduleEvent._name      forState:UIControlStateNormal];

    [_roomButton    addTarget:self action:@selector(changeToRoomSchedule1   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_lectureButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [_detailButton  addTarget:self action:@selector(showScheduleDetails     :event:) forControlEvents:UIControlEventTouchUpInside];
    
    return _cell;        
}



- (UITableViewCell *)fiveSlotsOneRoom:(UITableView *)actualTableView:(NSUInteger)actualSelection:(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"FiveSlotsOneRoomTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"FiveSlotsOneRoomTableCell" owner:self options:nil];
        _cell = _fiveSlotsOneRoomTableCell; 
        self._fiveSlotsOneRoomTableCell = nil;
    }
    
    UILabel          *_labelTimeSlot1 = (UILabel  *)[_cell viewWithTag:1];
    UILabel          *_labelTimeSlot2 = (UILabel  *)[_cell viewWithTag:2];
    UILabel          *_labelTimeSlot3 = (UILabel  *)[_cell viewWithTag:3];
    UILabel          *_labelTimeSlot4 = (UILabel  *)[_cell viewWithTag:4];
    UILabel          *_labelTimeSlot5 = (UILabel  *)[_cell viewWithTag:5];
    UIButton         *_lectureButton  = (UIButton *)[_cell viewWithTag:6];  
    UIButton         *_roomButton     = (UIButton *)[_cell viewWithTag:7];  
    UIButton         *_detailButton   = (UIButton *)[_cell viewWithTag:8];  // with arrow image, leading to detail page
    
    // initially always disable detail button
    _detailButton.enabled  = FALSE;
    _lectureButton.enabled = FALSE;
    _roomButton.enabled    = FALSE;
    
    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    [_roomButton    setTitle:@"" forState:UIControlStateNormal];
    
    [_labelTimeSlot1 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot2 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot3 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot4 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot5 setBackgroundColor:[UIColor clearColor]];
    [_lectureButton  setBackgroundColor:[UIColor clearColor]];
    [_roomButton     setBackgroundColor:[UIColor clearColor]];
    [_cell           setBackgroundColor:[UIColor clearColor]];
    
    if ([self isActualDayAndTime:_actualDate:actualSelection]) 
    {    
        [_labelTimeSlot1 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot2 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot3 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot4 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot5 setBackgroundColor:[UIColor lightGrayColor]];
        [_lectureButton  setBackgroundColor:[UIColor lightGrayColor]];
        [_roomButton     setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    SlotDto *_timeSlot4 = [actualScheduleEvent._slots objectAtIndex:3];
    SlotDto *_timeSlot5 = [actualScheduleEvent._slots objectAtIndex:4];
    
    _labelTimeSlot1.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot1._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot1._endTime  ]
                            ];  
    _labelTimeSlot2.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot2._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot2._endTime  ]
                            ];  
    _labelTimeSlot3.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot3._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot3._endTime  ]
                            ];  
    _labelTimeSlot4.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot4._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot4._endTime  ]
                            ];     

    _labelTimeSlot5.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot5._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot5._endTime  ]
                            ];         
    
    ScheduleEventRealizationDto *_localRealization = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    
    [_roomButton    setTitle:_localRealization._room._name  forState:UIControlStateNormal];
    [_lectureButton setTitle:actualScheduleEvent._name       forState:UIControlStateNormal];
    
    _lectureButton.enabled  = TRUE;
    _roomButton.enabled     = TRUE;      
    _detailButton.enabled   = TRUE;
    
    [_roomButton    addTarget:self action:@selector(changeToRoomSchedule1   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_lectureButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [_detailButton  addTarget:self action:@selector(showScheduleDetails     :event:) forControlEvents:UIControlEventTouchUpInside];
    
    return _cell;        
}



- (UITableViewCell *)fourSlotsTwoRooms:(UITableView *)actualTableView:(NSUInteger)actualSelection:(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"FourSlotsTwoRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"FourSlotsTwoRoomsTableCell" owner:self options:nil];
        _cell = _fourSlotsTwoRoomsTableCell; 
        self._fourSlotsTwoRoomsTableCell = nil;
    }
    
    UILabel          *_labelTimeSlot1 = (UILabel  *)[_cell viewWithTag:1];
    UILabel          *_labelTimeSlot2 = (UILabel  *)[_cell viewWithTag:2];
    UILabel          *_labelTimeSlot3 = (UILabel  *)[_cell viewWithTag:3];
    UILabel          *_labelTimeSlot4 = (UILabel  *)[_cell viewWithTag:4];
    UIButton         *_lectureButton  = (UIButton *)[_cell viewWithTag:5];  
    UIButton         *_room1Button    = (UIButton *)[_cell viewWithTag:6];  
    UIButton         *_room2Button    = (UIButton *)[_cell viewWithTag:7];  
    UIButton         *_detailButton   = (UIButton *)[_cell viewWithTag:8];  // with arrow image, leading to detail page
    
    // initially always disable detail button
    _detailButton.enabled  = FALSE;
    _lectureButton.enabled = FALSE;
    _room1Button.enabled   = FALSE;
    _room2Button.enabled   = FALSE;
    
    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    [_room1Button   setTitle:@"" forState:UIControlStateNormal];
    [_room2Button   setTitle:@"" forState:UIControlStateNormal];
    
    [_labelTimeSlot1 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot2 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot3 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot4 setBackgroundColor:[UIColor clearColor]];
    [_lectureButton  setBackgroundColor:[UIColor clearColor]];
    [_room1Button    setBackgroundColor:[UIColor clearColor]];
    [_room2Button    setBackgroundColor:[UIColor clearColor]];
    [_cell           setBackgroundColor:[UIColor clearColor]];
    
    if ([self isActualDayAndTime:_actualDate:actualSelection]) 
    {    
        [_labelTimeSlot1 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot2 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot3 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot4 setBackgroundColor:[UIColor lightGrayColor]];
        [_lectureButton  setBackgroundColor:[UIColor lightGrayColor]];
        [_room1Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room2Button    setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    SlotDto *_timeSlot4 = [actualScheduleEvent._slots objectAtIndex:3];
    
    _labelTimeSlot1.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot1._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot1._endTime  ]
                            ];  
    _labelTimeSlot2.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot2._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot2._endTime  ]
                            ];  
    _labelTimeSlot3.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot3._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot3._endTime  ]
                            ];  
    _labelTimeSlot4.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot4._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot4._endTime  ]
                            ];     
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    
    [_room1Button   setTitle:_localRealization1._room._name  forState:UIControlStateNormal];
    [_room2Button   setTitle:_localRealization2._room._name  forState:UIControlStateNormal];
    [_lectureButton setTitle:actualScheduleEvent._name       forState:UIControlStateNormal];
    
    _lectureButton.enabled  = TRUE;
    _room1Button.enabled    = TRUE;    
    _room2Button.enabled    = TRUE;    
    _detailButton.enabled   = TRUE;
    
    [_room1Button   addTarget:self action:@selector(changeToRoomSchedule1   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room2Button   addTarget:self action:@selector(changeToRoomSchedule2   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_lectureButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [_detailButton  addTarget:self action:@selector(showScheduleDetails     :event:) forControlEvents:UIControlEventTouchUpInside];
    
    return _cell;        
}


- (UITableViewCell *)threeSlotsThreeRooms:(UITableView *)actualTableView:(NSUInteger)actualSelection:(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"ThreeSlotsThreeRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"ThreeSlotsThreeRoomsTableCell" owner:self options:nil];
        _cell = _threeSlotsThreeRoomsTableCell;
        self._threeSlotsThreeRoomsTableCell = nil;
    }
    
    UILabel          *_labelTimeSlot1 = (UILabel  *)[_cell viewWithTag:1];
    UILabel          *_labelTimeSlot2 = (UILabel  *)[_cell viewWithTag:2];
    UILabel          *_labelTimeSlot3 = (UILabel  *)[_cell viewWithTag:3];
    UIButton         *_lectureButton  = (UIButton *)[_cell viewWithTag:4];
    UIButton         *_room1Button    = (UIButton *)[_cell viewWithTag:5];
    UIButton         *_room2Button    = (UIButton *)[_cell viewWithTag:6];
    UIButton         *_room3Button    = (UIButton *)[_cell viewWithTag:7];
    UIButton         *_detailButton   = (UIButton *)[_cell viewWithTag:8]; 
    
    // initially always disable detail button
    _detailButton.enabled  = FALSE;
    _lectureButton.enabled = FALSE;
    _room1Button.enabled   = FALSE;
    _room2Button.enabled   = FALSE;
    _room3Button.enabled   = FALSE;
    
    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    [_room1Button   setTitle:@"" forState:UIControlStateNormal];
    [_room2Button   setTitle:@"" forState:UIControlStateNormal];
    [_room3Button   setTitle:@"" forState:UIControlStateNormal];
    
    [_labelTimeSlot1 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot2 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot3 setBackgroundColor:[UIColor clearColor]];
    [_lectureButton  setBackgroundColor:[UIColor clearColor]];
    [_room1Button    setBackgroundColor:[UIColor clearColor]];
    [_room2Button    setBackgroundColor:[UIColor clearColor]];
    [_room3Button    setBackgroundColor:[UIColor clearColor]];
    [_cell           setBackgroundColor:[UIColor clearColor]];
    
    if ([self isActualDayAndTime:_actualDate:actualSelection])
    {
        [_labelTimeSlot1 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot2 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot3 setBackgroundColor:[UIColor lightGrayColor]];
        [_lectureButton  setBackgroundColor:[UIColor lightGrayColor]];
        [_room1Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room2Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room3Button    setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    
    _labelTimeSlot1.text = [NSString stringWithFormat:@"%@ - %@",
                            [[self timeFormatter] stringFromDate:_timeSlot1._startTime],
                            [[self timeFormatter] stringFromDate:_timeSlot1._endTime  ]
                            ];
    _labelTimeSlot2.text = [NSString stringWithFormat:@"%@ - %@",
                            [[self timeFormatter] stringFromDate:_timeSlot2._startTime],
                            [[self timeFormatter] stringFromDate:_timeSlot2._endTime  ]
                            ];
    _labelTimeSlot3.text = [NSString stringWithFormat:@"%@ - %@",
                            [[self timeFormatter] stringFromDate:_timeSlot3._startTime],
                            [[self timeFormatter] stringFromDate:_timeSlot3._endTime  ]
                            ];
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    
    [_room1Button   setTitle:_localRealization1._room._name  forState:UIControlStateNormal];
    [_room2Button   setTitle:_localRealization2._room._name  forState:UIControlStateNormal];
    [_room3Button   setTitle:_localRealization3._room._name  forState:UIControlStateNormal];
    [_lectureButton setTitle:actualScheduleEvent._name       forState:UIControlStateNormal];
    
    _lectureButton.enabled  = TRUE;
    _room1Button.enabled    = TRUE;
    _room2Button.enabled    = TRUE;
    _room3Button.enabled    = TRUE;
    _detailButton.enabled   = TRUE;
    
    [_room1Button   addTarget:self action:@selector(changeToRoomSchedule1   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room2Button   addTarget:self action:@selector(changeToRoomSchedule2   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room3Button   addTarget:self action:@selector(changeToRoomSchedule3   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_lectureButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [_detailButton  addTarget:self action:@selector(showScheduleDetails     :event:) forControlEvents:UIControlEventTouchUpInside];
    
    return _cell;
}



- (UITableViewCell *)fourSlotsThreeRooms:(UITableView *)actualTableView:(NSUInteger)actualSelection:(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"FourSlotsThreeRoomsTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"FourSlotsThreeRoomsTableCell" owner:self options:nil];
        _cell = _fourSlotsThreeRoomsTableCell; 
        self._fourSlotsThreeRoomsTableCell = nil;
    }
    
    UILabel          *_labelTimeSlot1 = (UILabel  *)[_cell viewWithTag:1];
    UILabel          *_labelTimeSlot2 = (UILabel  *)[_cell viewWithTag:2];
    UILabel          *_labelTimeSlot3 = (UILabel  *)[_cell viewWithTag:3];
    UILabel          *_labelTimeSlot4 = (UILabel  *)[_cell viewWithTag:4];
    UIButton         *_lectureButton  = (UIButton *)[_cell viewWithTag:5];  
    UIButton         *_room1Button    = (UIButton *)[_cell viewWithTag:6];  
    UIButton         *_room2Button    = (UIButton *)[_cell viewWithTag:7];  
    UIButton         *_room3Button    = (UIButton *)[_cell viewWithTag:8];  
    UIButton         *_detailButton   = (UIButton *)[_cell viewWithTag:9];  // with arrow image, leading to detail page
    
    // initially always disable detail button
    _detailButton.enabled  = FALSE;
    _lectureButton.enabled = FALSE;
    _room1Button.enabled   = FALSE;
    _room2Button.enabled   = FALSE;
    _room3Button.enabled   = FALSE;
    
    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    [_room1Button   setTitle:@"" forState:UIControlStateNormal];
    [_room2Button   setTitle:@"" forState:UIControlStateNormal];
    [_room3Button   setTitle:@"" forState:UIControlStateNormal];
    
    [_labelTimeSlot1 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot2 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot3 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot4 setBackgroundColor:[UIColor clearColor]];
    [_lectureButton  setBackgroundColor:[UIColor clearColor]];
    [_room1Button    setBackgroundColor:[UIColor clearColor]];
    [_room2Button    setBackgroundColor:[UIColor clearColor]];
    [_room3Button    setBackgroundColor:[UIColor clearColor]];
    [_cell           setBackgroundColor:[UIColor clearColor]];
    
    if ([self isActualDayAndTime:_actualDate:actualSelection]) 
    {    
        [_labelTimeSlot1 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot2 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot3 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot4 setBackgroundColor:[UIColor lightGrayColor]];
        [_lectureButton  setBackgroundColor:[UIColor lightGrayColor]];
        [_room1Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room2Button    setBackgroundColor:[UIColor lightGrayColor]];
        [_room3Button    setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    SlotDto *_timeSlot4 = [actualScheduleEvent._slots objectAtIndex:3];
    
    _labelTimeSlot1.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot1._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot1._endTime  ]
                            ];  
    _labelTimeSlot2.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot2._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot2._endTime  ]
                            ];  
    _labelTimeSlot3.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot3._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot3._endTime  ]
                            ];  
    _labelTimeSlot4.text = [NSString stringWithFormat:@"%@ - %@",  
                            [[self timeFormatter] stringFromDate:_timeSlot4._startTime],  
                            [[self timeFormatter] stringFromDate:_timeSlot4._endTime  ]
                            ];     
    
    ScheduleEventRealizationDto *_localRealization1 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    ScheduleEventRealizationDto *_localRealization2 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:1];
    ScheduleEventRealizationDto *_localRealization3 = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:2];
    
    [_room1Button   setTitle:_localRealization1._room._name  forState:UIControlStateNormal];
    [_room2Button   setTitle:_localRealization2._room._name  forState:UIControlStateNormal];
    [_room3Button   setTitle:_localRealization3._room._name  forState:UIControlStateNormal];
    [_lectureButton setTitle:actualScheduleEvent._name       forState:UIControlStateNormal];
    
    _lectureButton.enabled  = TRUE;
    _room1Button.enabled    = TRUE;    
    _room2Button.enabled    = TRUE;    
    _room3Button.enabled    = TRUE;    
    _detailButton.enabled   = TRUE;
    
    [_room1Button   addTarget:self action:@selector(changeToRoomSchedule1   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room2Button   addTarget:self action:@selector(changeToRoomSchedule2   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_room3Button   addTarget:self action:@selector(changeToRoomSchedule3   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_lectureButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [_detailButton  addTarget:self action:@selector(showScheduleDetails     :event:) forControlEvents:UIControlEventTouchUpInside];
    
    return _cell;        
}


- (UITableViewCell *)eightSlotsOneRoom:(UITableView *)actualTableView:(NSUInteger)actualSelection:(ScheduleEventDto *)actualScheduleEvent
{
    static NSString *_cellIdentifier = @"EightSlotsOneRoomTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"EightSlotsOneRoomTableCell" owner:self options:nil];
        _cell = _eightSlotsOneRoomTableCell;
        self._eightSlotsOneRoomTableCell = nil;
    }
    
    UILabel          *_labelTimeSlot1 = (UILabel  *)[_cell viewWithTag:1];
    UILabel          *_labelTimeSlot2 = (UILabel  *)[_cell viewWithTag:2];
    UILabel          *_labelTimeSlot3 = (UILabel  *)[_cell viewWithTag:3];
    UILabel          *_labelTimeSlot4 = (UILabel  *)[_cell viewWithTag:4];
    UILabel          *_labelTimeSlot5 = (UILabel  *)[_cell viewWithTag:5];
    UILabel          *_labelTimeSlot6 = (UILabel  *)[_cell viewWithTag:6];
    UILabel          *_labelTimeSlot7 = (UILabel  *)[_cell viewWithTag:7];
    UILabel          *_labelTimeSlot8 = (UILabel  *)[_cell viewWithTag:8];

    UIButton         *_lectureButton  = (UIButton *)[_cell viewWithTag:9];
    UIButton         *_roomButton     = (UIButton *)[_cell viewWithTag:10];
    UIButton         *_detailButton   = (UIButton *)[_cell viewWithTag:11];  // with arrow image, leading to detail page
    
    // initially always disable detail button
    _detailButton.enabled  = FALSE;
    _lectureButton.enabled = FALSE;
    _roomButton.enabled    = FALSE;
    
    // initialize values for buttons and labels
    [_lectureButton setTitle:@"" forState:UIControlStateNormal];
    [_roomButton    setTitle:@"" forState:UIControlStateNormal];
    
    [_labelTimeSlot1 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot2 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot3 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot4 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot5 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot6 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot7 setBackgroundColor:[UIColor clearColor]];
    [_labelTimeSlot8 setBackgroundColor:[UIColor clearColor]];

    [_lectureButton  setBackgroundColor:[UIColor clearColor]];
    [_roomButton     setBackgroundColor:[UIColor clearColor]];
    [_cell           setBackgroundColor:[UIColor clearColor]];
    
    if ([self isActualDayAndTime:_actualDate:actualSelection])
    {
        [_labelTimeSlot1 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot2 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot3 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot4 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot5 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot6 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot7 setBackgroundColor:[UIColor lightGrayColor]];
        [_labelTimeSlot8 setBackgroundColor:[UIColor lightGrayColor]];
        [_lectureButton  setBackgroundColor:[UIColor lightGrayColor]];
        [_roomButton     setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    SlotDto *_timeSlot1 = [actualScheduleEvent._slots objectAtIndex:0];
    SlotDto *_timeSlot2 = [actualScheduleEvent._slots objectAtIndex:1];
    SlotDto *_timeSlot3 = [actualScheduleEvent._slots objectAtIndex:2];
    SlotDto *_timeSlot4 = [actualScheduleEvent._slots objectAtIndex:3];
    SlotDto *_timeSlot5 = [actualScheduleEvent._slots objectAtIndex:4];
    SlotDto *_timeSlot6 = [actualScheduleEvent._slots objectAtIndex:5];
    SlotDto *_timeSlot7 = [actualScheduleEvent._slots objectAtIndex:6];
    SlotDto *_timeSlot8 = [actualScheduleEvent._slots objectAtIndex:7];
    
    _labelTimeSlot1.text = [NSString stringWithFormat:@"%@ - %@",
                            [[self timeFormatter] stringFromDate:_timeSlot1._startTime],
                            [[self timeFormatter] stringFromDate:_timeSlot1._endTime  ]
                            ];
    _labelTimeSlot2.text = [NSString stringWithFormat:@"%@ - %@",
                            [[self timeFormatter] stringFromDate:_timeSlot2._startTime],
                            [[self timeFormatter] stringFromDate:_timeSlot2._endTime  ]
                            ];
    _labelTimeSlot3.text = [NSString stringWithFormat:@"%@ - %@",
                            [[self timeFormatter] stringFromDate:_timeSlot3._startTime],
                            [[self timeFormatter] stringFromDate:_timeSlot3._endTime  ]
                            ];
    _labelTimeSlot4.text = [NSString stringWithFormat:@"%@ - %@",
                            [[self timeFormatter] stringFromDate:_timeSlot4._startTime],
                            [[self timeFormatter] stringFromDate:_timeSlot4._endTime  ]
                            ];
    
    _labelTimeSlot5.text = [NSString stringWithFormat:@"%@ - %@",
                            [[self timeFormatter] stringFromDate:_timeSlot5._startTime],
                            [[self timeFormatter] stringFromDate:_timeSlot5._endTime  ]
                            ];

    _labelTimeSlot6.text = [NSString stringWithFormat:@"%@ - %@",
                            [[self timeFormatter] stringFromDate:_timeSlot6._startTime],
                            [[self timeFormatter] stringFromDate:_timeSlot6._endTime  ]
                            ];

    _labelTimeSlot7.text = [NSString stringWithFormat:@"%@ - %@",
                            [[self timeFormatter] stringFromDate:_timeSlot7._startTime],
                            [[self timeFormatter] stringFromDate:_timeSlot7._endTime  ]
                            ];

    _labelTimeSlot8.text = [NSString stringWithFormat:@"%@ - %@",
                            [[self timeFormatter] stringFromDate:_timeSlot8._startTime],
                            [[self timeFormatter] stringFromDate:_timeSlot8._endTime  ]
                            ];
    
    ScheduleEventRealizationDto *_localRealization = [actualScheduleEvent._scheduleEventRealizations objectAtIndex:0];
    
    [_roomButton    setTitle:_localRealization._room._name  forState:UIControlStateNormal];
    [_lectureButton setTitle:actualScheduleEvent._name      forState:UIControlStateNormal];
    
    _lectureButton.enabled  = TRUE;
    _roomButton.enabled     = TRUE;
    _detailButton.enabled   = TRUE;
    
    [_roomButton    addTarget:self action:@selector(changeToRoomSchedule1   :event:) forControlEvents:UIControlEventTouchUpInside];
    [_lectureButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [_detailButton  addTarget:self action:@selector(showScheduleDetails     :event:) forControlEvents:UIControlEventTouchUpInside];
    
    return _cell;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    
    //_detailsVC._schedule                 = [[ScheduleDto alloc] initWithURL]; 
    //_actualDayDto             = [self getDayDto];    
    
    NSUInteger        _cellSelection = indexPath.section;
    ScheduleEventDto *_scheduleEvent = nil;
    //_scheduleEvent = [self getScheduleEventDto:_cellSelection];

    //NSLog(@"_cellSelection %i", _cellSelection);

    
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
    // kind of cell depending on the scheduleEvent
    
    // no lectures at all
    if (_actualDayDto != nil) 
    {
        if ([_actualDayDto._events count] >= _cellSelection)
        {
        
            //_scheduleEvent = [self getScheduleEventDto:_cellSelection];
            _scheduleEvent   = [_actualDayDto._events objectAtIndex:_cellSelection];
            
            if (_scheduleEvent != nil) 
            {  
                // depending on how many rooms and time slots there are take cell
                
                // only one room and one time slot => take normal hight cell
                

                
                if (   [_scheduleEvent._slots                     count] == 0
                    && [_scheduleEvent._scheduleEventRealizations count] == 0)
                {
                    return [self emptyCell:tableView:_cellSelection:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 1)
                {
                    return [self oneSlotOneRoom:tableView:_cellSelection:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 2
                    )
                {
                    return [self oneSlotTwoRooms:tableView:_cellSelection:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 2
                    && [_scheduleEvent._scheduleEventRealizations count] == 2
                    )
                {
                    return [self twoSlotsTwoRooms:tableView:_cellSelection:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 3
                    )
                {
                    return [self oneSlotThreeRooms:tableView:_cellSelection:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 2
                    && [_scheduleEvent._scheduleEventRealizations count] == 1)
                {
                    return [self twoSlotsOneRoom:tableView:_cellSelection:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 3
                    && [_scheduleEvent._scheduleEventRealizations count] == 1)
                {
                    return [self threeSlotsOneRoom:tableView:_cellSelection:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 3
                    && [_scheduleEvent._scheduleEventRealizations count] == 2
                    )
                {
                    return [self threeSlotsTwoRooms:tableView:_cellSelection:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 3
                    && [_scheduleEvent._scheduleEventRealizations count] == 3
                    )
                {
                    return [self threeSlotsThreeRooms:tableView:_cellSelection:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 4
                    && [_scheduleEvent._scheduleEventRealizations count] == 1)
                {
                    return [self fourSlots:tableView:_cellSelection:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 4)
                {
                    return [self oneSlotFourRooms:tableView:_cellSelection:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 4
                    && [_scheduleEvent._scheduleEventRealizations count] == 2
                   )
                {
                  return [self fourSlotsTwoRooms:tableView:_cellSelection:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 4
                    && [_scheduleEvent._scheduleEventRealizations count] == 3
                    )
                {
                    return [self fourSlotsThreeRooms:tableView:_cellSelection:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 5)
                {
                    return [self oneSlotFiveRooms:tableView:_cellSelection:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 5
                    && [_scheduleEvent._scheduleEventRealizations count] == 1
                    )
                {
                    return [self fiveSlotsOneRoom:tableView:_cellSelection:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 6)
                {
                    return [self oneSlotSixRooms:tableView:_cellSelection:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 7)
                {
                    return [self oneSlotSevenRooms:tableView:_cellSelection:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 8)
                {
                    return [self oneSlotEightRooms:tableView:_cellSelection:_scheduleEvent];
                }
                if (   [_scheduleEvent._slots                     count] == 8
                    && [_scheduleEvent._scheduleEventRealizations count] == 1)
                {
                    return [self eightSlotsOneRoom:tableView:_cellSelection:_scheduleEvent];
                }
            }
        }
    }
    NSLog(@" _scheduleEvent %@ _slot count %i realization count %i",
          _scheduleEvent._name,
          [_scheduleEvent._slots count],
          [_scheduleEvent._scheduleEventRealizations count]
          );
    return [self emptyCell:tableView:_cellSelection:nil];    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
                
                // only one room and one time slot => take normal hight cell
                
                if (   [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 1)
                {
                    return 44;
                }
                if ((   [_scheduleEvent._slots                     count] == 2
                     && [_scheduleEvent._scheduleEventRealizations count] == 1
                    )
                || (    [_scheduleEvent._slots                     count] == 1
                     && [_scheduleEvent._scheduleEventRealizations count] == 2
                    )
                || (    [_scheduleEvent._slots                     count] == 2
                     && [_scheduleEvent._scheduleEventRealizations count] == 2
                   )
                 )

                {
                    return 70;
                }
                if ((    [_scheduleEvent._slots                     count] == 3
                      && [_scheduleEvent._scheduleEventRealizations count] == 1
                    )
                || (    [_scheduleEvent._slots                     count] == 1
                     && [_scheduleEvent._scheduleEventRealizations count] == 3
                    )
                || (    [_scheduleEvent._slots                     count] == 3
                     && [_scheduleEvent._scheduleEventRealizations count] == 2
                   )
                || (    [_scheduleEvent._slots                     count] == 3
                     && [_scheduleEvent._scheduleEventRealizations count] == 3
                   )
                )
                {
                    return 104;
                }
                if ((   [_scheduleEvent._slots                     count] == 4
                     && [_scheduleEvent._scheduleEventRealizations count] == 1
                    )
                 || (   [_scheduleEvent._slots                     count] == 4
                     && [_scheduleEvent._scheduleEventRealizations count] == 2
                    )
                 || (   [_scheduleEvent._slots                     count] == 4
                     && [_scheduleEvent._scheduleEventRealizations count] == 3
                    )
                 || (   [_scheduleEvent._slots                     count] == 1
                     && [_scheduleEvent._scheduleEventRealizations count] == 4
                    )
                )
                {
                    return 140;
                }
                if ((  [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 5
                    )
                 || (  [_scheduleEvent._slots                     count] == 5
                    && [_scheduleEvent._scheduleEventRealizations count] == 1
                    )
                  )
                {
                    return 175;
                }
                if (   [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 6)
                {
                    return 210;
                }
                if (   [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 7)
                {
                    return 245;
                }
                if ((  [_scheduleEvent._slots                     count] == 1
                    && [_scheduleEvent._scheduleEventRealizations count] == 8
                    )
                || (   [_scheduleEvent._slots                     count] == 8
                    && [_scheduleEvent._scheduleEventRealizations count] == 1
                    )
                )
                {
                    return 280;
                }
            }
        }
    }
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
