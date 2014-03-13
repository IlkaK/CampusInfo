//
//  DetailTransportViewController.m
//  Engineering
//
//  Created by Ilka Kokemor on 10.03.14.
//
//

#import "DetailTransportViewController.h"
#import "ColorSelection.h"
#import "UIConstantStrings.h"
#import "SectionDto.h"

@interface DetailTransportViewController ()

@end

@implementation DetailTransportViewController

@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;
@synthesize _titleLabel;
@synthesize _descriptionLabel;

@synthesize _zhawColor;
@synthesize _dateFormatter;

@synthesize _actualConnection;

@synthesize _detailTableView;
@synthesize _detailTransportConnectionTableCell;
@synthesize _detailTransportSectionTableCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*!
 @function moveBackToPublicTransport
 When back button is triggered, delegate is returned to PublicTransportViewController.
 @param sender
 */
- (void)moveBackToPublicTransport:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // general initialization
    _zhawColor                  = [[ColorSelection alloc]init];
    _dateFormatter              = [[DateFormation alloc] init];
    
    // title
    UIBarButtonItem *_backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStyleBordered target:self action:@selector(moveBackToPublicTransport:)];
    [_backButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:_zhawColor._zhawWhite} forState:UIControlStateNormal];
    [_titleNavigationItem setLeftBarButtonItem :_backButtonItem animated :true];
    [_titleNavigationItem setTitle:@""];
    
    [_titleLabel setTextColor:_zhawColor._zhawWhite];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarTitleSize]];
    [_titleLabel setText:PublicTransportVCTitle];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:NavigationBarBackground] forBarMetrics:UIBarMetricsDefault];
    
    [_descriptionLabel setTextColor:_zhawColor._zhawWhite];
    [_descriptionLabel setTextAlignment:NSTextAlignmentCenter];
    [_descriptionLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarDescriptionSize]];
    [_descriptionLabel setText: PublicTransportVCDetails];
    
}

/*!
 * @function viewWillAppear
 * The function is included, since class inherits from UIViewController.
 * It is called every time the view is called again.
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //NSLog(@"%@ ", [[_dateFormatter _timeFormatter] stringFromDate:_actualConnection._from._departureTime]);
    //NSLog(@"3 count sections %i", [_actualConnection._sections count]);
    
    [_detailTableView reloadData];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 @function viewDidUnload
 * The function is included, since class inherits from UIViewController.
 * It is called while the view is unloaded.
 */
- (void)viewDidUnload
{
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    [super viewDidUnload];
}


//-------------------------------------------------
// ------- MANAGE TABLE CELLS ----
//-------------------------------------------------
/*!
 * @function numberOfSectionsInTableView
 * The function defines the number of sections in table.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


/*!
 * @function numberOfRowsInSection
 * The function defines the number of rows in table.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"numberOfRowsInSection connection count: %i", [_connectionArray._connections count]);
    //NSLog(@"1 count sections %i", [_actualConnection._sections count]);
    return 1 + [_actualConnection._sections count];
}


/*!
 * @function cellForRowAtIndexPath
 * The function is for customizing the table view cells.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger          _cellRow = indexPath.row;
    UITableViewCell     *_cell;
    
    if (_cellRow == 0)
    {
        static NSString *_cellIdentifier = @"DetailTransportConnectionTableCell";
        _cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
        if (_cell == nil)
        {
            [[NSBundle mainBundle] loadNibNamed:@"DetailTransportConnectionTableCell" owner:self options:nil];
            _cell = _detailTransportConnectionTableCell;
            self._detailTransportConnectionTableCell = nil;
        }
        
        UILabel          *_fromLabel        = (UILabel  *)[_cell viewWithTag:1];
        UILabel          *_toLabel          = (UILabel  *)[_cell viewWithTag:2];
        UILabel          *_dateLabel        = (UILabel  *)[_cell viewWithTag:3];
        UILabel          *_timeLabel        = (UILabel  *)[_cell viewWithTag:4];
        UILabel          *_durationLabel    = (UILabel  *)[_cell viewWithTag:5];
        UILabel          *_moveLabel        = (UILabel  *)[_cell viewWithTag:6];
        
        [_fromLabel setFont:[UIFont fontWithName:BoldFont size:NavigationBarDescriptionSize]];
        [_toLabel setFont:[UIFont fontWithName:BoldFont size:NavigationBarDescriptionSize]];
        [_dateLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarDescriptionSize]];
        [_timeLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarDescriptionSize]];
        [_durationLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarDescriptionSize]];
        [_moveLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarDescriptionSize]];
        
        _fromLabel.text        = [NSString stringWithFormat:@"%@", _actualConnection._from._station._name];
        _toLabel.text          = [NSString stringWithFormat:@"%@", _actualConnection._to._station._name];
        _dateLabel.text        = [NSString stringWithFormat:@"am: %@", [[_dateFormatter _dayFormatter] stringFromDate:_actualConnection._from._departureDate]];
        _timeLabel.text        = [NSString stringWithFormat:@"um: %@", [[_dateFormatter _timeFormatter] stringFromDate:_actualConnection._from._departureTime]];
        
        _durationLabel.text     = [NSString stringWithFormat:@"Reisedauer: %@",_actualConnection._duration];
        _moveLabel.text         = [NSString stringWithFormat:@"Umsteigen: %i",_actualConnection._transfers];
        
    }
    else // _cellRow => 1 // loop through sections
    {
        NSUInteger _cntSection = _cellRow - 1;
        static NSString *_cellIdentifier = @"DetailTransportSectionTableCell";
        _cell           = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
        
        if (_cell == nil)
        {
            [[NSBundle mainBundle] loadNibNamed:@"DetailTransportSectionTableCell" owner:self options:nil];
            _cell = _detailTransportSectionTableCell;
            self._detailTransportSectionTableCell = nil;
        }
        
        //NSLog(@"2 count sections %i", [_actualConnection._sections count]);
        
        UILabel          *_fromLabel           = (UILabel  *)[_cell viewWithTag:1];
        UILabel          *_fromTimeLabel       = (UILabel  *)[_cell viewWithTag:2];
        UILabel          *_toLabel             = (UILabel  *)[_cell viewWithTag:3];
        UILabel          *_toTimeLabel         = (UILabel  *)[_cell viewWithTag:4];
        UILabel          *_transportationLabel = (UILabel  *)[_cell viewWithTag:5];
        UILabel          *_directionLabel      = (UILabel  *)[_cell viewWithTag:6];

        
        [_fromLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarDescriptionSize]];
        [_fromTimeLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarDescriptionSize]];
        [_directionLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarDescriptionSize]];
        [_transportationLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarDescriptionSize]];
        [_toLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarDescriptionSize]];
        [_toTimeLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarDescriptionSize]];

        
        if (    [_actualConnection._sections lastObject] != nil
            &&  [_actualConnection._sections count] > _cntSection)
        {
            SectionDto *_localSection = [_actualConnection._sections objectAtIndex:_cntSection];
            
            _fromLabel.text = [NSString stringWithFormat:@"von: %@", _localSection._departure._station._name];
            _fromTimeLabel.text = [NSString stringWithFormat:@"ab: %@", [[_dateFormatter _timeFormatter] stringFromDate:_localSection._departure._departureTime]];
            _toLabel.text   = [NSString stringWithFormat:@"nach: %@", _localSection._arrival._station._name];
            _toTimeLabel.text = [NSString stringWithFormat:@"an: %@", [[_dateFormatter _timeFormatter] stringFromDate:_localSection._arrival._arrivalTime]];

            if (_localSection._walkTime != nil)
            {
                _transportationLabel.text = [NSString stringWithFormat:@"Fussweg: %@ min", [[_dateFormatter _minutesAndSecondsFormatter] stringFromDate:_localSection._walkTime]];
                _directionLabel.text = @"";
            }
            else
            {
                _transportationLabel.text = [NSString stringWithFormat:@"Reise mit: %@ %@", _localSection._journey._category, _localSection._journey._journeyNumber];
                _directionLabel.text = [NSString stringWithFormat:@"Richtung: %@",_localSection._journey._to];
            }
        }
        
    }
    return _cell;
}


/*!
 * @function heightForRowAtIndexPath
 * The function is for customizing the table view cells.
 * It sets the height for each cell individually.
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger          _cellRow = indexPath.row;
    NSUInteger          _cntSection = _cellRow - 1;
    CGFloat             _cellSize = 105;
    
    if (_cellRow > 0)
    {
        if (    [_actualConnection._sections lastObject] != nil
            &&  [_actualConnection._sections count] > _cntSection)
        {
            SectionDto *_localSection = [_actualConnection._sections objectAtIndex:_cntSection];
            if (_localSection._walkTime != nil)
            {
                _cellSize = 88;
            }
        
        }
    }
    return _cellSize;
}


@end
