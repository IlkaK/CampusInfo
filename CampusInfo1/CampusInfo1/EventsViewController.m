//
//  EventsViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 14.08.13.
//
//

#import "EventsViewController.h"

@interface EventsViewController ()

@end

@implementation EventsViewController

@synthesize _newsChannel;

@synthesize _eventsTable;
@synthesize _eventsTableCell;

@synthesize _dateFormatter;

@synthesize _blueColor;

@synthesize _actualTrials;
@synthesize _noConnectionButton;
@synthesize _noConnectionLabel;

@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;
@synthesize _titleNavigationLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _newsChannel = [[NewsChannelDto alloc]init];
    
    _blueColor = [UIColor colorWithRed:1.0/255.0 green:100.0/255.0 blue:167.0/255.0 alpha:1.0];
    _dateFormatter = [[DateFormation alloc] init];
    
    //[_newsChannel getEventsData];
    [_eventsTable reloadData];
    
    self._actualTrials = 1;
    
    _noConnectionButton.hidden = YES;
    _noConnectionLabel.hidden = YES;
    
    UIButton *backButton = [UIButton buttonWithType:101];
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backButton.frame.size.width, backButton.frame.size.height)];
    
    [backButton addTarget:self action:@selector(moveBackToMenuOverview:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"zurück" forState:UIControlStateNormal];
    [backButtonView addSubview:backButton];
    
    // set buttonview as custom view for bar button item
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:[UIColor whiteColor]];
    _titleNavigationLabel.text = @"Events - School of Engineering";
    _titleNavigationItem.title = @"";
    
    CGRect imageRect = CGRectMake(0, 0, _titleNavigationBar.frame.size.width, _titleNavigationBar.frame.size.height);
    UIGraphicsBeginImageContext(imageRect.size);
    [_blueColor set];
    UIRectFill(imageRect);
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [_titleNavigationBar setBackgroundImage:aImage forBarMetrics:UIBarMetricsDefault];
    
    [_titleNavigationLabel setBackgroundColor:_blueColor];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)tryConnectionAgain:(id)sender
{
    [_newsChannel getEventData];
    [_eventsTable reloadData];
}

- (void)viewDidUnload {
    _eventsTable = nil;
    _noConnectionButton = nil;
    _noConnectionLabel = nil;
    _noConnectionButton = nil;
    _eventsTableCell = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    //NSLog(@"events view controller: viewWillAppear: %i", [_newsChannel._newsItemArray count]);
    
    
    if (_actualTrials < 20)
    {
        _actualTrials++;
        [_newsChannel getEventData];
        [_eventsTable reloadData];
        if ( [_newsChannel._newsItemArray count] == 0)
        {
            self._noConnectionButton.hidden = NO;
            self._noConnectionLabel.hidden = NO;
        }
    }
}


//---------- Handling of table for suggestions -----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_newsChannel._newsItemArray count] > 0)
	{
        self._noConnectionButton.hidden = YES;
        self._noConnectionLabel.hidden = YES;
        //NSLog(@"events item array count: %i", [_newsChannel._newsItemArray count]);
        
		return [_newsChannel._newsItemArray count];
	}
	return 1;
}



// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"events view controller: cellForRowAtIndexPath");
    //if ([_newsChannel._newsItemArray count] == 0)
	//{
    // VERY IMPORTANT, OTHERWISE, NO NEW DATA
    // [self viewWillAppear:YES];
    //}
    
    NSUInteger        _cellSelection = indexPath.section;
    NSString         *_cellIdentifier;
    UITableViewCell  *_cell = nil;
    
    
    _cellIdentifier  = @"EventsTableCell";
    _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"EventsTableCell" owner:self options:nil];
        _cell = _eventsTableCell;
        self._eventsTableCell = nil;
    }
    
    UILabel     *_oneTitleLabel         = (UILabel *) [_cell viewWithTag:1];
    UIWebView   *_descriptionWebView    = (UIWebView *) [_cell viewWithTag:2];
    _descriptionWebView.scrollView.scrollEnabled = NO;
    _descriptionWebView.scrollView.bounces = NO;
    _descriptionWebView.dataDetectorTypes = UIDataDetectorTypeNone;
    
    if([_newsChannel._newsItemArray count] > 0)
    {
        //NSLog(@"item array count: %i >= _cellSelection: %i", [_newsChannel._newsItemArray count], _cellSelection);
        
        if ([_newsChannel._newsItemArray count] >= _cellSelection)
        {
            NewsItemDto *_newsItem = [_newsChannel._newsItemArray objectAtIndex:_cellSelection];
            
            //NSLog(@"_newsItem._title: %@ - _cellSelection: %i", _newsItem._title, _cellSelection);
            
            _oneTitleLabel.text     = _newsItem._title;
            [_oneTitleLabel setTextColor:_blueColor];
            
            [_descriptionWebView loadHTMLString:_newsItem._description baseURL:nil];
            //[_descriptionWebView loadHTMLString:_newsItem._content baseURL:nil];
            
            
        }
    }
    return _cell;
}

// set cell hight
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//_acronymTextField.text = [_suggestions objectAtIndex:indexPath.row];
    //_acronymAutocompleteTableView.hidden = YES;
}



@end
