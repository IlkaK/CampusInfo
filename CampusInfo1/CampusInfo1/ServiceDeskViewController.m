/*
 ServiceDeskViewController.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ServiceDeskViewController.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of ServiceDeskViewController.xib, which displays the service desk contact information.  </li>
 *      <li> Shows the service desk information.  </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives delegate from ContactsOverVieController and passes it back, if back button is clicked. </li>
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

#import "ServiceDeskViewController.h"
#import "ColorSelection.h"
#import "UIConstantStrings.h"

@interface ServiceDeskViewController ()

@end

@implementation ServiceDeskViewController

@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;

@synthesize _currentEmail;
@synthesize _currentPhoneNumber;

@synthesize _serviceDeskTableCell;

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
* @function prefersStatusBarHidden
* Used to hide the iOS status bar with time and battery symbol.
*/
-(BOOL) prefersStatusBarHidden
{
    return YES;
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
    
    // general initialization
    _zhawColor = [[ColorSelection alloc]init];
    
    // title
    UIBarButtonItem *_backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStyleBordered target:self action:@selector(moveBackToContactsOverview:)];
    [_backButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:_zhawColor._zhawWhite} forState:UIControlStateNormal];
    [_titleNavigationItem setLeftBarButtonItem :_backButtonItem animated :true];
    [_titleNavigationItem setTitle:ServiceDeskVCTitle];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: _zhawColor._zhawWhite,
                                                           UITextAttributeFont: [UIFont fontWithName:NavigationBarFont size:NavigationBarTitleSize],
                                                           }];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:NavigationBarBackground] forBarMetrics:UIBarMetricsDefault];
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
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _serviceDeskTableCell = nil;
    [super viewDidUnload];
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
 When email address is clicked an alert is displayed and email is started.
 */
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
        if (_urlString != nil)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_urlString]];
        }
    }
}

/*!
 @function sendEmailToGivenAdress
 When email address is clicked an alert is displayed and email is started.
 */
-(void) sendEmailToGivenAdress:(id)sender event:(id)event
{
    NSString *_email = ServiceDeskVCRealEmail;
    NSString *_messageForCalling = [NSString stringWithFormat:@"%@ %@?"
                                    ,ContactsVCMessageSendEmail, _email];
    
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

/*!
 @function callGivenNumber
 When phone number is clicked an alert is displayed and number is dialed if wanted.
 */
-(void) callGivenNumber:(id)sender event:(id)event
{
    NSString        *_callWhom      = ServiceDeskVCTitle;
    NSString        *_callNumber    = ServiceDeskVCRealPhone;
    
    NSString *_messageForCalling = [NSString stringWithFormat:@"%@ %@ (%@)?"
                                    , _callWhom, ContactsVCMessageCall , _callNumber];
    
    UIAlertView *_acronymAlertView = [[UIAlertView alloc]
                                      initWithTitle:ServiceDeskVCTitle
                                      message:_messageForCalling
                                      delegate:self
                                      cancelButtonTitle:AlertViewOk
                                      otherButtonTitles:AlertViewCancel, nil];
    _currentEmail       = nil;
    _currentPhoneNumber = _callNumber;
    [_acronymAlertView show];
}



//---------- Handling of table  -----
/*!
 * @function numberOfSectionsInTableView
 * The function defines the number of sections in table.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/*!
 * @function numberOfRowsInSection
 * The function defines the number of rows in table.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}

/*!
 * @function cellForRowAtIndexPath
 * The function is for customizing the table view cells.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger        _cellRow       = indexPath.row;
    
    NSString         *_cellIdentifier;
    UITableViewCell  *_cell = nil;
    
    _cellIdentifier  = @"ServiceDeskTableCell";
    _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"ServiceDeskTableCell" owner:self options:nil];
        _cell = _serviceDeskTableCell;
        self._serviceDeskTableCell = nil;
    }
        
    UILabel         *_labelTitle     = (UILabel *)  [_cell viewWithTag:1];
    UIButton        *_actionButton   = (UIButton *) [_cell viewWithTag:2];
    NSString        *_buttonNumberTitle;
    
    [_labelTitle setTextColor:_zhawColor._zhawFontGrey];
    
    if (_cellRow == 0)
    {
        _labelTitle.text    = ServiceDeskVCDescriptionEmail;
        _buttonNumberTitle  = ServiceDeskVCDisplayEmail;
        [_actionButton addTarget:self action:@selector(sendEmailToGivenAdress  :event:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (_cellRow == 1)
    {
        _labelTitle.text    = ServiceDeskVCDescriptionPhone;
        _buttonNumberTitle  = ServiceDeskVCDisplayPhone;
        [_actionButton addTarget:self action:@selector(callGivenNumber  :event:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    _actionButton.enabled = true;
    NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:_buttonNumberTitle];
    [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
    [_titleString addAttribute:NSForegroundColorAttributeName value:_zhawColor._zhawFontGrey range:NSMakeRange(0, [_titleString length])];
    
    [_actionButton setAttributedTitle:_titleString forState:UIControlStateNormal];
    
    return _cell;
}


@end
