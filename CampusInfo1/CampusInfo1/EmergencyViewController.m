//
//  EmergencyViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 02.08.13.
//
//

#import "EmergencyViewController.h"
#import "ColorSelection.h"

@interface EmergencyViewController ()

@end

@implementation EmergencyViewController

@synthesize _emergencyDetailTableCell;
@synthesize _emergencyTable;
@synthesize _emergencyInformTableCell;
@synthesize _emergencyCallNumber;

@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;
@synthesize _titleNavigationLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}


- (void)moveBackToContactsOverview:(id)sender
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
    NSUInteger        _cellSelection        = _indexPath.section;
    NSUInteger        _cellRow              = _indexPath.row;
    
    //NSLog(@"_indexPath %i", _indexPath.section);
    NSString *_callWhom;
    NSString *_callNumber;
    
    if(_cellSelection == 0 && _cellRow == 0)
    {
        _callWhom = @"Die Polizei";
        _callNumber = @"117";
    }
    if(_cellSelection == 0 && _cellRow == 1)
    {
        _callWhom = @"Die Feuerwehr";
        _callNumber = @"118";
    }
    if(_cellSelection == 0 && _cellRow == 2)
    {
        _callWhom = @"Die Sanität";
        _callNumber = @"144";
    }
    if(_cellSelection == 0 && _cellRow == 3)
    {
        _callWhom = @"Das Tox-Zentrum";
        _callNumber = @"145";
    }
    if(_cellSelection == 0 && _cellRow == 4)
    {
        _callWhom = @"Die REGA";
        _callNumber = @"1414";
    }
    if(_cellSelection == 1 && _cellRow == 0)
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

    ColorSelection *_zhawColor = [[ColorSelection alloc]init];
    _emergencyCallNumber = @"";
    
    UIButton *backButton = [UIButton buttonWithType:101];
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backButton.frame.size.width, backButton.frame.size.height)];
    
    [backButton addTarget:self action:@selector(moveBackToContactsOverview:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"zurück" forState:UIControlStateNormal];
    [backButtonView addSubview:backButton];
    
    // set buttonview as custom view for bar button item
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = @"Notfall";
    _titleNavigationItem.title = @"";
    
    CGRect imageRect = CGRectMake(0, 0, _titleNavigationBar.frame.size.width, _titleNavigationBar.frame.size.height);
    UIGraphicsBeginImageContext(imageRect.size);
    [_zhawColor._zhawOriginalBlue set];
    UIRectFill(imageRect);
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [_titleNavigationBar setBackgroundImage:aImage forBarMetrics:UIBarMetricsDefault];
    
    [_titleNavigationLabel setBackgroundColor:_zhawColor._zhawOriginalBlue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    _emergencyTable = nil;
    _emergencyDetailTableCell = nil;
    _emergencyInformTableCell = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    [super viewDidUnload];
}


// table and table cell handling
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *_sectionName;
    switch (section)
    {
        case 0:
            _sectionName = @"1. Alarmieren > wenn nötig";
            break;
        default:
            _sectionName = @"2. Informieren > immer";
            break;
    }
    return _sectionName;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger *_numberRows;
    switch (section)
    {
        case 0:
            _numberRows = 5;
            break;
        default:
            _numberRows = 1;
            break;
    }
    return _numberRows;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellSelection = indexPath.section;
    CGFloat           _cellHeight    = 30;    
    if (_cellSelection == 0)
    {
        _cellHeight = 30;
    }
    if(_cellSelection == 1)
    {
        return 47;
    }
    return _cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellSelection = indexPath.section;
    NSUInteger        _cellRow       = indexPath.row;

    static NSString *_cellIdentifier;
    UITableViewCell *_cell;
    
    UIButton        *_buttonNumber;
    NSString        *_buttonNumberTitle;
    
    // 2. informieren immer
    if (_cellSelection == 1)
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
        
        if (_cellRow == 0)
        {
            _labelDescription.text = @"Polizei";
            _buttonNumberTitle = @"(0)117";
        }
        if (_cellRow == 1)
        {
            _labelDescription.text = @"Feuerwehr";
            _buttonNumberTitle = @"(0)118";
        }
        if (_cellRow == 2)
        {
            _labelDescription.text = @"Sanität";
            _buttonNumberTitle = @"(0)144";
        }
        if (_cellRow == 3)
        {
            _labelDescription.text = @"Tox-Zentrum";
            _buttonNumberTitle = @"(0)145";
        }
        if (_cellRow == 4)
        {
            _labelDescription.text = @"REGA";
            _buttonNumberTitle = @"(0)1414";
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
