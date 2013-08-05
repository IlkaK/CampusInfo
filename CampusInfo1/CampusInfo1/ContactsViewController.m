//
//  ContactsViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 02.08.13.
//
//

#import "ContactsViewController.h"

@interface ContactsViewController ()

@end

@implementation ContactsViewController

@synthesize _backToSettingsNavigationItem;
@synthesize _titleLabel;
@synthesize _contactsTable;

@synthesize _contactsOverviewTableCell;
@synthesize _contactsPhoneTableCell;
@synthesize _contactsPlaceTableCell;
@synthesize _contactsSocialMediaTableCell;

@synthesize _currentEmail;
@synthesize _currentPhoneNumber;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) backToSettings:(id)sender
{
     [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage         *_leftButtonImage = [UIImage imageNamed:@"arrowLeft_small.png"];
    UIBarButtonItem *_leftButton      = [[UIBarButtonItem alloc] initWithImage: _leftButtonImage
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self
                                                                        action:@selector(backToSettings:)];
    
    [_backToSettingsNavigationItem setLeftBarButtonItem :_leftButton animated :true];
    _backToSettingsNavigationItem.title = @"";

    [self.view bringSubviewToFront:_titleLabel];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    _titleLabel.text = @"Studium und Weiterbildung";
    _backToSettingsNavigationItem.title = @"";
    self.navigationItem.titleView = _titleLabel;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    _backToSettingsNavigationItem = nil;
    _contactsTable = nil;
    _contactsOverviewTableCell = nil;
    _contactsPhoneTableCell = nil;
    _contactsPlaceTableCell = nil;
    _titleLabel = nil;
    _contactsSocialMediaTableCell = nil;
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

        NSLog(@"calling/mailing %@", _urlString);
        
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

    NSString *_email;
    
    if(_indexPath.section == 1)
    {
        _email = @"info-sg.engineering@zhaw.ch";
    }
    if(_indexPath.section == 2)
    {
        _email = @"info-sg.zh.engineering@zhaw.ch";
    }
    if(_indexPath.section == 17)
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
    
    //NSLog(@"_indexPath %i", _indexPath.section);
    NSString *_callWhom;
    NSString *_callNumber;
    
    if(_indexPath.section == 3 || _indexPath.section == 12)
    {
        _callWhom = @"Gianna Scherrer";
        _callNumber = @"0041589347560";
    }
    if(_indexPath.section == 4 || _indexPath.section == 10  || _indexPath.section == 11)
    {
        _callWhom = @"Eliane Roth";
        _callNumber = @"0041589347366";
    }
    if(_indexPath.section == 5 || _indexPath.section == 6 || _indexPath.section == 15)
    {
        _callWhom = @"Jennifer Hohl";
        _callNumber = @"0041589347563";
    }
    if(_indexPath.section == 7)
    {
        _callWhom = @"Zita Fejér";
        _callNumber = @"0041589348242";
    }
    if(_indexPath.section == 8 || _indexPath.section == 9)
    {
        _callWhom = @"Béatrice Schaffner";
        _callNumber = @"0041589347414";
    }
    if(_indexPath.section == 18)
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

-(void) openURLFacebook:(id)sender event:(id)event
{
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/engineering.zhaw"]];
}

-(void) openURLYoutube:(id)sender event:(id)event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.youtube.com/engineeringzhaw"]];
}

-(void) openURLTwitter:(id)sender event:(id)event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/engineeringzhaw"]];
}

-(void) openURLIssuu:(id)sender event:(id)event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://issuu.com/engineeringzhaw"]];
}

-(void) openURLXing:(id)sender event:(id)event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.xing.com/companies/zhawschoolofengineering"]];
}

// table and table cell handling

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 20;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellSelection = indexPath.section;
    
    // overview table cell
    if (_cellSelection == 0 || _cellSelection == 13 || _cellSelection == 16)
    {
        return 30;
    }
    // email table cell
    if(_cellSelection == 1 || _cellSelection == 2 || _cellSelection == 14 || _cellSelection == 17)
    {
        return 42;
    }
    
    if(_cellSelection == 19)
    {
        return 69;
    }
    
    // _cellSelection: 3-12, 15, 18
    // phone table cell
    return 43;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellSelection = indexPath.section;
    NSString         *_cellIdentifier;
    UITableViewCell  *_cell = nil;

    if (_cellSelection == 19)
    {
        _cellIdentifier  = @"ContactsSocialMediaTableCell";
        _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
        if (_cell == nil)
        {
            [[NSBundle mainBundle] loadNibNamed:@"ContactsSocialMediaTableCell" owner:self options:nil];
            _cell = _contactsSocialMediaTableCell;
            self._contactsSocialMediaTableCell = nil;
        }
        UIButton *_facebookButton  = (UIButton *) [_cell viewWithTag:2];
        UIButton *_youtubeButton   = (UIButton *) [_cell viewWithTag:3];
        UIButton *_twitterButton   = (UIButton *) [_cell viewWithTag:4];
        UIButton *_issuuButton     = (UIButton *) [_cell viewWithTag:5];
        UIButton *_xingButton      = (UIButton *) [_cell viewWithTag:6];
        
        _facebookButton.enabled = true;
        [_facebookButton addTarget:self action:@selector(openURLFacebook:event:) forControlEvents:UIControlEventTouchUpInside];
        
        _youtubeButton.enabled = true;
        [_youtubeButton addTarget:self action:@selector(openURLYoutube:event:) forControlEvents:UIControlEventTouchUpInside];
        
        _twitterButton.enabled = true;
        [_twitterButton addTarget:self action:@selector(openURLTwitter:event:) forControlEvents:UIControlEventTouchUpInside];
        
        _issuuButton.enabled = true;
        [_issuuButton addTarget:self action:@selector(openURLIssuu:event:) forControlEvents:UIControlEventTouchUpInside];

        _xingButton.enabled = true;
        [_xingButton addTarget:self action:@selector(openURLXing:event:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (_cellSelection == 0 || _cellSelection == 13 || _cellSelection == 16)
    {
        _cellIdentifier  = @"ContactsOverviewTableCell";
        _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
        if (_cell == nil)
        {
            [[NSBundle mainBundle] loadNibNamed:@"ContactsOverviewTableCell" owner:self options:nil];
            _cell = _contactsOverviewTableCell;
            self._contactsOverviewTableCell = nil;
        }
            UILabel         *_labelTitle      = (UILabel *) [_cell viewWithTag:1];
        
        if (_cellSelection == 0)
        {
            _labelTitle.text = @"Studiengangssekretariat";
        }
        if (_cellSelection == 13)
        {
            _labelTitle.text = @"Mastersekretariat";
        }
        if (_cellSelection == 16)
        {
            _labelTitle.text = @"Weiterbildungsekretariat";
        }
        
    }
    
    if(_cellSelection == 1 || _cellSelection == 2 || _cellSelection == 14 || _cellSelection == 17)
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

        if(_cellSelection == 1)
        {
            _labelTitle.text    = @"Standort Winterthur";
            _emailButtonTitle   = @"info-sg.engineering(at)zhaw.ch";
        }
        if(_cellSelection == 2)
        {
            _labelTitle.text    = @"Standort Zürich";
            _emailButtonTitle   = @"info-sg.zh.engineering(at)zhaw.ch";
        }
        if(_cellSelection == 14)
        {
            _labelTitle.text    = @"Masterstudiengang";
            _emailButtonTitle   = @"";
        }
        if(_cellSelection == 17)
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
    
    // _cellSelection: 3-12, 15, 18
    if((_cellSelection >= 3 && _cellSelection <= 12)
       || _cellSelection == 15 || _cellSelection == 18
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
        UIButton        *_numberButton    = (UIButton *)[_cell viewWithTag:3];
        NSString        *_numberButtonTitle;
            
        if(_cellSelection == 3)
        {
            _labelTitle.text = @"Aviatik";
            _labelPerson.text = @"Gianna Scherrer";
            _numberButtonTitle = @"Tel. +41 58 934 75 60";
        }
        if(_cellSelection == 4)
        {
            _labelTitle.text = @"Elektrotechnik";
            _labelPerson.text = @"Eliane Roth";
            _numberButtonTitle = @"Tel. +41 58 934 73 66";
        }
        if(_cellSelection == 5)
        {
            _labelTitle.text = @"Energie- und Umwelttechnik";
            _labelPerson.text = @"Jennifer Hohl";
            _numberButtonTitle = @"Tel. +41 58 934 75 63";
        }
        if(_cellSelection == 6)
        {
            _labelTitle.text = @"Informatik Standort Winterthur";
            _labelPerson.text = @"Jennifer Hohl";
            _numberButtonTitle = @"Tel. +41 58 934 75 63";
        }
        if(_cellSelection == 7)
        {
            _labelTitle.text = @"Informatik Standort Zürich";
            _labelPerson.text = @"Zita Fejér";
            _numberButtonTitle = @"Tel. +41 58 934 82 42";
        }
        if(_cellSelection == 8)
        {
            _labelTitle.text = @"Allgemeine Maschinentechnik";
            _labelPerson.text = @"Béatrice Schaffner";
            _numberButtonTitle = @"Tel. +41 58 934 74 14";
        }
        if(_cellSelection == 9)
        {
            _labelTitle.text = @"Material- und Verfahrenstechnik";
            _labelPerson.text = @"Béatrice Schaffner";
            _numberButtonTitle = @"Tel. +41 58 934 74 14";
        }
        if(_cellSelection == 10)
        {
            _labelTitle.text = @"Systemtechnik";
            _labelPerson.text = @"Eliane Roth";
            _numberButtonTitle = @"Tel. +41 58 934 73 66";
        }
        if(_cellSelection == 11)
        {
            _labelTitle.text = @"Verkehrssysteme";
            _labelPerson.text = @"Eliane Roth";
            _numberButtonTitle = @"Tel. +41 58 934 73 66";
        }
        if(_cellSelection == 12)
        {
            _labelTitle.text = @"Wirtschaftsingenieurwesen";
            _labelPerson.text = @"Gianna Scherrer";
            _numberButtonTitle = @"Tel. +41 58 934 75 60";
        }
        if(_cellSelection == 15)
        {
            _labelTitle.text = @"Master of Science in Engineering";
            _labelPerson.text = @"Jennifer Hohl";
            _numberButtonTitle = @"Tel. +41 58 934 75 63";
        }
        if(_cellSelection == 18)
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
    
    return _cell;
}


@end
