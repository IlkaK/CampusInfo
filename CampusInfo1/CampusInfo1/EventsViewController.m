//
//  EventsViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 14.08.13.
//
//

#import "EventsViewController.h"
#import "UIConstantStrings.h"

@interface EventsViewController ()

@end

@implementation EventsViewController

@synthesize _newsChannel;

@synthesize _eventsTable;
@synthesize _eventsTableCell;

@synthesize _dateFormatter;
@synthesize _zhawColor;

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
    
    // general initialization
    _newsChannel    = [[NewsChannelDto alloc]init];
    _dateFormatter  = [[DateFormation alloc] init];
    _zhawColor      = [[ColorSelection alloc]init];
    self._actualTrials = 1;
    

    // title
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToMenuOverview:)];
    
    [backButtonItem setTintColor:_zhawColor._zhawOriginalBlue];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = EventsVCTitle;
    _titleNavigationItem.title = @"";
    
    [_titleNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];
    [_titleNavigationLabel setTextAlignment:UITextAlignmentCenter];
    
    // set no connection label and button
    _noConnectionButton.hidden = YES;
    _noConnectionLabel.hidden = YES;
    [_noConnectionButton useAlertStyle];
    
    
    // event table reload
    [_eventsTable reloadData];
    
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
    //_newsChannel = [[NewsChannelDto alloc]init];
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
    
    
    //if (_actualTrials < 20)
    //{
        //_actualTrials++;

        //if ( [_newsChannel._newsItemArray count] == 0)
        //{
            [_newsChannel getEventData];
            [_eventsTable reloadData];
            
            if ( [_newsChannel._newsItemArray count] == 0)
            {
                self._noConnectionButton.hidden = NO;
                self._noConnectionLabel.hidden = NO;
            }
        //}
    //}
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
    UILabel     *_dateLabel             = (UILabel *) [_cell viewWithTag:3];
    
    _descriptionWebView.scrollView.scrollEnabled = NO;
    _descriptionWebView.scrollView.bounces = NO;
    _descriptionWebView.dataDetectorTypes = UIDataDetectorTypeNone;
    [_dateLabel     setTextColor:_zhawColor._zhawLightGrey];
    
    if([_newsChannel._newsItemArray count] > 0)
    {
        //NSLog(@"item array count: %i >= _cellSelection: %i", [_newsChannel._newsItemArray count], _cellSelection);
        
        if ([_newsChannel._newsItemArray count] >= _cellSelection)
        {
            NewsItemDto *_newsItem = [_newsChannel._newsItemArray objectAtIndex:_cellSelection];
            
            //NSLog(@"_newsItem._title: %@ - _cellSelection: %i", _newsItem._title, _cellSelection);
            
            _oneTitleLabel.text     = _newsItem._title;
            [_oneTitleLabel setTextColor:_zhawColor._zhawOriginalBlue];
            
            if([_newsItem._startdateString length] > 0 && [_newsItem._starttimeString length] > 0)
            {
                _dateLabel.text = [NSString stringWithFormat:@"%@, %@",_newsItem._startdateString, _newsItem._starttimeString];
            }
            else
            {
                if([_newsItem._startdateString length] > 0)
                {
                    _dateLabel.text = [NSString stringWithFormat:@"%@",_newsItem._startdateString];
                }
            }
            
            NSString *_descr = [NSString stringWithFormat:@"<html> \n"
                                           "<head> \n"
                                           "<style type=\"text/css\"> \n"
                                           "body {font-family: \"%@\";font-size: 13;}\n"
                                           "</style> \n"
                                           "</head> \n"
                                           "<body>%@</body> \n"
                                           "</html>", @"helvetica", _newsItem._description];
            
            [_descriptionWebView loadHTMLString:_descr baseURL:nil];            
        }
    }
    return _cell;
}

// set cell hight
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 179;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//_acronymTextField.text = [_suggestions objectAtIndex:indexPath.row];
    //_acronymAutocompleteTableView.hidden = YES;
}



@end
