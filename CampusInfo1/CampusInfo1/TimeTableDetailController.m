//
//  TimeTableDetailController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TimeTableDetailController.h"
#import "ScheduleEventRealizationDto.h"
#import "SchoolClassDto.h"
#import "RoomDto.h"
#import "PersonDto.h"
#import "ScheduleEventDto.h"
#import "ScheduleDto.h"
#import "ColorSelection.h"
#import "UIConstantStrings.h"


@implementation TimeTableDetailController

@synthesize _timeTableDetailViewDelegate;

@synthesize _scheduleEvent;
@synthesize _detailTable;
@synthesize _detailTableCell;

@synthesize _timeString;
@synthesize _dayAndAcronymString;
@synthesize _detailTableCellWithButton;

@synthesize _waitForChangeActivityIndicator;

@synthesize _titleNavigationItem;
@synthesize _titleNavigationBar;
@synthesize _titleNavigationLabel;
@synthesize _timeTableDescriptionLabel;

@synthesize _timeLabel;
@synthesize _timeNavigationBar;
@synthesize _timeNavigationItem;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}



- (void)moveBackToTimeTable:(id)sender
{
        [self dismissModalViewControllerAnimated:YES];
}


-(void)setNavigationTitle:(NSString *)titleString
{
    _timeTableDescriptionLabel.text = [NSString stringWithFormat:@"%@", titleString];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // general initialization
    ColorSelection *_zhawColor = [[ColorSelection alloc]init];

    // set title
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToTimeTable:)];
    
    [backButtonItem setTintColor:_zhawColor._zhawOriginalBlue];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    _titleNavigationItem.title = @"";
    [_titleNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = TimeTableOverVCTitle;
    [_titleNavigationLabel setTextAlignment:UITextAlignmentCenter];
    
    [_timeTableDescriptionLabel setTextColor:_zhawColor._zhawWhite];
    [_timeTableDescriptionLabel setText:_dayAndAcronymString];
    [_timeTableDescriptionLabel setTextAlignment:UITextAlignmentCenter];
    
    
    [_timeNavigationItem setTitle:@""];
    [_timeNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];
    
    [_timeLabel setTextColor:_zhawColor._zhawWhite];
    [_timeLabel setText:_timeString];
    [_timeLabel setTextAlignment:UITextAlignmentCenter];
    

    // set default values for spinner/activity indicator
    _waitForChangeActivityIndicator.hidesWhenStopped = YES;
    _waitForChangeActivityIndicator.hidden = YES;
    [_waitForChangeActivityIndicator setBackgroundColor:_zhawColor._zhawOriginalBlue];
    [self.view bringSubviewToFront:_waitForChangeActivityIndicator];
    
    
    // set table controller
    if (_detailTable == nil) {
		_detailTable = [[UITableView alloc] init];
	}
    _detailTable.separatorColor = [UIColor clearColor];
    _detailTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_detailTable reloadData];

}


- (void)viewDidUnload
{    
    _detailTable                = nil;
    _detailTableCell            = nil;
    _timeLabel                  = nil;
    _timeString                 = nil;
    _dayAndAcronymString        = nil;
    _detailTableCellWithButton  = nil;
    _timeTableDescriptionLabel = nil;
    _waitForChangeActivityIndicator = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    _timeNavigationBar = nil;
    _timeNavigationItem = nil;
    [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void) threadWaitForChangeActivityIndicator:(id)data
{
    _waitForChangeActivityIndicator.hidden = NO;
    [_waitForChangeActivityIndicator startAnimating];
}



- (NSMutableArray *)splitScheduleToArray:(ScheduleEventDto *)scheduleEvent
{
    NSMutableArray *_bothArrays       = [[NSMutableArray alloc]init];
    NSMutableArray *_detailArray      = [[NSMutableArray alloc]init];
    NSMutableArray *_descriptionArray = [[NSMutableArray alloc]init];
    NSMutableArray *_typeButtonArray  = [[NSMutableArray alloc]init];
    NSMutableArray *_acronymArray     = [[NSMutableArray alloc]init];
    
    int realizationI;    
     
    // NSLog(@"splitAllocationToArray _allocation._name %@", _allocation._name);
    
    //NSString  *_string1 = [NSString stringWithFormat:@"Veranstaltung: %@", _allocation._name];
    
    [_descriptionArray addObject:[NSString stringWithFormat:@"%@:",TimeTableTypeKurs]];
    [_detailArray      addObject:[NSString stringWithFormat:@"%@", scheduleEvent._name]];
    [_acronymArray     addObject:[NSString stringWithFormat:@"%@", scheduleEvent._name]];
    [_typeButtonArray  addObject:[NSString stringWithFormat:@"%@", TimeTableTypeCourseEnglishPlural]];
    
    [_descriptionArray addObject:[NSString stringWithFormat:@"%@", TimeTableDescription]];
    [_detailArray      addObject:[NSString stringWithFormat:@"%@", scheduleEvent._description]];
    [_acronymArray     addObject:[NSString stringWithFormat:@"%@", scheduleEvent._name]];
    [_typeButtonArray  addObject:[NSString stringWithFormat:@"NONE"]];

    
    // put all rooms of the given event

    for (realizationI = 0; realizationI < scheduleEvent._scheduleEventRealizations.count; realizationI++) 
    {
        ScheduleEventRealizationDto *_realization = nil;
        _realization = [_scheduleEvent._scheduleEventRealizations objectAtIndex:realizationI];
        if (_realization._room != nil)
        {   
            [_descriptionArray addObject:[NSString stringWithFormat:@"%@:", TimeTableTypeRaum]];
            [_detailArray      addObject:[NSString stringWithFormat:@"%@", _realization._room._name]];
            [_acronymArray     addObject:[NSString stringWithFormat:@"%@", _realization._room._name]];
            [_typeButtonArray  addObject:[NSString stringWithFormat:@"%@", TimeTableTypeRoomEnglishPlural]];
        }    
    }
      
    
    // put all lecturers of the given event
    for (realizationI = 0; realizationI < scheduleEvent._scheduleEventRealizations.count; realizationI++) 
    {
        ScheduleEventRealizationDto *_realization = nil;
        _realization = [_scheduleEvent._scheduleEventRealizations objectAtIndex:realizationI];
        NSMutableArray *_lecturerArray             = [[NSMutableArray alloc]init];
        _lecturerArray = _realization._lecturers;

        int lecturerI;
        for (lecturerI = 0; lecturerI < _lecturerArray.count; lecturerI++)
        {    
            PersonDto *_localLecturer = nil;
            _localLecturer = [_lecturerArray objectAtIndex:lecturerI];
            if (_localLecturer._lastName != nil)
            {
                if (lecturerI == 0)
                {
                    [_descriptionArray addObject:[NSString stringWithFormat:@"%@", TimeTableTypeDozentPlural]];
                   
                }
                else
                {
                    [_descriptionArray addObject:[NSString stringWithFormat:@""]];
                }
                [_detailArray      addObject:[NSString stringWithFormat:@"%@ %@ (%@)"
                                              ,_localLecturer._firstName
                                              ,_localLecturer._lastName
                                              ,_localLecturer._shortName]];
                [_acronymArray     addObject:[NSString stringWithFormat:@"%@", _localLecturer._shortName]];
                [_typeButtonArray  addObject:[NSString stringWithFormat:@"%@", TimeTableTypeLecturerEnglishPlural]];
            }    
        }
    }

    
    // put all classes of the given event
    for (realizationI = 0; realizationI < scheduleEvent._scheduleEventRealizations.count; realizationI++) 
    {
        ScheduleEventRealizationDto *_realization = nil;
        _realization = [_scheduleEvent._scheduleEventRealizations objectAtIndex:realizationI];
        NSMutableArray *_classArray             = [[NSMutableArray alloc]init];
        _classArray = _realization._schoolClasses;
        
        int classI;
        for (classI = 0; classI < _classArray.count; classI++)
        {    
            SchoolClassDto *_localClass = nil;
            _localClass = [_classArray objectAtIndex:classI];
            if (_localClass._name != nil)
            {
                if (classI == 0)
                {
                    [_descriptionArray addObject:[NSString stringWithFormat:@"%@", TimeTableTypeKlassePlural]];
                }
                else
                {
                    [_descriptionArray addObject:[NSString stringWithFormat:@""]];
                }
                [_detailArray     addObject:[NSString stringWithFormat:@"%@", _localClass._name]];
                [_acronymArray    addObject:[NSString stringWithFormat:@"%@", _localClass._name]];
                [_typeButtonArray addObject:[NSString stringWithFormat:@"%@", TimeTableTypeClassEnglishPlural]];
            }    
        }
    }
    
    [_bothArrays addObject:_descriptionArray];
    [_bothArrays addObject:_detailArray     ];
    [_bothArrays addObject:_typeButtonArray ];
    [_bothArrays addObject:_acronymArray    ];
    
    return _bothArrays;
}


// ----- DETAIL TABLE -----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //NSLog(@" _timeString in Table %@",_timeString);
    
    //NSLog(@"numberOfSectionsInTableView _allocation._name %@", _allocation._name);
    
    NSMutableArray *_bothArrays       = [self splitScheduleToArray:(_scheduleEvent)];
    NSMutableArray *_descriptionArray = [_bothArrays objectAtIndex:0];
    
    //NSLog(@"numberOfSectionsInTableView _detailArray count %i", [_detailArray count]);
    return [_descriptionArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"numberOfRowsInSection");
    return 1;
}



-(void) changeToSchedule:(id)sender event:(id)event
{
    
    [NSThread detachNewThreadSelector:@selector(threadWaitForChangeActivityIndicator:) toTarget:self withObject:nil];
    
    NSMutableArray *_bothArrays       = [self splitScheduleToArray:_scheduleEvent];
    //NSMutableArray *_descriptionArray = [_bothArrays objectAtIndex:0];
    //NSMutableArray *_detailArray      = [_bothArrays objectAtIndex:1];
    NSMutableArray *_buttonArray      = [_bothArrays objectAtIndex:2];    
    NSMutableArray *_acronymArray     = [_bothArrays objectAtIndex:3];    
    
    NSSet       *_touches              = [event    allTouches];
    UITouch     *_touch                = [_touches anyObject ];
    CGPoint      _currentTouchPosition = [_touch locationInView:self._detailTable];
    NSIndexPath *_indexPath            = [self._detailTable indexPathForRowAtPoint: _currentTouchPosition];    
    
    NSString       *_newAcronymType   = [_buttonArray  objectAtIndex:_indexPath.section];
    NSString       *_newAcronymString = [_acronymArray objectAtIndex:_indexPath.section];;
    
    //NSLog(@"set new acronym %@ and new type %@", _newAcronymString,_newAcronymType);
    
    //if([self._timeTableDetailViewDelegate respondsToSelector:@selector(setNewAcronym:)])
    //{
    [self._timeTableDetailViewDelegate setNewAcronym:_newAcronymString withAcronymType:_newAcronymType];
    //}
    [_waitForChangeActivityIndicator stopAnimating];
    _waitForChangeActivityIndicator.hidden = YES;
    
    [self dismissModalViewControllerAnimated:YES];
    

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSMutableArray *_bothArrays       = [self splitScheduleToArray:_scheduleEvent];
    NSMutableArray *_descriptionArray = [_bothArrays objectAtIndex:0];
    NSMutableArray *_detailArray      = [_bothArrays objectAtIndex:1];
    NSMutableArray *_buttonArray      = [_bothArrays objectAtIndex:2];    
    
    NSString       *_buttonTypeString = [_buttonArray objectAtIndex:indexPath.section];
    
    if ([_buttonTypeString isEqualToString:@"NONE"])
    {
    
        static NSString *_cellIdentifier  = @"DetailTableCell";
        UITableViewCell *_cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
        if (_cell == nil) 
        {
            [[NSBundle mainBundle] loadNibNamed:@"DetailTableCell" owner:self options:nil];
            _cell = _detailTableCell;
            self._detailTableCell = nil;
        }
    
    
        //NSLog(@"cellForRowAtIndexPath indexPath section  %i", indexPath.section);
        //NSLog(@"cellForRowAtIndexPath _detailArray count %i", [_detailArray count]);

        UILabel         *_labelDescription = (UILabel *) [_cell viewWithTag:1];
        UILabel         *_labelValue       = (UILabel *) [_cell viewWithTag:2];
        UIButton        *_detailButton     = (UIButton *)[_cell viewWithTag:3]; 
    
        _labelDescription.text  = [_descriptionArray objectAtIndex:indexPath.section];
        _labelValue.text        = [_detailArray      objectAtIndex:indexPath.section];;
        _detailButton.enabled   = FALSE;
        _detailButton.hidden    = YES;
        return _cell;
    }
    else
    {
        static NSString *_cellIdentifier  = @"DetailTableCellWithButton";
        UITableViewCell *_cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
        
        if (_cell == nil) 
        {
            [[NSBundle mainBundle] loadNibNamed:@"DetailTableCellWithButton" owner:self options:nil];
            _cell = _detailTableCellWithButton;
            self._detailTableCellWithButton = nil;
        }
        
        
        //NSLog(@"cellForRowAtIndexPath indexPath section  %i", indexPath.section);
        //NSLog(@"cellForRowAtIndexPath _detailArray count %i", [_detailArray count]);
        
        UILabel         *_labelDescription = (UILabel *)  [_cell viewWithTag:1];
        UIButton        *_valueButton      = (UIButton *) [_cell viewWithTag:2];
        UIButton        *_detailButton     = (UIButton *) [_cell viewWithTag:3]; 
        
        _labelDescription.text  = [_descriptionArray objectAtIndex:indexPath.section];

        NSMutableAttributedString *_titleValueButton = [[NSMutableAttributedString alloc] initWithString:[_detailArray objectAtIndex:indexPath.section]];
        
        [_titleValueButton addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleValueButton length])];
        
        [_valueButton setAttributedTitle:_titleValueButton forState:UIControlStateNormal];
        [_valueButton addTarget:self action:@selector(changeToSchedule:event:) forControlEvents:UIControlEventTouchUpInside];
        
        _detailButton.enabled   = FALSE;
        _detailButton.hidden    = YES;
        return _cell;
        
    }
    
}




@end
