//
//  NewsViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 14.08.13.
//
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController
@synthesize _newsChannel;

@synthesize _titleLabel;
@synthesize _descriptionTitleLabel;

@synthesize _newsTable;
@synthesize _newsTableCell;

@synthesize _dateFormatter;

@synthesize _blueColor;

@synthesize _newsDetailVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _newsChannel   = [[NewsChannelDto alloc]init];
    _blueColor = [UIColor colorWithRed:1.0/255.0 green:100.0/255.0 blue:167.0/255.0 alpha:1.0];
    
    [_titleLabel setBackgroundColor:_blueColor];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    
    [_descriptionTitleLabel setBackgroundColor:_blueColor];
    [_descriptionTitleLabel setTextColor:[UIColor whiteColor]];
    
    _dateFormatter = [[DateFormation alloc] init];
    
    _descriptionTitleLabel.text = [NSString stringWithFormat:@"   School of Engineering"];
    _titleLabel.text            = [NSString stringWithFormat:@"   News"];

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


- (IBAction)moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    //self.tabBarController.selectedIndex = 0;
}

- (void)viewDidUnload {
    _titleLabel = nil;
    _newsTable = nil;
    _newsTableCell = nil;
    _descriptionTitleLabel = nil;
    _newsDetailVC = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     [_newsChannel getData];

    
    //NSLog(@"viewWillAppear: 2 _autocomplete._candidates count: %i", [_autocomplete._candidates count]);
    
    [_newsTable reloadData];
}

-(void) showNewsDetails:(id)sender event:(id)event
{
    NSSet       *_touches              = [event    allTouches];
    UITouch     *_touch                = [_touches anyObject ];
    CGPoint      _currentTouchPosition = [_touch locationInView:self._newsTable];
    NSIndexPath *_indexPath            = [self._newsTable indexPathForRowAtPoint: _currentTouchPosition];
    
    if ([_newsChannel._newsItemArray count] >= _indexPath.row)
	{
        NewsItemDto *_newsItem = [_newsChannel._newsItemArray objectAtIndex:_indexPath.row];
        
        _newsDetailVC._newsItem = _newsItem;

        [self presentModalViewController:_newsDetailVC animated:YES];
    }
}


//---------- Handling of table for suggestions -----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"numberOfRowsInSection");
    if ([_newsChannel._newsItemArray count] > 0)
	{
        //NSLog(@"_suggestions: %i", [_suggestions count]);
		return [_newsChannel._newsItemArray count];
	}
	return 0;
     
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_newsChannel._newsItemArray count] == 0)
	{
     [_newsChannel getData];
    }
    
    //NSUInteger        _cellSelection = indexPath.section;
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
    UIButton *_detailButton      = (UIButton *) [_cell viewWithTag:4];
    
    //NSLog(@"item array count: %i - index row: %i", [_newsChannel._newsItemArray count], indexPath.row);
    
    if ([_newsChannel._newsItemArray count] >= indexPath.row)
	{
        NewsItemDto *_newsItem = [_newsChannel._newsItemArray objectAtIndex:indexPath.row];
    
        _oneTitleLabel.text     = _newsItem._title;
        _dateLabel.text         = [NSString stringWithFormat:@"%@"
                                   ,[[_dateFormatter _dayFormatter] stringFromDate:_newsItem._pubDate]];
        _descriptionLabel.text  = _newsItem._description;
    
        [_oneTitleLabel setTextColor:_blueColor];
        [_dateLabel     setTextColor:[UIColor lightGrayColor]];
        
         [_detailButton addTarget:self action:@selector(showNewsDetails  :event:) forControlEvents:UIControlEventTouchUpInside];
        
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
