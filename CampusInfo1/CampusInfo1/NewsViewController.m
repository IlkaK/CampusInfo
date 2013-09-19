//
//  NewsViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 14.08.13.
//
//

#import "NewsViewController.h"
#import "UIConstantStrings.h"

@interface NewsViewController ()

@end

@implementation NewsViewController
@synthesize _newsChannel;

@synthesize _newsTable;
@synthesize _newsTableCell;

@synthesize _dateFormatter;
@synthesize _zhawColor;

@synthesize _newsDetailVC;

@synthesize _actualTrials;
@synthesize _noConnectionButton;
@synthesize _noConnectionLabel;

@synthesize _titleNavigationBar;
@synthesize _titleNavigationLabel;
@synthesize _titleNavigationItem;

@synthesize _waitForLoadingActivityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

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
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToMenuOverview:)];
    
    [backButtonItem setTintColor:_zhawColor._zhawOriginalBlue];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = NewsVCTitle;
    _titleNavigationItem.title = @"";
    
    [_titleNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];
    [_titleNavigationLabel setTextAlignment:UITextAlignmentCenter];
    
    // set no connection button and label
    _noConnectionButton.hidden = YES;
    _noConnectionLabel.hidden = YES;
    [_noConnectionButton useAlertStyle];
    [_noConnectionLabel setTextColor:_zhawColor._zhawFontGrey];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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


- (IBAction)tryConnectionAgain:(id)sender
{
    [self startLoading];
    [self doneLoading];
}

- (void)moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    //self.tabBarController.selectedIndex = 0;
}

- (void)viewDidUnload {
    _newsTable = nil;
    _newsTableCell = nil;
    _newsDetailVC = nil;
    _noConnectionButton = nil;
    _noConnectionLabel = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    _waitForLoadingActivityIndicator = nil;
    [super viewDidUnload];
}

- (void) threadWaitForLoadingActivityIndicator:(id)data
{
    _waitForLoadingActivityIndicator.hidden = NO;
    [_waitForLoadingActivityIndicator startAnimating];
}

-(void)startLoading
{
    self._noConnectionButton.hidden = YES;
    self._noConnectionLabel.hidden = YES;
    [NSThread detachNewThreadSelector:@selector(threadWaitForLoadingActivityIndicator:) toTarget:self withObject:nil];
}

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


- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    [self startLoading];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self doneLoading];
}


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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_newsChannel._newsItemArray count];
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
    
    
    _cellIdentifier  = @"NewsTableCell";
    _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (_cell == nil)
    {
         [[NSBundle mainBundle] loadNibNamed:@"NewsTableCell" owner:self options:nil];
         _cell = _newsTableCell;
         self._newsTableCell = nil;
    }
    
    UILabel *_oneTitleLabel     = (UILabel *) [_cell viewWithTag:1];
    UILabel *_dateLabel         = (UILabel *) [_cell viewWithTag:2];
    UILabel *_descriptionLabel  = (UILabel *) [_cell viewWithTag:3];
    UIButton *_detailButton     = (UIButton *)[_cell viewWithTag:4];
    _detailButton.hidden        = YES;
    
    [_oneTitleLabel     setTextColor:_zhawColor._zhawOriginalBlue];
    [_dateLabel         setTextColor:_zhawColor._zhawLightGrey];
    [_descriptionLabel  setTextColor:_zhawColor._zhawFontGrey];
    
    if([_newsChannel._newsItemArray count] > 0)
    {
        //NSLog(@"item array count: %i >= _cellSelection: %i", [_newsChannel._newsItemArray count], _cellSelection);
        
        // might need to delay indexing the objects within array too early
        int newsItemArrayCount = [_newsChannel._newsItemArray count];
        
        if (newsItemArrayCount >= _cellSelection)
        {
            NewsItemDto *_newsItem = [_newsChannel._newsItemArray objectAtIndex:_cellSelection];
            
            //NSLog(@"_newsItem._title: %@ - _cellSelection: %i", _newsItem._title, _cellSelection);
            
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
