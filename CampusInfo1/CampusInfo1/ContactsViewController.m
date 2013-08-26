//
//  ContactsViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 02.08.13.
//
//

#import "ContactsViewController.h"
#import "ColorSelection.h"

@interface ContactsViewController ()

@end

@implementation ContactsViewController

@synthesize _contactsTable;

@synthesize _contactsPhoneTableCell;
@synthesize _contactsPlaceTableCell;

@synthesize _currentEmail;
@synthesize _currentPhoneNumber;

@synthesize _titleNavigationLabel;
@synthesize _titleNavigationItem;
@synthesize _titleNavigationBar;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}


- (void)moveBackToContactsOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ColorSelection *_zhawColor = [[ColorSelection alloc]init];
    
    UIButton *backButton = [UIButton buttonWithType:101];
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backButton.frame.size.width, backButton.frame.size.height)];
    
    [backButton addTarget:self action:@selector(moveBackToContactsOverview:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"zurück" forState:UIControlStateNormal];
    [backButtonView addSubview:backButton];
    
    // set buttonview as custom view for bar button item
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = @"Sektretariate";
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
    _contactsTable = nil;
    _contactsPhoneTableCell = nil;
    _contactsPlaceTableCell = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    [super viewDidUnload];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView firstOtherButtonIndex])
    {
        NSString *_urlString = nil;
        if (_currentPhoneNumber != nil)
        {
            _urlString = [NSString stringWithFormat:@"tel://%@", self._currentPhoneNumber];
        }
        else
        {
            if(_currentEmail != nil)
            {
                _urlString = [NSString stringWithFormat:@"mailto:%@", self._currentEmail];
            }
        }

        //NSLog(@"calling/mailing %@", _urlString);
        
        if (_urlString != nil)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_urlString]];
        }
    }
}


-(void) sendEmailToGivenAdress:(id)sender event:(id)event
{
    NSSet            *_touches              = [event    allTouches];
    UITouch          *_touch                = [_touches anyObject ];
    CGPoint           _currentTouchPosition = [_touch locationInView:self._contactsTable];
    
    NSIndexPath      *_indexPath            = [self._contactsTable indexPathForRowAtPoint: _currentTouchPosition];
    NSUInteger        _cellSection          = _indexPath.section;
    NSUInteger        _cellRow              = _indexPath.row;
    
    NSString *_email;
    
    if(_cellSection == 0 && _cellRow == 10)
    {
        _email = @"info-sg.engineering@zhaw.ch";
    }
    if(_cellSection == 0 && _cellRow == 11)
    {
        _email = @"info-sg.zh.engineering@zhaw.ch";
    }
    
    if(_cellSection == 1 && _cellRow == 1)
    {
        _email = @"jennifer.hohl@zhaw.ch";
    }
    
    if(_cellSection == 2 && _cellRow == 1)
    {
        _email = @"weiterbildung.engineering@zhaw.ch";
    }
    
    NSString *_messageForCalling = [NSString stringWithFormat:@"Sende Email an %@?"
                                    , _email];
    
    UIAlertView *_acronymAlertView = [[UIAlertView alloc]
                                      initWithTitle:@"Weitere Dienste"
                                      message:_messageForCalling
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:@"Cancel", nil];
    _currentEmail       = _email;
    _currentPhoneNumber = nil;
    [_acronymAlertView show];
}


-(void) callGivenNumber:(id)sender event:(id)event
{
    NSSet            *_touches              = [event    allTouches];
    UITouch          *_touch                = [_touches anyObject ];
    CGPoint           _currentTouchPosition = [_touch locationInView:self._contactsTable];
    
    NSIndexPath      *_indexPath            = [self._contactsTable indexPathForRowAtPoint: _currentTouchPosition];
    NSUInteger        _cellSection          = _indexPath.section;
    NSUInteger        _cellRow              = _indexPath.row;
    
    NSString        *_callWhom;
    NSString        *_callNumber;
    
    if(   (_cellSection == 0 && _cellRow == 0)
       || (_cellSection == 0 && _cellRow == 9)
       )
    {
        _callWhom = @"Gianna Scherrer";
        _callNumber = @"0041589347560";
    }
    if(   (_cellSection == 0 && _cellRow == 1)
       || (_cellSection == 0 && _cellRow == 7)
       || (_cellSection == 0 && _cellRow == 8)
       )
    {
        _callWhom = @"Eliane Roth";
        _callNumber = @"0041589347366";
    }
    if(   (_cellSection == 0 && _cellRow == 2)
       || (_cellSection == 0 && _cellRow == 3)
       || (_cellSection == 1 && _cellRow == 0)
       )
    {
        _callWhom = @"Jennifer Hohl";
        _callNumber = @"0041589347563";
    }
    if(_cellSection == 0 && _cellRow == 4)
    {
        _callWhom = @"Zita Fejér";
        _callNumber = @"0041589348242";
    }
    if(   (_cellSection == 0 && _cellRow == 5)
       || (_cellSection == 0 && _cellRow == 6)
       )
    {
        _callWhom = @"Béatrice Schaffner";
        _callNumber = @"0041589347414";
    }
    if(_cellSection == 2 && _cellRow == 0)
    {
        _callWhom = @"Christine Rhiel";
        _callNumber = @"0041589347428";
    }
    
    NSString *_messageForCalling = [NSString stringWithFormat:@"%@ anrufen (%@)?"
                                    , _callWhom, _callNumber];
    
    UIAlertView *_acronymAlertView = [[UIAlertView alloc]
                                      initWithTitle:@"Weitere Dienste"
                                      message:_messageForCalling
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:@"Cancel", nil];
    _currentEmail       = nil;
    _currentPhoneNumber = _callNumber;
    [_acronymAlertView show];
}


// table and table cell handling

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *_sectionName;
    switch (section)
    {
        case 0:
            _sectionName = @"Bachelorsekretariat";
            break;
        case 1:
            _sectionName = @"Mastersekretariat";
            break;
        default:
            _sectionName = @"Weiterbildungssekretariat";
            break;
    }
    return _sectionName;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger *_numberRows;
    switch (section)
    {
        case 0:
            _numberRows = 12;
            break;
        case 1:
            _numberRows = 2;
            break;
        default:
            _numberRows = 2;
            break;
    }
    return _numberRows;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellSelection = indexPath.section;
    NSUInteger        _cellRow       = indexPath.row;
    
    //NSLog(@"_cellSelection: %i _cellRow: %i", _cellSelection, _cellRow);
    
    NSString         *_cellIdentifier;
    UITableViewCell  *_cell = nil;

    if (   (_cellSelection == 0 && _cellRow <= 9)
        || (_cellSelection == 1 && _cellRow == 0)
        || (_cellSelection == 2 && _cellRow == 0)
        )
    {
        _cellIdentifier  = @"ContactsPhoneTableCell";
        _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
        if (_cell == nil)
        {
            [[NSBundle mainBundle] loadNibNamed:@"ContactsPhoneTableCell" owner:self options:nil];
            _cell = _contactsPhoneTableCell;
            self._contactsPhoneTableCell = nil;
        }
        
        UILabel         *_labelTitle     = (UILabel *) [_cell viewWithTag:1];
        UILabel         *_labelPerson    = (UILabel *) [_cell viewWithTag:2];
        UIButton        *_numberButton   = (UIButton *)[_cell viewWithTag:3];
        NSString        *_numberButtonTitle;
        
        if(_cellSelection == 0 && _cellRow == 0)
        {
            _labelTitle.text = @"Aviatik";
            _labelPerson.text = @"Gianna Scherrer";
            _numberButtonTitle = @"Tel. +41 58 934 75 60";
        }
        if(_cellSelection == 0 && _cellRow == 1)
        {
            _labelTitle.text = @"Elektrotechnik";
            _labelPerson.text = @"Eliane Roth";
            _numberButtonTitle = @"Tel. +41 58 934 73 66";
        }
        if(_cellSelection == 0 && _cellRow == 2)
        {
            _labelTitle.text = @"Energie- und Umwelttechnik";
            _labelPerson.text = @"Jennifer Hohl";
            _numberButtonTitle = @"Tel. +41 58 934 75 63";
        }
        if(_cellSelection == 0 && _cellRow == 3)
        {
            _labelTitle.text = @"Informatik Standort Winterthur";
            _labelPerson.text = @"Jennifer Hohl";
            _numberButtonTitle = @"Tel. +41 58 934 75 63";
        }
        if(_cellSelection == 0 && _cellRow == 4)
        {
            _labelTitle.text = @"Informatik Standort Zürich";
            _labelPerson.text = @"Zita Fejér";
            _numberButtonTitle = @"Tel. +41 58 934 82 42";
        }
        if(_cellSelection == 0 && _cellRow == 5)
        {
            _labelTitle.text = @"Allgemeine Maschinentechnik";
            _labelPerson.text = @"Béatrice Schaffner";
            _numberButtonTitle = @"Tel. +41 58 934 74 14";
        }
        if(_cellSelection == 0 && _cellRow == 6)
        {
            _labelTitle.text = @"Material- und Verfahrenstechnik";
            _labelPerson.text = @"Béatrice Schaffner";
            _numberButtonTitle = @"Tel. +41 58 934 74 14";
        }
        if(_cellSelection == 0 && _cellRow == 7)
        {
            _labelTitle.text = @"Systemtechnik";
            _labelPerson.text = @"Eliane Roth";
            _numberButtonTitle = @"Tel. +41 58 934 73 66";
        }
        if(_cellSelection == 0 && _cellRow == 8)
        {
            _labelTitle.text = @"Verkehrssysteme";
            _labelPerson.text = @"Eliane Roth";
            _numberButtonTitle = @"Tel. +41 58 934 73 66";
        }
        if(_cellSelection == 0 && _cellRow == 9)
        {
            _labelTitle.text = @"Wirtschaftsingenieurwesen";
            _labelPerson.text = @"Gianna Scherrer";
            _numberButtonTitle = @"Tel. +41 58 934 75 60";
        }
        
        if(_cellSelection == 1 && _cellRow == 0)
        {
            _labelTitle.text = @"Master of Science in Engineering";
            _labelPerson.text = @"Jennifer Hohl";
            _numberButtonTitle = @"Tel. +41 58 934 75 63";
        }
        if(_cellSelection == 2 && _cellRow == 0)
        {
            _labelTitle.text = @"Weiterbildung (MAS, CAS, DAS und WBK)";
            _labelPerson.text = @"Christine Rhiel";
            _numberButtonTitle = @"Tel. +41 58 934 74 28";
        }
        
        _numberButton.enabled = true;
        [_numberButton addTarget:self action:@selector(callGivenNumber  :event:) forControlEvents:UIControlEventTouchUpInside];
        
        NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:_numberButtonTitle];
        
        [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
        
        [_numberButton setAttributedTitle:_titleString forState:UIControlStateNormal];
    }
        
        
    if(     (_cellSelection == 0 && _cellRow == 10)
        ||  (_cellSelection == 0 && _cellRow == 11)
        ||  (_cellSelection == 1 && _cellRow == 1)
        ||  (_cellSelection == 2 && _cellRow == 1)
       )
    {
        _cellIdentifier  = @"ContactsPlaceTableCell";
        _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
        if (_cell == nil)
        {
            [[NSBundle mainBundle] loadNibNamed:@"ContactsPlaceTableCell" owner:self options:nil];
                _cell = _contactsPlaceTableCell;
                self._contactsPlaceTableCell = nil;
        }
        UILabel         *_labelTitle     = (UILabel *) [_cell viewWithTag:1];
        UIButton        *_emailButton    = (UIButton *)[_cell viewWithTag:2];
        NSString        *_emailButtonTitle;

        if(_cellSelection == 0 && _cellRow == 10)
        {
            _labelTitle.text    = @"Standort Winterthur";
            _emailButtonTitle   = @"info-sg.engineering(at)zhaw.ch";
        }
        if(_cellSelection == 0 && _cellRow == 11)
        {
            _labelTitle.text    = @"Standort Zürich";
            _emailButtonTitle   = @"info-sg.zh.engineering(at)zhaw.ch";
        }
        if(_cellSelection == 1 && _cellRow == 1)
        {
            _labelTitle.text    = @"Masterstudiengang";
            _emailButtonTitle   = @"jennifer.hohl(at)zhaw.ch";
        }
        if(_cellSelection == 2 && _cellRow == 1)
        {
            _labelTitle.text    = @"Weiterbildung";
            _emailButtonTitle   = @"weiterbildung.engineering(at)zhaw.ch";
        }
            
        _emailButton.enabled = true;
        [_emailButton addTarget:self action:@selector(sendEmailToGivenAdress  :event:) forControlEvents:UIControlEventTouchUpInside];
            
        NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:_emailButtonTitle];
            
        [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
            
        [_emailButton setAttributedTitle:_titleString forState:UIControlStateNormal];
    }
    
    return _cell;
}



@end
