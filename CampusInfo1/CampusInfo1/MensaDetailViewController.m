//
//  MensaDetailViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 22.07.13.
//
//

#import "MensaDetailViewController.h"

@interface MensaDetailViewController ()

@end

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
}

- (void)setActualDate:(NSDate *)newDate
{
    self._actualDate      = newDate;
    //[self setNewScheduleWithDate:newDate];
    [self setDateInNavigatorWithActualDate:_actualDate];
    //_actualDayDto        = [self getDayDto];
    //[_timeTable reloadData];
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

- (void) setTitleToActualDate
{
    NSDateFormatter* df_local = [[NSDateFormatter alloc] init];
    [df_local setTimeZone:[NSTimeZone timeZoneWithName:@"CEST"]];
    [df_local setDateFormat:@"yyyy.MM.dd G 'at' HH:mm:ss zzz"];
        
    //----- Navigation Bar ----
    // set current day
    self._actualDate = [NSDate date];
    //self._actualDate    = [[_dateFormatter _dayFormatter] dateFromString:@"17.12.2012"];
    
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
}

-(void) openChooseDateView
{
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
    [super viewDidUnload];
}


// table and table cell handling

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
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
    
    static NSString *_cellIdentifier  = @"MensaDetailTableCell";
    UITableViewCell *_cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
        
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"MensaDetailTableCell" owner:self options:nil];
        _cell = _detailTableCell;
        self._detailTableCell = nil;
    }
    
    UILabel         *_labelTitle            = (UILabel *) [_cell viewWithTag:1];
    UILabel         *_labelMaincourse       = (UILabel *) [_cell viewWithTag:2];
    UILabel         *_labelSidedishes       = (UILabel *) [_cell viewWithTag:3];
    UILabel         *_labelPriceInternal    = (UILabel *) [_cell viewWithTag:4];
    UILabel         *_labelPricePartner     = (UILabel *) [_cell viewWithTag:5];
    UILabel         *_labelPriceExternal    = (UILabel *) [_cell viewWithTag:6];
    
    
    return _cell;
}


@end
