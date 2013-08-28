//
//  PublicTransportViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 14.08.13.
//
//

#import "PublicTransportViewController.h"
#import "ColorSelection.h"

@interface PublicTransportViewController ()
@end

@implementation PublicTransportViewController

@synthesize _publicTransportNavigationBar;
@synthesize _publicTransportNavigationItem;
@synthesize _publicTransportNavigationLabel;

@synthesize _fromButton;
@synthesize _searchButton;
@synthesize _toButton;

@synthesize _pubilcTransportOverviewTableCell;
@synthesize _publicStopVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}


- (void) moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    self.tabBarController.selectedIndex = 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ColorSelection *_zhawColor = [[ColorSelection alloc]init];
    
    UIButton *backButton = [UIButton buttonWithType:101];
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backButton.frame.size.width, backButton.frame.size.height)];
    
    [backButton addTarget:self action:@selector(moveBackToMenuOverview:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"zurück" forState:UIControlStateNormal];
    [backButtonView addSubview:backButton];
    
    // set buttonview as custom view for bar button item
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    [_publicTransportNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_publicTransportNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _publicTransportNavigationLabel.text = @"ÖV-Fahrplan";
    _publicTransportNavigationItem.title = @"";
    
    CGRect imageRect = CGRectMake(0, 0, _publicTransportNavigationBar.frame.size.width, _publicTransportNavigationBar.frame.size.height);
    UIGraphicsBeginImageContext(imageRect.size);
    [_zhawColor._zhawOriginalBlue set];
    UIRectFill(imageRect);
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [_publicTransportNavigationBar setBackgroundImage:aImage forBarMetrics:UIBarMetricsDefault];
    
    [_publicTransportNavigationLabel setBackgroundColor:_zhawColor._zhawOriginalBlue];
    
    [_fromButton useAlertStyle];
    [_toButton useAlertStyle];
    [_searchButton useAlertStyle];
    
    if (_publicStopVC == nil)
    {
		_publicStopVC = [[PublicStopViewController alloc] init];
	}
    _publicStopVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(_publicStopVC._actualStation != nil)
    {
        NSString *_stationName =  _publicStopVC._actualStation._name;
        NSLog(@"actual Station: %@",_stationName);
        if ([_publicStopVC._actualStationType isEqualToString:@"to"])
        {
            [_toButton setTitle:_stationName forState:UIControlStateNormal];
        }
        else
        {
            [_fromButton setTitle:_stationName forState:UIControlStateNormal];
        }
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload
{
    _publicTransportNavigationBar = nil;
    _publicTransportNavigationItem = nil;
    _publicTransportNavigationLabel = nil;
    _fromButton = nil;
    _toButton = nil;
    _searchButton = nil;
    _pubilcTransportOverviewTableCell = nil;
    _publicStopVC = nil;
    [super viewDidUnload];
}


- (IBAction)moveToFromStopController:(id)sender
{
    _publicStopVC._actualStationType = @"from";

    NSLog(@"to button title: %@", _fromButton.titleLabel.text);    
    _publicStopVC._publicStopTextFieldString = _fromButton.titleLabel.text;
    [self presentModalViewController:_publicStopVC animated:YES];
}

- (IBAction)moveToToStopController:(id)sender
{
    _publicStopVC._actualStationType = @"to";
    
    NSLog(@"to button title: %@", _toButton.titleLabel.text);
    _publicStopVC._publicStopTextFieldString = _toButton.titleLabel.text;
    [self presentModalViewController:_publicStopVC animated:YES];
}

- (IBAction)startConnectionSearch:(id)sender
{
    
}


// needed for table delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *_cellIdentifier = @"PublicTransportOverviewTableCell";
    UITableViewCell *_cell           = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"PublicTransportOverviewTableCell" owner:self options:nil];
        _cell = _pubilcTransportOverviewTableCell;
        self._pubilcTransportOverviewTableCell = nil;
    }
    
    /*
    UILabel          *_mensaLabel           = (UILabel  *)[_cell viewWithTag:1];
    UILabel          *_openingTimesLabel    = (UILabel  *)[_cell viewWithTag:2];
    UILabel          *_lunchTimesLabel      = (UILabel  *)[_cell viewWithTag:3];
    
    _mensaLabel.text = [NSString stringWithFormat:@"%@ (%@)", gastronomyName
                        ,[_translator getGermanGastronomyTypeTranslation:gastronomyType]
                        ];
    
    _openingTimesLabel.text = openingTime;
    _lunchTimesLabel.text   = lunchTime;
    */
    
    return _cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSUInteger    _cellSelection = indexPath.section;
    
}


@end
