/*
 InformationViewController.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header InformationViewController.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of InformationViewController.xib, which displays information about the app.  </li>
 *      <li> Shows the service des contact information.  </li>
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

#import "InformationViewController.h"
#import "UIConstantStrings.h"
#import "URLConstantStrings.h"

@interface InformationViewController ()

@end

@implementation InformationViewController

@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;
@synthesize _titleLabel;
@synthesize _descriptionLabel;

@synthesize _currentEmail;
@synthesize _currentPhoneNumber;

@synthesize _informationResponsibleTableCell;
@synthesize _informationContactTableCell;

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
    [_titleNavigationItem setTitle:@""];
    
    [_titleLabel setTextColor:_zhawColor._zhawWhite];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarTitleSize]];
    [_titleLabel setText:NSLocalizedString(@"ContactsOverVCTitle", nil)];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:NavigationBarBackground] forBarMetrics:UIBarMetricsDefault];
    
    [_descriptionLabel setTextColor:_zhawColor._zhawWhite];
    [_descriptionLabel setTextAlignment:NSTextAlignmentCenter];
    [_descriptionLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarDescriptionSize]];
    [_descriptionLabel setText: NSLocalizedString(@"InformationVCTitle", nil)];
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
- (void)viewDidUnload
{
    _titleNavigationItem = nil;
    _titleNavigationBar = nil;
    _informationResponsibleTableCell = nil;
    _informationContactTableCell = nil;
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
 When email address is clicked an alert is displayed and email is started.
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView firstOtherButtonIndex])
    {
        NSString *_urlString = nil;
        if(_currentEmail != nil)
        {
            _urlString = [NSString stringWithFormat:@"mailto:%@", self._currentEmail];
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
    NSString *_email = InformationVCRealEmail;
    NSString *_messageForCalling = [NSString stringWithFormat:@"%@ %@?"
                                    ,NSLocalizedString(@"ContactsVCMessageSendEmail", nil), _email];
    
    UIAlertView *_acronymAlertView = [[UIAlertView alloc]
                                      initWithTitle:NSLocalizedString(@"InformationVCTitle", nil)
                                      message:_messageForCalling
                                      delegate:self
                                      cancelButtonTitle:NSLocalizedString(@"AlertViewOk", nil)
                                      otherButtonTitles:NSLocalizedString(@"AlertViewCancel", nil), nil];
    _currentEmail       = _email;
    [_acronymAlertView show];
}

/*!
 @function openEngineeringURL
 When URL is clicked, display content in browser.
 */
-(void) openEngineeringURL:(id)sender event:(id)event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLEngineeringApp]];
}


//---------- Handling of table  -----
/*!
 * @function numberOfSectionsInTableView
 * The function defines the number of sections in table.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *_sectionName;
    switch (section)
    {
        case 0:
            _sectionName = NSLocalizedString(@"InformationVCRealisation", nil);
            break;
        default:
            _sectionName = NSLocalizedString(@"InformationVCContact", nil);
            break;
    }
    return _sectionName;
}

/*!
 * @function numberOfRowsInSection
 * The function defines the number of rows in table.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

/*!
 * @function heightForRowAtIndexPath
 * The function defines the cells height of table.
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellSelection = indexPath.section;
    CGFloat           _cellHeight    = 130;
    if (_cellSelection == 0)
    {
        _cellHeight = 130;
    }
    if(_cellSelection == 1)
    {
        return 90;
    }
    return _cellHeight;
}


/*!
 * @function cellForRowAtIndexPath
 * The function is for customizing the table view cells.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger        _cellRow       = indexPath.row;
    NSUInteger        _cellSection   = indexPath.section;
    
    NSString         *_cellIdentifier;
    UITableViewCell  *_cell = nil;
    
    if (_cellRow == 0 && _cellSection == 0)
    {
        _cellIdentifier  = @"InformationResponsibleTableCell";
        _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
        if (_cell == nil)
        {
            [[NSBundle mainBundle] loadNibNamed:@"InformationResponsibleTableCell" owner:self options:nil];
            _cell = _informationResponsibleTableCell;
            self._informationResponsibleTableCell = nil;
        }
    
        UILabel         *_responsibleLabel  = (UILabel *)  [_cell viewWithTag:1];
        UILabel         *_schoolLabel       = (UILabel *)  [_cell viewWithTag:2];
        UILabel         *_initLabel         = (UILabel *)  [_cell viewWithTag:3];
        UILabel         *_teacherLabel      = (UILabel *)  [_cell viewWithTag:4];
        UILabel         *_streetLabel       = (UILabel *)  [_cell viewWithTag:5];
        UILabel         *_townLabel         = (UILabel *)  [_cell viewWithTag:6];

        [_responsibleLabel setTextColor:_zhawColor._zhawFontGrey];
        [_schoolLabel setTextColor:_zhawColor._zhawFontGrey];
        [_initLabel setTextColor:_zhawColor._zhawFontGrey];
        [_teacherLabel setTextColor:_zhawColor._zhawFontGrey];
        [_streetLabel setTextColor:_zhawColor._zhawFontGrey];
        [_townLabel setTextColor:_zhawColor._zhawFontGrey];
        
        [_responsibleLabel  setText:NSLocalizedString(@"InformationVCResponsible", nil)];
        [_schoolLabel       setText:NSLocalizedString(@"InformationVCSchoolofEngineering", nil)];
        [_initLabel         setText:NSLocalizedString(@"InformationVCInit", nil)];
        [_teacherLabel      setText:NSLocalizedString(@"InformationVCTeacher", nil)];
        [_streetLabel       setText:NSLocalizedString(@"InformationVCStreet", nil)];
        [_townLabel         setText:NSLocalizedString(@"InformationVCTown", nil)];
        
        
    }
    else // cellRow == 0 && _cellSection == 1
    {
        _cellIdentifier  = @"InformationContactTableCell";
        _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
        if (_cell == nil)
        {
            [[NSBundle mainBundle] loadNibNamed:@"InformationContactTableCell" owner:self options:nil];
            _cell = _informationContactTableCell;
            self._informationContactTableCell = nil;
        }
        UILabel         *_responseLabel     = (UILabel *)  [_cell viewWithTag:1];
        UIButton        *_emailButton       = (UIButton *) [_cell viewWithTag:2];
        UILabel         *_furtherInfoLabel  = (UILabel *)  [_cell viewWithTag:3];
        UIButton        *_homepageButton    = (UIButton *) [_cell viewWithTag:4];
        
        [_responseLabel setTextColor:_zhawColor._zhawFontGrey];
        [_furtherInfoLabel setTextColor:_zhawColor._zhawFontGrey];
        
        [_responseLabel     setText:NSLocalizedString(@"InformationVCResponse", nil)];
        [_furtherInfoLabel  setText:NSLocalizedString(@"InformationVCFurtherInformation", nil)];
        
        
        [_emailButton addTarget:self action:@selector(sendEmailToGivenAdress  :event:) forControlEvents:UIControlEventTouchUpInside];
        
        NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"InformationVCDisplayEmail", nil)];
        [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
        [_titleString addAttribute:NSForegroundColorAttributeName value:_zhawColor._zhawFontGrey range:NSMakeRange(0, [_titleString length])];
        
        [_emailButton setAttributedTitle:_titleString forState:UIControlStateNormal];
        
        [_homepageButton addTarget:self action:@selector(openEngineeringURL  :event:) forControlEvents:UIControlEventTouchUpInside];
        
        _titleString = [[NSMutableAttributedString alloc] initWithString:URLEngineeringApp];
        [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
        [_titleString addAttribute:NSForegroundColorAttributeName value:_zhawColor._zhawFontGrey range:NSMakeRange(0, [_titleString length])];
        [_homepageButton setAttributedTitle:_titleString forState:UIControlStateNormal];
        
    }
    return _cell;
}


@end
