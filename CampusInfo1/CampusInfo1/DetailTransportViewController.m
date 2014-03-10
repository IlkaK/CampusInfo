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

@interface DetailTransportViewController ()

@end

@implementation DetailTransportViewController

@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;
@synthesize _titleLabel;
@synthesize _descriptionLabel;

@synthesize _zhawColor;

@synthesize _actualConnection;


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
    return 1;
}

/*!
 * @function cellForRowAtIndexPath
 * The function is for customizing the table view cells.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellRow = indexPath.row;
    static NSString *_cellIdentifier = @"DetailTransportTableCell";
    UITableViewCell *_cell           = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    /*
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"DetailTransportTableCell" owner:self options:nil];
        _cell = _detailTransportTableCell;
        self._detailTransportTableCell = nil;
    }
    
    UILabel          *_startDestinationLabel = (UILabel  *)[_cell viewWithTag:1];
    UILabel          *_startDateLabel       = (UILabel  *)[_cell viewWithTag:2];
    UILabel          *_startTimeLabel       = (UILabel  *)[_cell viewWithTag:3];
    UILabel          *_durationLabel        = (UILabel  *)[_cell viewWithTag:4];
    //UILabel          *_transfersLabel       = (UILabel  *)[_cell viewWithTag:5];
    //UILabel          *_transportationLabel  = (UILabel  *)[_cell viewWithTag:6];
    UILabel          *_stopDestinationLabel = (UILabel  *)[_cell viewWithTag:5];
    UILabel          *_stopDateLabel        = (UILabel  *)[_cell viewWithTag:6];
    UILabel          *_stopTimeLabel        = (UILabel  *)[_cell viewWithTag:7];
    [_startDestinationLabel     setTextColor:_zhawColor._zhawFontGrey];
    [_startDateLabel            setTextColor:_zhawColor._zhawFontGrey];
    [_startTimeLabel            setTextColor:_zhawColor._zhawFontGrey];
    [_durationLabel             setTextColor:_zhawColor._zhawFontGrey];
    //[_transfersLabel            setTextColor:_zhawColor._zhawFontGrey];
    //[_transportationLabel       setTextColor:_zhawColor._zhawFontGrey];
    [_stopDestinationLabel      setTextColor:_zhawColor._zhawFontGrey];
    [_stopDateLabel             setTextColor:_zhawColor._zhawFontGrey];
    [_stopTimeLabel             setTextColor:_zhawColor._zhawFontGrey];
    
    //NSLog(@" cellForRowAtIndexPath - connection count: %i _cellRow: %i", [_connectionArray._connections count], _cellRow);
    
    if (    [_connectionArray._connections lastObject] != nil
        &&  [_connectionArray._connections count] > _cellRow)
    {
        ConnectionDto *_localConnection = [_connectionArray._connections objectAtIndex:_cellRow];
        
        // store the very next departure time and date to check if another search is needed
        if(_cellRow == 0)
        {
            _veryNextConnectionDate = _localConnection._from._departureDate;
            _veryNextConnectionTime = _localConnection._from._departureTime;
        }
        
        _startDestinationLabel.text        = _localConnection._from._station._name;
        _startDateLabel.text    = [[_dateFormatter _dayFormatter] stringFromDate:_localConnection._from._departureDate];
        _startTimeLabel.text    = [NSString stringWithFormat:@"%@ %@",PublicTransportVCFromGerman, [[_dateFormatter _timeFormatter] stringFromDate:_localConnection._from._departureTime]];
        
        _durationLabel.text     = _localConnection._duration;
        //_transfersLabel.text    = [NSString stringWithFormat:@"%i",_localConnection._transfers];
        
        int _productsArrayI;
        NSString *_productsString;
        for (_productsArrayI=0; _productsArrayI < [_localConnection._products count]; _productsArrayI++)
        {
            NSString *_oneProduct = [_localConnection._products objectAtIndex:_productsArrayI];
            if (_productsArrayI > 0)
            {
                _productsString = [NSString stringWithFormat:@"%@, %@",_productsString, _oneProduct];
            }
            else
            {
                _productsString = [NSString stringWithFormat:@"%@",_oneProduct];
            }
        }
        //_transportationLabel.text = _productsString;
        _stopDestinationLabel.text = _localConnection._to._station._name;
        _stopDateLabel.text   = [[_dateFormatter _dayFormatter] stringFromDate:_localConnection._to._arrivalDate];
        _stopTimeLabel.text   = [NSString stringWithFormat:@"%@ %@",PublicTransportVCToGerman, [[_dateFormatter _timeFormatter] stringFromDate:_localConnection._to._arrivalTime]];
    }
     */
    return _cell;
}

/*!
 * @function heightForRowAtIndexPath
 * The function is for customizing the table view cells.
 * It sets the height for each cell individually.
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


@end
