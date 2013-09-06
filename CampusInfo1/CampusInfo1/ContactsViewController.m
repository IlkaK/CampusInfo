//
//  ContactsViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 02.08.13.
//
//

#import "ContactsViewController.h"
#import "ColorSelection.h"
#import "UIConstantStrings.h"

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
    
    // general initialization
    ColorSelection *_zhawColor = [[ColorSelection alloc]init];

    
    // title
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToContactsOverview:)];
    
    [backButtonItem setTintColor:_zhawColor._zhawOriginalBlue];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = ContactsVCTitle;
    _titleNavigationItem.title = @"";
    
    [_titleNavigationLabel setTextAlignment:UITextAlignmentCenter];
    
    [_titleNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];
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
        _email = ContactsVCRealEmailEngineering;
    }
    if(_cellSection == 0 && _cellRow == 11)
    {
        _email = ContactsVCRealEmailZurichEngineering;
    }
    
    if(_cellSection == 1 && _cellRow == 1)
    {
        _email = ContactsVCRealEmailMaster;
    }
    
    if(_cellSection == 2 && _cellRow == 3)
    {
        _email = ContactsVCRealEmailContinuedEducation;
    }
    
    NSString *_messageForCalling = [NSString stringWithFormat:@"%@ %@?"
                                    , ContactsVCMessageSendEmail
                                    , _email];
    
    UIAlertView *_acronymAlertView = [[UIAlertView alloc]
                                      initWithTitle:ContactsVCTitle
                                      message:_messageForCalling
                                      delegate:self
                                      cancelButtonTitle:AlertViewOk
                                      otherButtonTitles:AlertViewCancel, nil];
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
    
    // Aviatik
    if   (_cellSection == 0 && _cellRow == 0)
    {
        _callWhom = ContactsVCResponsibleAviatik;
        _callNumber = ContactsVCRealPhoneAviatik;
    }
    
    // electrical engineering
    if(_cellSection == 0 && _cellRow == 1)
    {
        _callWhom = ContactsVCResponsibleElectricalEngineering;
        _callNumber = ContactsVCRealPhoneElectricalEngineering;
    }
    
    // enviornment engineering
    if  (_cellSection == 0 && _cellRow == 2)
    {
        _callWhom = ContactsVCResponsibleEnvironmentEngineering;
        _callNumber = ContactsVCRealPhoneEnvironmentEngineering;
    }
    
    // computer science winterthur
    if(_cellSection == 0 && _cellRow == 3)
    {
        _callWhom = ContactsVCResponsibleComputerScienceWinterthur;
        _callNumber = ContactsVCRealPhoneComputerScienceWinterthur;
    }
    
    // computer science zurich
    if(_cellSection == 0 && _cellRow == 4)
    {
        _callWhom = ContactsVCResponsibleComputerScienceZurich;
        _callNumber = ContactsVCRealPhoneComputerScienceZurich;
    }
    
    // mechanical engineering
    if  (_cellSection == 0 && _cellRow == 5)
    {
        _callWhom = ContactsVCResponsibleMechanicalEngineering;
        _callNumber = ContactsVCRealPhoneMechanicalEngineering;
    }
    
    // chemical engineering
    if(_cellSection == 0 && _cellRow == 6)
    {
        _callWhom = ContactsVCResponsibleChemicalEngineering;
        _callNumber = ContactsVCRealPhoneChemicalEngineering;
    }
    
    // system engineering
    if(_cellSection == 0 && _cellRow == 7)
    {
        _callWhom = ContactsVCResponsibleSystemEngineering;
        _callNumber = ContactsVCRealPhoneSystemEngineering;
    }
    
    // traffice engineering
    if   (_cellSection == 0 && _cellRow == 8)
    {
        _callWhom = ContactsVCResponsibleTrafficEngineering;
        _callNumber = ContactsVCRealPhoneTrafficEngineering;
    }
    
    // Business Engineering
    if(_cellSection == 0 && _cellRow == 9)
    {
        _callWhom = ContactsVCResponsibleBusinessEngineering;
        _callNumber = ContactsVCRealPhoneBusinessEngineering;
    }
    
    // master
    if(_cellSection == 1 && _cellRow == 0)
    {
        _callWhom = ContactsVCResponsibleMaster;
        _callNumber = ContactsVCRealPhoneMaster;
    }
    
    // continued education
    if(_cellSection == 2 && _cellRow == 0)
    {
        _callWhom = ContactsVCResponsible0ContinuedEducation;
        _callNumber = ContactsVCRealPhone0ContinuedEducation;
    }
    if(_cellSection == 2 && _cellRow == 1)
    {
        _callWhom = ContactsVCResponsible1ContinuedEducation;
        _callNumber = ContactsVCRealPhone1ContinuedEducation;
    }
    if(_cellSection == 2 && _cellRow == 2)
    {
        _callWhom = ContactsVCResponsible2ContinuedEducation;
        _callNumber = ContactsVCRealPhone2ContinuedEducation;
    }
    
    NSString *_messageForCalling = [NSString stringWithFormat:@"%@ %@ (%@)?"
                                    , _callWhom, ContactsVCMessageCall, _callNumber];
    
    UIAlertView *_acronymAlertView = [[UIAlertView alloc]
                                      initWithTitle:ContactsVCTitle
                                      message:_messageForCalling
                                      delegate:self
                                      cancelButtonTitle:AlertViewOk
                                      otherButtonTitles:AlertViewCancel, nil];
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
            _sectionName = ContactsVCTitleBachelorSecretary;
            break;
        case 1:
            _sectionName = ContactsVCTitleMasterSecretary;
            break;
        default:
            _sectionName = ContactsVCTitleContinuedEducationSecretary;
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
            _numberRows = 4;
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
        || (_cellSelection == 2 && _cellRow <= 2)
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
            _labelTitle.text = ContactsVCTitleAviatik;
            _labelPerson.text = ContactsVCResponsibleAviatik;
            _numberButtonTitle = ContactsVCDisplayPhoneAviatik;
        }
        if(_cellSelection == 0 && _cellRow == 1)
        {
            _labelTitle.text = ContactsVCTitleElectricalEngineering;
            _labelPerson.text = ContactsVCResponsibleElectricalEngineering;
            _numberButtonTitle = ContactsVCDisplayPhoneElectricalEngineering;
        }
        if(_cellSelection == 0 && _cellRow == 2)
        {
            _labelTitle.text = ContactsVCTitleEnvironmentEngineering;
            _labelPerson.text = ContactsVCResponsibleEnvironmentEngineering;
            _numberButtonTitle = ContactsVCDisplayPhoneEnvironmentEngineering;
        }
        if(_cellSelection == 0 && _cellRow == 3)
        {
            _labelTitle.text = ContactsVCTitleComputerScienceWinterthur;
            _labelPerson.text = ContactsVCResponsibleComputerScienceWinterthur;
            _numberButtonTitle = ContactsVCDisplayPhoneComputerScienceWinterthur;
        }
        if(_cellSelection == 0 && _cellRow == 4)
        {
            _labelTitle.text = ContactsVCTitleComputerScienceZurich;
            _labelPerson.text = ContactsVCResponsibleComputerScienceZurich;
            _numberButtonTitle = ContactsVCDisplayPhoneComputerScienceZurich;
        }
        if(_cellSelection == 0 && _cellRow == 5)
        {
            _labelTitle.text = ContactsVCTitleMechanicalEngineering;
            _labelPerson.text = ContactsVCResponsibleMechanicalEngineering;
            _numberButtonTitle = ContactsVCDisplayPhoneMechanicalEngineering;
        }
        if(_cellSelection == 0 && _cellRow == 6)
        {
            _labelTitle.text = ContactsVCTitleChemicalEngineering;
            _labelPerson.text = ContactsVCResponsibleChemicalEngineering;
            _numberButtonTitle = ContactsVCDisplayPhoneChemicalEngineering;
        }
        if(_cellSelection == 0 && _cellRow == 7)
        {
            _labelTitle.text = ContactsVCTitleSystemEngineering;
            _labelPerson.text = ContactsVCResponsibleSystemEngineering;
            _numberButtonTitle = ContactsVCDisplayPhoneSystemEngineering;
        }
        if(_cellSelection == 0 && _cellRow == 8)
        {
            _labelTitle.text = ContactsVCTitleTrafficEngineering;
            _labelPerson.text = ContactsVCResponsibleTrafficEngineering;
            _numberButtonTitle = ContactsVCDisplayPhoneTrafficEngineering;
        }
        if(_cellSelection == 0 && _cellRow == 9)
        {
            _labelTitle.text = ContactsVCTitleBusinessEngineering;
            _labelPerson.text = ContactsVCResponsibleBusinessEngineering;
            _numberButtonTitle = ContactsVCDisplayPhoneBusinessEngineering;
        }
        
        if(_cellSelection == 1 && _cellRow == 0)
        {
            _labelTitle.text = ContactsVCTitleMaster;
            _labelPerson.text = ContactsVCResponsibleMaster;
            _numberButtonTitle = ContactsVCDisplayPhoneMaster;
        }
        if(_cellSelection == 2 && _cellRow == 0)
        {
            _labelTitle.text = ContactsVCTitleContinuedEducation;
            _labelPerson.text = ContactsVCResponsible0ContinuedEducation;
            _numberButtonTitle = ContactsVCDisplayPhone0ContinuedEducation;
        }
        if(_cellSelection == 2 && _cellRow == 1)
        {
            _labelTitle.text = ContactsVCTitleContinuedEducation;
            _labelPerson.text = ContactsVCResponsible1ContinuedEducation;
            _numberButtonTitle = ContactsVCDisplayPhone1ContinuedEducation;
        }
        if(_cellSelection == 2 && _cellRow == 2)
        {
            _labelTitle.text = ContactsVCTitleContinuedEducation;
            _labelPerson.text = ContactsVCResponsible2ContinuedEducation;
            _numberButtonTitle = ContactsVCDisplayPhone2ContinuedEducation;
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
        ||  (_cellSelection == 2 && _cellRow == 3)
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
            _labelTitle.text    = ContactsVCSectionTitleEngineering;
            _emailButtonTitle   = ContactsVCDisplayEmailEngineering;
        }
        
        if(_cellSelection == 0 && _cellRow == 11)
        {
            _labelTitle.text    = ContactsVCSectionTitleZurichEngineering;
            _emailButtonTitle   = ContactsVCDisplayEmailZurichEngineering;
        }
        
        if(_cellSelection == 1 && _cellRow == 1)
        {
            _labelTitle.text    = ContactsVCSectionTitleMaster;
            _emailButtonTitle   = ContactsVCDisplayEmailMaster;
        }
        
        if(_cellSelection == 2 && _cellRow == 3)
        {
            _labelTitle.text    = ContactsVCSectionTitleContinuedEducation;
            _emailButtonTitle   = ContactsVCDisplayEmailContinuedEducation;
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
