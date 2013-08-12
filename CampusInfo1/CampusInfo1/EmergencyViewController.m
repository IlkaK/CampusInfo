//
//  EmergencyViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 02.08.13.
//
//

#import "EmergencyViewController.h"

@interface EmergencyViewController ()

@end

@implementation EmergencyViewController

@synthesize _emergencyDetailTableCell;
@synthesize _emergencyOverviewTableCell;
@synthesize _emergencyTable;
@synthesize _emergencyInformTableCell;
@synthesize _emergencyCallNumber;

@synthesize _titleLabel;
@synthesize _backLabel;
@synthesize _backButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}


- (IBAction)moveBackToContactsOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView firstOtherButtonIndex])
    {
        
        NSString *_urlString = [NSString stringWithFormat:@"tel://%@", self._emergencyCallNumber];
        NSLog(@"calling %@", _urlString);
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_urlString]];
    }
}


-(void) callGivenNumber:(id)sender event:(id)event
{
    NSSet            *_touches              = [event    allTouches];
    UITouch          *_touch                = [_touches anyObject ];
    CGPoint           _currentTouchPosition = [_touch locationInView:self._emergencyTable];
    
    NSIndexPath      *_indexPath            = [self._emergencyTable indexPathForRowAtPoint: _currentTouchPosition];
    
    //NSLog(@"_indexPath %i", _indexPath.section);
    NSString *_callWhom;
    NSString *_callNumber;
    
    if(_indexPath.section == 1)
    {
        _callWhom = @"Die Polizei";
        _callNumber = @"117";
    }
    if(_indexPath.section == 2)
    {
        _callWhom = @"Die Feuerwehr";
        _callNumber = @"118";
    }
    if(_indexPath.section == 3)
    {
        _callWhom = @"Die Sanität";
        _callNumber = @"144";
    }
    if(_indexPath.section == 4)
    {
        _callWhom = @"Das Tox-Zentrum";
        _callNumber = @"145";
    }
    if(_indexPath.section == 5)
    {
        _callWhom = @"Die REGA";
        _callNumber = @"1414";
    }
    if(_indexPath.section == 7)
    {
        _callWhom = @"Die ZHAW-Notfallnummer";
        _callNumber = @"0589347070";
    }
    
    NSString *_messageForCalling = [NSString stringWithFormat:@"%@ anrufen (%@)?"
                                   , _callWhom, _callNumber];
    
    UIAlertView *_acronymAlertView = [[UIAlertView alloc]
                                      initWithTitle:@"Weitere Dienste"
                                      message:_messageForCalling
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:@"Cancel", nil];
    _emergencyCallNumber = _callNumber;
    [_acronymAlertView show];
// [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://1456987452"]];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // set table controller
    if (_emergencyTable == nil) {
		_emergencyTable = [[UITableView alloc] init];
	}
    _emergencyTable.separatorColor = [UIColor lightGrayColor];
    _emergencyTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [_emergencyTable reloadData];
    _emergencyCallNumber = @"";
    
    UIColor *_backgroundColor = [UIColor colorWithRed:1.0/255.0 green:100.0/255.0 blue:167.0/255.0 alpha:1.0];
    
    [_titleLabel setBackgroundColor:_backgroundColor];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    _titleLabel.text = @"   Notfall";
    
    [_backLabel setBackgroundColor:_backgroundColor];
    [_backLabel setTextColor:[UIColor whiteColor]];
    
    [_backButton setBackgroundColor:_backgroundColor];
    
    NSMutableAttributedString *_backButtonTitleString = [[NSMutableAttributedString alloc] initWithString:@"zurück"];
    
    [_backButtonTitleString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [_backButtonTitleString length])];
    
    [_backButton setAttributedTitle:_backButtonTitleString forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    _emergencyTable = nil;
    _emergencyDetailTableCell = nil;
    _emergencyOverviewTableCell = nil;
    _emergencyInformTableCell = nil;
    _titleLabel = nil;
    _backButton = nil;
    _backLabel = nil;
    [super viewDidUnload];
}


// table and table cell handling

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellSelection = indexPath.section;
    
    if (_cellSelection == 0 || _cellSelection == 6)
    {
        return 40;
    }
    if(_cellSelection == 7)
    {
        return 114;
    }
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellSelection = indexPath.section;
    static NSString *_cellIdentifier;
    UITableViewCell *_cell;
    
    if (_cellSelection == 0 || _cellSelection == 6)
    {
        _cellIdentifier  = @"EmergencyOverviewTableCell";
        _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
        if (_cell == nil)
        {
            [[NSBundle mainBundle] loadNibNamed:@"EmergencyOverviewTableCell" owner:self options:nil];
            _cell = _emergencyOverviewTableCell;
            self._emergencyOverviewTableCell = nil;
        }
        UILabel         *_labelTitle      = (UILabel *) [_cell viewWithTag:1];
        if (_cellSelection == 0)
        {
            _labelTitle.text = @"1. Alarmieren > wenn nötig";
        }
        if (_cellSelection == 6)
        {
            _labelTitle.text = @"2. Informieren > immer";
        }
    }
    else
    {
        UIButton        *_buttonNumber;
        NSString        *_buttonNumberTitle;
        
        if (_cellSelection == 7)
        {
            _cellIdentifier  = @"EmergencyInformTableCell";
            _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
            if (_cell == nil)
            {
                [[NSBundle mainBundle] loadNibNamed:@"EmergencyInformTableCell" owner:self options:nil];
                _cell = _emergencyInformTableCell;
                self._emergencyInformTableCell = nil;
            }
            _buttonNumber          = (UIButton *) [_cell viewWithTag:6];
            _buttonNumberTitle     = @"(0)058 9347070";
        }
        else
        {
        
            _cellIdentifier  = @"EmergencyDetailTableCell";
            _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
            if (_cell == nil)
            {
                [[NSBundle mainBundle] loadNibNamed:@"EmergencyDetailTableCell" owner:self options:nil];
                _cell = _emergencyDetailTableCell;
                self._emergencyDetailTableCell = nil;
            }
            UILabel         *_labelDescription      = (UILabel *) [_cell viewWithTag:1];
            _buttonNumber          = (UIButton *) [_cell viewWithTag:2];
        
            if (_cellSelection == 1)
            {
                _labelDescription.text = @"Polizei";
                _buttonNumberTitle = @"(0)117";
            }
            if (_cellSelection == 2)
            {
                _labelDescription.text = @"Feuerwehr";
                _buttonNumberTitle = @"(0)118";
            }
            if (_cellSelection == 3)
            {
                _labelDescription.text = @"Sanität";
                _buttonNumberTitle = @"(0)144";
            }
            if (_cellSelection == 4)
            {
                _labelDescription.text = @"Tox-Zentrum";
                _buttonNumberTitle = @"(0)145";
            }
            if (_cellSelection == 5)
            {
                _labelDescription.text = @"REGA";
                _buttonNumberTitle = @"(0)1414";
            }
        }
        _buttonNumber.enabled = true;
        [_buttonNumber addTarget:self action:@selector(callGivenNumber  :event:) forControlEvents:UIControlEventTouchUpInside];
            
        NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:_buttonNumberTitle];
        
        [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
        
        [_buttonNumber setAttributedTitle:_titleString forState:UIControlStateNormal];
        

    }
    return _cell;
}




@end
