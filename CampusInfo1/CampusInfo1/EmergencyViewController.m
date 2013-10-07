/*
 EmergencyViewController.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header EmergencyViewController.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of EmergencyViewController.xib, which displays a table with all emergency contact information.  </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives delegate from ContactsOverViewController and passes it back, if back button is clicked. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> If email is clicked, email app is startet and email is started.  </li>
 *      <li> If phone number is clicked, a call is started.  </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "EmergencyViewController.h"
#import "ColorSelection.h"
#import "UIConstantStrings.h"

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

@synthesize _zhawColor;

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
 * @function viewDidLoad
 * The function is included, since class inherits from UIViewController.
 * Is called first time, the view is started for initialization.
 * Is only called once, after initialization, never again.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

    _zhawColor = [[ColorSelection alloc]init];
    _emergencyCallNumber = @"";
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToContactsOverview:)];
    
    [backButtonItem setTintColor:_zhawColor._zhawOriginalBlue];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = EmergencyVCTitle;
    _titleNavigationItem.title = @"";
    
    [_titleNavigationLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];
}

/*!
 @function moveBackToContactsOverview
 When back button is triggered, delegate is returned to ContactsOverViewController.
 @param sender
 */
- (void)moveBackToContactsOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

/*!
 @function clickedButtonAtIndex
 When phone number is clicked an alert is displayed and number is dialed if wanted.
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView firstOtherButtonIndex])
    {
        NSString *_urlString = [NSString stringWithFormat:@"tel://%@", self._emergencyCallNumber];
        //NSLog(@"calling %@", _urlString);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_urlString]];
    }
}

/*!
 @function callGivenNumber
 When phone number is clicked an alert is displayed and number is dialed if wanted.
 */
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
        _callWhom = EmergencyVCDisplayTextPolice;
        _callNumber = EmergencyVCRealPhonePolice;
    }
    if(_cellSelection == 0 && _cellRow == 1)
    {
        _callWhom = EmergencyVCDisplayTextFire;
        _callNumber = EmergencyVCRealPhoneFire;
    }
    if(_cellSelection == 0 && _cellRow == 2)
    {
        _callWhom = EmergencyVCDisplayTextSanitary;
        _callNumber = EmergencyVCRealPhoneSanitary;
    }
    if(_cellSelection == 0 && _cellRow == 3)
    {
        _callWhom = EmergencyVCDisplayTextToxCentre;
        _callNumber = EmergencyVCRealPhoneToxCentre;
    }
    if(_cellSelection == 0 && _cellRow == 4)
    {
        _callWhom = EmergencyVCDisplayTextRega;
        _callNumber = EmergencyVCRealPhoneRega;
    }
    if(_cellSelection == 1 && _cellRow == 0)
    {
        _callWhom = EmergencyVCDisplayTextZHAWEmergency;
        _callNumber = EmergencyVCRealPhoneZHAWEmergency;
    }
    
    NSString *_messageForCalling = [NSString stringWithFormat:@"%@ %@ (%@)?"
                                    , _callWhom, ContactsVCMessageCall, _callNumber];
    
    UIAlertView *_acronymAlertView = [[UIAlertView alloc]
                                      initWithTitle:EmergencyVCTitle
                                      message:_messageForCalling
                                      delegate:self
                                      cancelButtonTitle:AlertViewOk
                                      otherButtonTitles:AlertViewCancel, nil];
    _emergencyCallNumber = _callNumber;
    [_acronymAlertView show];
    // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://1456987452"]];
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
 @function viewDidUnload
 * The function is included, since class inherits from UIViewController.
 * It is called while the view is unloaded.
 */
- (void)viewDidUnload {
    _emergencyTable = nil;
    _emergencyDetailTableCell = nil;
    _emergencyInformTableCell = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    [super viewDidUnload];
}


//---------- Handling of table  -----
/*!
 * @function titleForHeaderInSection
 * The function defines the title of the sections.
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *_sectionName;
    switch (section)
    {
        case 0:
            _sectionName = EmergencyVCSectionTitleAlarm;
            break;
        default:
            _sectionName = EmergencyVCSectionTitleInform;
            break;
    }
    return _sectionName;
}

/*!
 * @function numberOfSectionsInTableView
 * The function defines the number of sections in table.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

/*!
 * @function numberOfRowsInSection
 * The function defines the number of rows in table.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger _numberRows;
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

/*!
 * @function heightForRowAtIndexPath
 * The function defines the cells height of table.
 */
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

/*!
 * @function cellForRowAtIndexPath
 * The function is for customizing the table view cells.
 */
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
        UILabel         *_labelDescription      = (UILabel *) [_cell viewWithTag:1];
        [_labelDescription setTextColor:_zhawColor._zhawFontGrey];        
        _labelDescription.text = EmergencyVCDisplayTitleZHAWEmergency;

        UILabel         *_labelAvailability     = (UILabel *) [_cell viewWithTag:2];
        [_labelAvailability setTextColor:_zhawColor._zhawFontGrey];
        _labelAvailability.text = EmergencyVCDisplayZHAWEmergencyAvailability;
        
        _buttonNumber          = (UIButton *) [_cell viewWithTag:3];
        _buttonNumberTitle     = EmergencyVCDisplayPhoneZHAWEmergency;
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
        [_labelDescription setTextColor:_zhawColor._zhawFontGrey];        
        _buttonNumber          = (UIButton *) [_cell viewWithTag:2];
        
        if (_cellRow == 0)
        {
            _labelDescription.text = EmergencyVCDisplayTitlePolice;
            _buttonNumberTitle = EmergencyVCDisplayPhonePolice;
        }
        if (_cellRow == 1)
        {
            _labelDescription.text = EmergencyVCDisplayTitleFire;
            _buttonNumberTitle = EmergencyVCDisplayPhoneFire;
        }
        if (_cellRow == 2)
        {
            _labelDescription.text = EmergencyVCDisplayTitleSanitary;
            _buttonNumberTitle = EmergencyVCDisplayPhoneSanitary;
        }
        if (_cellRow == 3)
        {
            _labelDescription.text = EmergencyVCDisplayTitleToxCentre;
            _buttonNumberTitle = EmergencyVCDisplayPhoneToxCentre;
        }
        if (_cellRow == 4)
        {
            _labelDescription.text = EmergencyVCDisplayTitleRega;
            _buttonNumberTitle = EmergencyVCDisplayPhoneRega;
        }
    }
    
    _buttonNumber.enabled = true;
    [_buttonNumber addTarget:self action:@selector(callGivenNumber  :event:) forControlEvents:UIControlEventTouchUpInside];
            
    NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:_buttonNumberTitle];
        
    [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
    [_titleString addAttribute:NSForegroundColorAttributeName value:_zhawColor._zhawFontGrey range:NSMakeRange(0, [_titleString length])];
    
    [_buttonNumber setAttributedTitle:_titleString forState:UIControlStateNormal];
    return _cell;
}




@end
