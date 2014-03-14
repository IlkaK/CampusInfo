/*
 NewsViewController.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header NewsViewController.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of NewsViewController.xib, where an overview of all news is displayed in a table. </li>
 *      <li> Getting and handling news data via NewsChannelDto.  </li>
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
 *      <li> It passes the delegate to NewsDetailViewController. </li>
 *      <li> It also passes the news channel data to NewsDetailViewController, so it can display the details. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "NewsViewController.h"
#import "UIConstantStrings.h"

@interface NewsViewController ()

@end

@implementation NewsViewController
@synthesize _newsChannel;

@synthesize _newsTable;
@synthesize _newsTableCell;
@synthesize _newsSmallTableCell;
@synthesize _newsNormalTableCell;
@synthesize _newsLargeTableCell;

@synthesize _dateFormatter;
@synthesize _zhawColor;

@synthesize _newsDetailVC;

@synthesize _actualTrials;
@synthesize _noConnectionButton;
@synthesize _noConnectionLabel;

@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;

@synthesize _waitForLoadingActivityIndicator;

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
    //NSLog(@"news view controller: viewDidLoad");
    [super viewDidLoad];

    // general initializing
    _newsChannel   = [[NewsChannelDto alloc]init];
    _dateFormatter = [[DateFormation alloc] init];
    _zhawColor     = [[ColorSelection alloc]init];

    self._actualTrials = 1;
    
    // title
    UIBarButtonItem *_backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStyleBordered target:self action:@selector(moveBackToMenuOverview:)];
    [_backButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:_zhawColor._zhawWhite} forState:UIControlStateNormal];
    [_titleNavigationItem setLeftBarButtonItem :_backButtonItem animated :true];
    [_titleNavigationItem setTitle:NSLocalizedString(@"NewsVCTitle", nil)];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: _zhawColor._zhawWhite,
                                                           UITextAttributeFont: [UIFont fontWithName:NavigationBarFont size:NavigationBarTitleSize],
                                                           }];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:NavigationBarBackground] forBarMetrics:UIBarMetricsDefault];

    
    // set no connection button and label
    _noConnectionButton.hidden = YES;
    _noConnectionLabel.hidden = YES;
    [_noConnectionLabel setText:NSLocalizedString(@"noConnection", nil)];
    [_noConnectionButton setTitle:NSLocalizedString(@"tryAgain", nil) forState:UIControlStateNormal];
    [_noConnectionButton setTitleColor:_zhawColor._zhawWhite forState:UIControlStateNormal];
    [_noConnectionButton setBackgroundImage:[UIImage imageNamed:NoConnectionButtonBackground]  forState:UIControlStateNormal];
    [_noConnectionLabel setTextColor:_zhawColor._zhawFontGrey];
    [_noConnectionLabel setBackgroundColor:_zhawColor._zhawWhite];
    [self.view bringSubviewToFront:_noConnectionButton];
    [self.view bringSubviewToFront:_noConnectionLabel];
    
    // set activity indicator
    _waitForLoadingActivityIndicator.hidesWhenStopped = YES;
    _waitForLoadingActivityIndicator.hidden = YES;
    [_waitForLoadingActivityIndicator setColor:_zhawColor._zhawOriginalBlue];
    [self.view bringSubviewToFront:_waitForLoadingActivityIndicator];

    
    // ----- DETAIL PAGE -----
    if (_newsDetailVC == nil)
    {
		_newsDetailVC = [[NewsDetailViewController alloc] init];
	}
    _newsDetailVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
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
 * @function sortNewsItems
 * Sorts the news items dependent on their publishing date.
 */
-(void) sortNewsItems
{

    //int someArrayI;
    //for (someArrayI = 0; someArrayI < [_newsChannel._newsItemArray count]; someArrayI++)
    //{
    //    NewsItemDto *_oneItem = [_newsChannel._newsItemArray objectAtIndex:someArrayI];
        //NSLog(@"before sorting _oneItem date %@ and title %@", [NSString stringWithFormat:@"%@"
        //                                                       ,[[_dateFormatter _dayFormatter] stringFromDate:_oneItem._pubDate]], _oneItem._title);
    //}
       
       [_newsChannel._newsItemArray sortUsingComparator:^NSComparisonResult(NewsItemDto *a, NewsItemDto *b)
        {
            
            //int timestamp1 = [a._pubDate timeIntervalSince1970];
            //int timestamp2 = [b._pubDate timeIntervalSince1970];
            
            NSString *_compareInEnglishDateFormat1 = [NSString stringWithFormat:@"%.0f", [a._pubDate timeIntervalSince1970]];
            NSString *_compareInEnglishDateFormat2 = [NSString stringWithFormat:@"%.0f", [b._pubDate timeIntervalSince1970]];
            
            //NSString *_compareInEnglishDateFormat1 = [[_dateFormatter _dayFormatter] stringFromDate:a._pubDate];
            //NSString *_compareInEnglishDateFormat2 = [[_dateFormatter _dayFormatter] stringFromDate:b._pubDate];
            
            return [_compareInEnglishDateFormat1 compare:_compareInEnglishDateFormat2];
        }
        ];
    //for (someArrayI = 0; someArrayI < [_newsChannel._newsItemArray count]; someArrayI++)
    //{
    //    NewsItemDto *_oneItem = [_newsChannel._newsItemArray objectAtIndex:someArrayI];
        
        //NSLog(@"after sorting _oneItem date %@ and title %@", [NSString stringWithFormat:@"%@"
        //                                         ,[[_dateFormatter _dayFormatter] stringFromDate:_oneItem._pubDate]], _oneItem._title);
    //}
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
 @function moveBackToMenuOverview
 When back button is triggered, delegate is returned to MenuOverviewController.
 @param sender
 */
- (void)moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

/*!
 @function viewDidUnload
 * The function is included, since class inherits from UIViewController.
 * It is called while the view is unloaded.
 */
- (void)viewDidUnload {
    _newsTable = nil;
    _newsTableCell = nil;
    _newsSmallTableCell = nil;
    _newsNormalTableCell = nil;
    _newsLargeTableCell = nil;
    _newsDetailVC = nil;
    _noConnectionButton = nil;
    _noConnectionLabel = nil;
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
    self._newsChannel = [_newsChannel initWithDataType:@"NEWS"];
    [_newsTable reloadData];
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

/*!
 * @function showNewsDetails
 * If detail button in table cells is clicked, this method is called.
 * It passes the news data and the delegate to NewsDetailViewController.
 */
-(void) showNewsDetails:(id)sender event:(id)event
{
    NSSet       *_touches              = [event    allTouches];
    UITouch     *_touch                = [_touches anyObject ];
    CGPoint      _currentTouchPosition = [_touch locationInView:self._newsTable];
    NSIndexPath *_indexPath            = [self._newsTable indexPathForRowAtPoint: _currentTouchPosition];
    NSUInteger        _cellSelection = _indexPath.section;
    
    if ([_newsChannel._newsItemArray count] >= _cellSelection)
	{
        NewsItemDto *_newsItem = [_newsChannel._newsItemArray objectAtIndex:_cellSelection];
        
        _newsDetailVC._newsItem = _newsItem;

        [self presentModalViewController:_newsDetailVC animated:YES];
    }
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
    
    if([_newsChannel._newsItemArray count] > 0)
    {
        //NSLog(@"item array count: %i >= _cellSelection: %i", [_newsChannel._newsItemArray count], _cellSelection);
        
        // might need to delay indexing the objects within array too early
        int newsItemArrayCount = [_newsChannel._newsItemArray count];
        
        if (newsItemArrayCount >= _cellSelection)
        {
            NewsItemDto *_newsItem = [_newsChannel._newsItemArray objectAtIndex:_cellSelection];
            
            if ([_newsItem._description length] <= 100)
            {
                _cellIdentifier  = @"NewsSmallTableCell";
                _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
                
                if (_cell == nil)
                {
                    [[NSBundle mainBundle] loadNibNamed:@"NewsSmallTableCell" owner:self options:nil];
                    _cell = _newsSmallTableCell;
                    self._newsSmallTableCell = nil;
                }
            }
            else
            {
                if ([_newsItem._description length] >= 200)
                {
                    _cellIdentifier  = @"NewsLargeTableCell";
                    _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
                    
                    if (_cell == nil)
                    {
                        [[NSBundle mainBundle] loadNibNamed:@"NewsLargeTableCell" owner:self options:nil];
                        _cell = _newsLargeTableCell;
                        self._newsLargeTableCell = nil;
                    }
                }
                else
                {
                    _cellIdentifier  = @"NewsNormalTableCell";
                    _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
                    
                    if (_cell == nil)
                    {
                        [[NSBundle mainBundle] loadNibNamed:@"NewsNormalTableCell" owner:self options:nil];
                        _cell = _newsNormalTableCell;
                        self._newsNormalTableCell = nil;
                    }
                }
            }
            
    
            UILabel *_oneTitleLabel     = (UILabel *) [_cell viewWithTag:1];
            UILabel *_dateLabel         = (UILabel *) [_cell viewWithTag:2];
            UILabel *_descriptionLabel  = (UILabel *) [_cell viewWithTag:3];
            UIButton *_detailButton     = (UIButton *)[_cell viewWithTag:4];
            _detailButton.hidden        = YES;
    
            [_oneTitleLabel     setTextColor:_zhawColor._zhawOriginalBlue];
            [_dateLabel         setTextColor:_zhawColor._zhawLightGrey];
            [_descriptionLabel  setTextColor:_zhawColor._zhawFontGrey];
    
            _oneTitleLabel.text     = _newsItem._title;
            _dateLabel.text         = [NSString stringWithFormat:@"%@"
                                       ,[[_dateFormatter _dayFormatter] stringFromDate:_newsItem._pubDate]];
            _descriptionLabel.text  = _newsItem._description;
        
            [_detailButton addTarget:self action:@selector(showNewsDetails  :event:) forControlEvents:UIControlEventTouchUpInside];
            _detailButton.hidden    = NO;
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
    NSUInteger        _cellSelection = indexPath.section;
    CGFloat           _finalHeight = 126;;
    
    if([_newsChannel._newsItemArray count] > 0)
    {
        //NSLog(@"item array count: %i >= _cellSelection: %i", [_newsChannel._newsItemArray count], _cellSelection);
        
        // might need to delay indexing the objects within array too early
        int newsItemArrayCount = [_newsChannel._newsItemArray count];
        
        if (newsItemArrayCount >= _cellSelection)
        {
            NewsItemDto *_newsItem = [_newsChannel._newsItemArray objectAtIndex:_cellSelection];
            
            if ([_newsItem._description length] <= 100)
            {
                _finalHeight = 90;
            }
            else
            {
                if ([_newsItem._description length] >= 200)
                {
                    _finalHeight = 160;
                }
            }
        }
    }
    return _finalHeight;
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
