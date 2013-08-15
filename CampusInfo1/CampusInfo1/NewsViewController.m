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
@synthesize _newsTable;
@synthesize _newsTableCell;
@synthesize _dateFormatter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _newsChannel   = [[NewsChannelDto alloc]init];
    UIColor *_backgroundColor = [UIColor colorWithRed:1.0/255.0 green:100.0/255.0 blue:167.0/255.0 alpha:1.0];
    
    [_titleLabel setBackgroundColor:_backgroundColor];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    
    _dateFormatter = [[DateFormation alloc] init]; 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)_startNews:(id)sender
{
    [_newsChannel getData];
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
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     [_newsChannel getData];
    
    //NSLog(@"viewWillAppear: 2 _autocomplete._candidates count: %i", [_autocomplete._candidates count]);
    
    [_newsTable reloadData];
}


//---------- Handling of table for suggestions -----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection");
    return 4;
    
    /*
	if ([_newsChannel._newsItemArray count] > 0)
	{
        //NSLog(@"_suggestions: %i", [_suggestions count]);
		return [_newsChannel._newsItemArray count];
	}
	return 0;
     */
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"cellForRowAtIndexPath");
    
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
    
    NewsItemDto *_newsItem = [_newsChannel._newsItemArray objectAtIndex:indexPath.row];
    
//    _oneTitleLabel.text     = _newsItem._title;
//    _dateLabel.text         = [[_dateFormatter _englishTimeAndDayFormatter] stringFromDate:_newsItem._pubDate];
//    _descriptionLabel.text  = _newsItem._description;

    _oneTitleLabel.text     = @"irgendein Titel";
    _dateLabel.text         = @"22.12.2014";
    _descriptionLabel.text  = @"dann noch eine Beschreibung";

    
    return _cell;
}

// set cell hight
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 114;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//_acronymTextField.text = [_suggestions objectAtIndex:indexPath.row];
    //_acronymAutocompleteTableView.hidden = YES;
}



@end
