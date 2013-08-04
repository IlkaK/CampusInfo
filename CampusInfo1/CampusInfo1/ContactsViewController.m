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
@synthesize _contactsOverviewTableCell;
@synthesize _contactsPhoneTableCell;
@synthesize _contactsTable;
@synthesize _contactsPlaceTableCell;

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
    [super viewDidUnload];
}


// table and table cell handling

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 19;
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
        return 40;
    }
    // email table cell
    if(_cellSelection == 1 || _cellSelection == 2 || _cellSelection == 14 || _cellSelection == 17)
    {
        return 57;
    }
    
    // _cellSelection: 3-12, 15, 18
    // phone table cell
    return 54;
}

-(void) changeToCourseSchedule:(id)sender event:(id)event
{
    NSSet            *_touches              = [event    allTouches];
    UITouch          *_touch                = [_touches anyObject ];
    CGPoint           _currentTouchPosition = [_touch locationInView:self._contactsTable];
    
    NSIndexPath      *_indexPath            = [self._contactsTable indexPathForRowAtPoint: _currentTouchPosition];
    
    NSLog(@"_indexPath %i", _indexPath.section);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellSelection = indexPath.section;
    NSString *_cellIdentifier;
    UITableViewCell *_cell = nil;

    
        
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
    else
    {
        
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
            [_emailButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
            
            NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:_emailButtonTitle];
            
            [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
            
            [_emailButton setAttributedTitle:_titleString forState:UIControlStateNormal];
        }
        else
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
            
            // _cellSelection: 3-12, 15, 18
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
            [_numberButton addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
            
            NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:_numberButtonTitle];
            
            [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
            
            [_numberButton setAttributedTitle:_titleString forState:UIControlStateNormal];
        }
        
    }
    
    return _cell;
}


@end
