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

@synthesize _titleLabel;
@synthesize _descriptionTitleLabel;

@synthesize _eventsTable;
@synthesize _eventsTableCell;

@synthesize _dateFormatter;

@synthesize _blueColor;

@synthesize _eventsDetailVC;

@synthesize _actualTrials;
@synthesize _noConnectionButton;
@synthesize _noConnectionLabel;


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
    
    [_titleLabel setBackgroundColor:_blueColor];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    
    [_descriptionTitleLabel setBackgroundColor:_blueColor];
    [_descriptionTitleLabel setTextColor:[UIColor whiteColor]];
    
    _dateFormatter = [[DateFormation alloc] init];
    
    _descriptionTitleLabel.text = [NSString stringWithFormat:@"   School of Engineering"];
    _titleLabel.text            = [NSString stringWithFormat:@"   Events"];
    
    // ----- DETAIL PAGE -----
    if (_eventsDetailVC == nil)
    {
		_eventsDetailVC = [[NewsDetailViewController alloc] init];
	}
    _eventsDetailVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    //[_newsChannel getEventsData];
    [_eventsTable reloadData];
    
    self._actualTrials = 1;
    
    _noConnectionButton.hidden = YES;
    _noConnectionLabel.hidden = YES;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)tryConnectionAgain:(id)sender
{
    [_newsChannel getEventData];
    [_eventsTable reloadData];
}

- (void)viewDidUnload {
    _titleLabel = nil;
    _descriptionTitleLabel = nil;
    _eventsTable = nil;
    _noConnectionButton = nil;
    _noConnectionLabel = nil;
    _noConnectionButton = nil;
    _eventsDetailVC = nil;
    _eventsTableCell = nil;
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

-(void) showEventsDetails:(id)sender event:(id)event
{
    NSSet       *_touches              = [event    allTouches];
    UITouch     *_touch                = [_touches anyObject ];
    CGPoint      _currentTouchPosition = [_touch locationInView:self._eventsTable];
    NSIndexPath *_indexPath            = [self._eventsTable indexPathForRowAtPoint: _currentTouchPosition];
    NSUInteger   _cellSelection        = _indexPath.section;
    
    if ([_newsChannel._newsItemArray count] >= _cellSelection)
	{
        NewsItemDto *_newsItem = [_newsChannel._newsItemArray objectAtIndex:_cellSelection];
        
        _eventsDetailVC._newsItem = _newsItem;
        _eventsDetailVC._dateLabel.hidden = YES;
        
        [self presentModalViewController:_eventsDetailVC animated:YES];
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
    UIButton    *_detailButton          = (UIButton *)[_cell viewWithTag:3];
    _detailButton.hidden        = YES;
    
    
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
            
            [_detailButton addTarget:self action:@selector(showEventsDetails  :event:) forControlEvents:UIControlEventTouchUpInside];
            _detailButton.hidden    = NO;
        }
    }
    return _cell;
}

// set cell hight
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 126;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//_acronymTextField.text = [_suggestions objectAtIndex:indexPath.row];
    //_acronymAutocompleteTableView.hidden = YES;
}



@end
