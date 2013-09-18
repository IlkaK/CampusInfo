//
//  ServiceDeskViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 26.08.13.
//
//

#import "ServiceDeskViewController.h"
#import "ColorSelection.h"
#import "UIConstantStrings.h"

@interface ServiceDeskViewController ()

@end

@implementation ServiceDeskViewController

@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;
@synthesize _titleNavigationLabel;

@synthesize _currentEmail;
@synthesize _currentPhoneNumber;

@synthesize _serviceDeskTableCell;

@synthesize _zhawColors;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // general initialization
    _zhawColors = [[ColorSelection alloc]init];
    
    // title
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToContactsOverview:)];
    
    [backButtonItem setTintColor:_zhawColors._zhawOriginalBlue];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColors._zhawWhite];
    _titleNavigationLabel.text = ServiceDeskVCTitle;
    _titleNavigationItem.title = @"";
    
    [_titleNavigationLabel setTextAlignment:UITextAlignmentCenter];
    [_titleNavigationBar setTintColor:_zhawColors._zhawDarkerBlue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    _serviceDeskTableCell = nil;
    [super viewDidUnload];
}

- (void)moveBackToContactsOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
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
        if (_urlString != nil)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_urlString]];
        }
    }
}

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


-(void) callGivenNumber:(id)sender event:(id)event
{
    NSString        *_callWhom      = ServiceDeskVCTitle;
    NSString        *_callNumber    = ServiceDeskVCRealPhone;
    
    NSString *_messageForCalling = [NSString stringWithFormat:@"%@ %@ (%@)?"
                                    , _callWhom, ContactsVCMessageCall , _callNumber];
    
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





//---------- Handling of menu table -----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}



// Customize the appearance of table view cells.
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
    
    [_labelTitle setTextColor:_zhawColors._zhawFontGrey];
    
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
    [_titleString addAttribute:NSForegroundColorAttributeName value:_zhawColors._zhawFontGrey range:NSMakeRange(0, [_titleString length])];
    
    [_actionButton setAttributedTitle:_titleString forState:UIControlStateNormal];
    
    return _cell;
}


@end
