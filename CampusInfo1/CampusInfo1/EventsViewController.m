/*
 EventsViewController.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header EventsViewController.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of EventsViewController.xib, where displays all events in a table. </li>
 *      <li> Getting and handling event data via NewsChannelDto.  </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives delegate from MenuOverviewController and passes it back, if back button is clicked. </li>
 *      <li> It receives data from NewsChannelDto, which establishes a connection to server. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It passes the data type to NewsChannelDto. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

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

@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;

@synthesize _waitForLoadingActivityIndicator;
@synthesize _noConnectionLabel;

/*!
 * @function initWithNibName
 * Initializiation of class.
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

/*!
 * @function prefersStatusBarHidden
 * Used to hide the iOS status bar with time and battery symbol.
 */
-(BOOL) prefersStatusBarHidden
{
    return YES;
}

/*!
 * @function viewDidLoad
 * The function is included, since class inherits from UIViewController.
 * Is called first time, the view is started for initialization.
 * Is only called once, after initialization, never again.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // general initialization
    _newsChannel    = [[NewsChannelDto alloc]init];
    _dateFormatter  = [[DateFormation alloc] init];
    _zhawColor      = [[ColorSelection alloc]init];
    self._newsChannel = [NewsChannelDto alloc];
    self._actualTrials = 1;
    
    // title
    UIBarButtonItem *_backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStyleBordered target:self action:@selector(moveBackToMenuOverview:)];
    [_backButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:_zhawColor._zhawWhite} forState:UIControlStateNormal];
    [_titleNavigationItem setLeftBarButtonItem :_backButtonItem animated :true];
    [_titleNavigationItem setTitle:EventsVCTitle];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: _zhawColor._zhawWhite,
                                                           UITextAttributeFont: [UIFont fontWithName:NavigationBarFont size:NavigationBarTitleSize],
                                                           }];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:NavigationBarBackground] forBarMetrics:UIBarMetricsDefault];
    
    
    
    
    
    // set no connection label and button
    _noConnectionButton.hidden = YES;
    _noConnectionLabel.hidden = YES;
    [_noConnectionButton useAlertStyle];
    [_noConnectionLabel setTextColor:_zhawColor._zhawFontGrey];
    
    // set activity indicator
    _waitForLoadingActivityIndicator.hidesWhenStopped = YES;
    _waitForLoadingActivityIndicator.hidden = YES;
    [_waitForLoadingActivityIndicator setColor:_zhawColor._zhawOriginalBlue];
    [self.view bringSubviewToFront:_waitForLoadingActivityIndicator];
}


/*!
 * @function didReceiveMemoryWarning
 * The function is included per default.
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 @function moveBackToMenuOverview
 When back button is triggered, delegate is returned to MenuOverviewController.
 @param sender
 */
- (void)moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

/*!
 @function tryConnectionAgain
 Triggered by clicking the _noConnectionButton, another trial to connect to server is started.
 @param sender
 */
- (IBAction)tryConnectionAgain:(id)sender
{
    [self startLoading];
    [self doneLoading];
}

/*!
 @function viewDidUnload
 * The function is included, since class inherits from UIViewController.
 * It is called while the view is unloaded.
 */
- (void)viewDidUnload {
    _eventsTable = nil;
    _noConnectionButton = nil;
    _noConnectionLabel = nil;
    _noConnectionButton = nil;
    _eventsTableCell = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _waitForLoadingActivityIndicator = nil;
    [super viewDidUnload];
}

/*!
 * @function threadWaitForLoadingActivityIndicator
 * Thread is called to start the activity indicator while waiting for data to be downloaded.
 */
- (void) threadWaitForLoadingActivityIndicator:(id)data
{
    _waitForLoadingActivityIndicator.hidden = NO;
    [_waitForLoadingActivityIndicator startAnimating];
}


/*!
 * @function startLoading
 * Start loading, therefore hide no connection button and label and start activity indicator.
 */
-(void)startLoading
{
    self._noConnectionButton.hidden = YES;
    self._noConnectionLabel.hidden = YES;
    [NSThread detachNewThreadSelector:@selector(threadWaitForLoadingActivityIndicator:) toTarget:self withObject:nil];
}

/*!
 * @function doneLoading
 * Loading is done, so stop activity indicator.
 * If no data is found, display no connection button and label.
 */
-(void)doneLoading
{
    self._newsChannel = [_newsChannel initWithDataType:@"EVENTS"];
    [_eventsTable reloadData];
    [_waitForLoadingActivityIndicator stopAnimating];
    _waitForLoadingActivityIndicator.hidden = YES;
    
    if ( [_newsChannel._newsItemArray count] == 0 )
    {
        _noConnectionButton.hidden = NO;
        _noConnectionLabel.hidden = NO;
    }
}

/*!
 * @function viewWillAppear
 * The function is included, since class inherits from UIViewController.
 * It is called every time the view is called again.
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startLoading];
}

/*!
 * @function viewDidAppear
 * The function is included, since class inherits from UIViewController.
 * It is called before viewWillAppear is called.
 * It is needed to respond to the shaking gesture.
 */
-(void)viewDidAppear:(BOOL)animated
{
    [self doneLoading];
}


//---------- Handling of table  -----
/*!
 * @function numberOfSectionsInTableView
 * The function defines the number of sections in table.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_newsChannel._newsItemArray count];
}

/*!
 * @function numberOfRowsInSection
 * The function defines the number of rows in table.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

/*!
 * @function cellForRowAtIndexPath
 * The function is for customizing the table view cells.
 */
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
            
            NSString *_descr = [NSString stringWithFormat:NewsWebViewHtml, NewsWebViewFont, _newsItem._description];
            
            [_descriptionWebView loadHTMLString:_descr baseURL:nil];            
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
    return 179;
}

/*!
 * @function didSelectRowAtIndexPath
 * The function supports row selection.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//_acronymTextField.text = [_suggestions objectAtIndex:indexPath.row];
    //_acronymAutocompleteTableView.hidden = YES;
}


@end
