//
//  MenuOverviewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 07.08.13.
//
//

#import "MenuOverviewController.h"

@interface MenuOverviewController ()

@end

@implementation MenuOverviewController
@synthesize _menuTableView;
@synthesize _menuTimeTableCell;
@synthesize _menuMensaTableCell;
@synthesize _menuNewsTableCell;
@synthesize _contactsVC;
@synthesize _settingsVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // set table controller
    if (_menuTableView == nil) {
		_menuTableView = [[UITableView alloc] init];
	}
    
    UIColor *_lectureBackgroundColor = [UIColor colorWithRed:1.0/255.0 green:100.0/255.0 blue:167.0/255.0 alpha:1.0];
    
    _menuTableView.separatorColor = _lectureBackgroundColor;
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _menuTableView.scrollEnabled = NO;
    
    [self.view setBackgroundColor:_lectureBackgroundColor];
    
    if (_contactsVC == nil)
    {
		_contactsVC = [[ContactsViewController alloc] init];
	}
    //_contactsVC._chooseDateViewDelegate = self;
    _contactsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if (_settingsVC == nil)
    {
		_settingsVC = [[SettingsViewController alloc] init];
	}
    _settingsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    _menuTableView = nil;
    _menuTimeTableCell = nil;
    _menuMensaTableCell = nil;
    _menuNewsTableCell = nil;
    _contactsVC = nil;
    _settingsVC = nil;
    [super viewDidUnload];
}

-(void) moveToTimeTable:(id)sender event:(id)event
{
    self.tabBarController.selectedIndex = 1;
    [self dismissModalViewControllerAnimated:YES];
}

-(void) moveToMensa:(id)sender event:(id)event
{
    self.tabBarController.selectedIndex = 3;
    [self dismissModalViewControllerAnimated:YES];
}

-(void) moveToOev:(id)sender event:(id)event
{
    NSLog(@"move to ÖV");
}

-(void) moveToPerson:(id)sender event:(id)event
{
    NSLog(@"move to person");
}

-(void) moveToContacts:(id)sender event:(id)event
{
    [self presentModalViewController:_contactsVC animated:YES];
}

-(void) moveToQuestion:(id)sender event:(id)event
{
    NSLog(@"move to question");
}

-(void) moveToNews:(id)sender event:(id)event
{
    NSLog(@"move to news");
}

-(void) moveToEvents:(id)sender event:(id)event
{
    NSLog(@"move to events");
}

-(void) moveToSettings:(id)sender event:(id)event
{
    [self presentModalViewController:_settingsVC animated:YES];
    //self.tabBarController.selectedIndex = 4;
    //[self dismissModalViewControllerAnimated:YES];
}

// table and table cell handling

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellSelection = indexPath.section;
    NSString         *_cellIdentifier;
    UITableViewCell  *_cell = nil;
    
    UIColor *_lectureBackgroundColor = [UIColor colorWithRed:1.0/255.0 green:100.0/255.0 blue:167.0/255.0 alpha:1.0];
    // #0164A7 -> 1,100,167
    
    if (_cellSelection == 0)
    {
        _cellIdentifier  = @"MenuTimeTableCell";
        _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
        if (_cell == nil)
        {
            [[NSBundle mainBundle] loadNibNamed:@"MenuTimeTableCell" owner:self options:nil];
            _cell = _menuTimeTableCell;
            self._menuTimeTableCell = nil;
        }
        
        // time table
        UIButton *_timeTableIconButton  = (UIButton *) [_cell viewWithTag:1];
        _timeTableIconButton.enabled = true;
        [_timeTableIconButton addTarget:self action:@selector(moveToTimeTable:event:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *_timeTableTitleButton  = (UIButton *) [_cell viewWithTag:2];
        _timeTableTitleButton.enabled = true;
        [_timeTableTitleButton addTarget:self action:@selector(moveToTimeTable:event:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableAttributedString *_timeTableTitleString = [[NSMutableAttributedString alloc] initWithString:@"Stundenplan"];
        [_timeTableTitleString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [_timeTableTitleString length])];
        [_timeTableTitleButton setAttributedTitle:_timeTableTitleString forState:UIControlStateNormal];
        
        // mensa
        UIButton *_mensaIconButton  = (UIButton *) [_cell viewWithTag:3];
        _mensaIconButton.enabled = true;
        [_mensaIconButton addTarget:self action:@selector(moveToMensa:event:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *_mensaTitleButton  = (UIButton *) [_cell viewWithTag:4];
        _mensaTitleButton.enabled = true;
        [_mensaTitleButton addTarget:self action:@selector(moveToMensa:event:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableAttributedString *_mensaTitleString = [[NSMutableAttributedString alloc] initWithString:@"Mensa"];
        [_mensaTitleString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [_mensaTitleString length])];
        [_mensaTitleButton setAttributedTitle:_mensaTitleString forState:UIControlStateNormal];
        
        //OeV
        UIButton *_oevIconButton  = (UIButton *) [_cell viewWithTag:5];
        _oevIconButton.enabled = true;
        [_oevIconButton addTarget:self action:@selector(moveToOev:event:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *_oevTitleButton  = (UIButton *) [_cell viewWithTag:6];
        _oevTitleButton.enabled = true;
        [_oevTitleButton addTarget:self action:@selector(moveToOev:event:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableAttributedString *_oevTitleString = [[NSMutableAttributedString alloc] initWithString:@"ÖV"];
        [_oevTitleString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [_oevTitleString length])];
        [_oevTitleButton setAttributedTitle:_oevTitleString forState:UIControlStateNormal];
        
        _cell.contentView.backgroundColor = _lectureBackgroundColor;
        _cell.backgroundColor = _cell.contentView.backgroundColor;
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (_cellSelection == 1)
    {
        _cellIdentifier  = @"MenuMensaTableCell";
        _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
        if (_cell == nil)
        {
            [[NSBundle mainBundle] loadNibNamed:@"MenuMensaTableCell" owner:self options:nil];
            _cell = _menuMensaTableCell;
            self._menuMensaTableCell = nil;
        }
        
        // person
        UIButton *_personIconButton  = (UIButton *) [_cell viewWithTag:1];
        _personIconButton.enabled = true;
        [_personIconButton addTarget:self action:@selector(moveToPerson:event:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *_personTitleButton  = (UIButton *) [_cell viewWithTag:2];
        _personTitleButton.enabled = true;
        [_personTitleButton addTarget:self action:@selector(moveToPerson:event:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableAttributedString *_personTitleString = [[NSMutableAttributedString alloc] initWithString:@"Person"];
        [_personTitleString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [_personTitleString length])];
        [_personTitleButton setAttributedTitle:_personTitleString forState:UIControlStateNormal];
        
        // contact
        UIButton *_contactsIconButton  = (UIButton *) [_cell viewWithTag:3];
        _contactsIconButton.enabled = true;
        [_contactsIconButton addTarget:self action:@selector(moveToContacts:event:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *_contactsTitleButton  = (UIButton *) [_cell viewWithTag:4];
        _contactsTitleButton.enabled = true;
        [_contactsTitleButton addTarget:self action:@selector(moveToContacts:event:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableAttributedString *_contactsTitleString = [[NSMutableAttributedString alloc] initWithString:@"Kontakte"];
        [_contactsTitleString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [_contactsTitleString length])];
        [_contactsTitleButton setAttributedTitle:_contactsTitleString forState:UIControlStateNormal];

        //???
        UIButton *_questionIconButton  = (UIButton *) [_cell viewWithTag:5];
        _questionIconButton.enabled = true;
        [_questionIconButton addTarget:self action:@selector(moveToQuestion:event:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *_questionTitleButton  = (UIButton *) [_cell viewWithTag:6];
        _questionTitleButton.enabled = true;
        [_questionTitleButton addTarget:self action:@selector(moveToQuestion:event:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableAttributedString *_questionTitleString = [[NSMutableAttributedString alloc] initWithString:@"???"];
        [_questionTitleString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [_questionTitleString length])];
        [_questionTitleButton setAttributedTitle:_questionTitleString forState:UIControlStateNormal];
        
        _cell.contentView.backgroundColor = _lectureBackgroundColor;
        _cell.backgroundColor = _cell.contentView.backgroundColor;
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (_cellSelection == 2)
    {
        _cellIdentifier  = @"MenuNewsTableCell";
        _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
        if (_cell == nil)
        {
            [[NSBundle mainBundle] loadNibNamed:@"MenuNewsTableCell" owner:self options:nil];
            _cell = _menuNewsTableCell;
            self._menuNewsTableCell = nil;
        }
        
        // news
        UIButton *_newsIconButton  = (UIButton *) [_cell viewWithTag:1];
        _newsIconButton.enabled = true;
        [_newsIconButton addTarget:self action:@selector(moveToNews:event:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *_newsTitleButton  = (UIButton *) [_cell viewWithTag:2];
        _newsTitleButton.enabled = true;
        [_newsTitleButton addTarget:self action:@selector(moveToNews:event:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableAttributedString *_newsTitleString = [[NSMutableAttributedString alloc] initWithString:@"News"];
        [_newsTitleString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [_newsTitleString length])];
        [_newsTitleButton setAttributedTitle:_newsTitleString forState:UIControlStateNormal];
        
        // events
        UIButton *_eventsIconButton  = (UIButton *) [_cell viewWithTag:3];
        _eventsIconButton.enabled = true;
        [_eventsIconButton addTarget:self action:@selector(moveToEvents:event:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *_eventsTitleButton  = (UIButton *) [_cell viewWithTag:4];
        _eventsTitleButton.enabled = true;
        [_eventsTitleButton addTarget:self action:@selector(moveToEvents:event:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableAttributedString *_eventsTitleString = [[NSMutableAttributedString alloc] initWithString:@"Events"];
        [_eventsTitleString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [_eventsTitleString length])];
        [_eventsTitleButton setAttributedTitle:_eventsTitleString forState:UIControlStateNormal];
        
        // settings
        UIButton *_settingsIconButton  = (UIButton *) [_cell viewWithTag:5];
        _settingsIconButton.enabled = true;
        [_settingsIconButton addTarget:self action:@selector(moveToSettings:event:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *_settingsTitleButton  = (UIButton *) [_cell viewWithTag:6];
        _settingsTitleButton.enabled = true;
        [_settingsTitleButton addTarget:self action:@selector(moveToSettings:event:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableAttributedString *_settingsTitleString = [[NSMutableAttributedString alloc] initWithString:@"Einstellungen"];
        [_settingsTitleString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [_settingsTitleString length])];
        [_settingsTitleButton setAttributedTitle:_settingsTitleString forState:UIControlStateNormal];
        
        _cell.contentView.backgroundColor = _lectureBackgroundColor;
        _cell.backgroundColor = _cell.contentView.backgroundColor;
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //NSLog(@"_cellSelection: %i", _cellSelection);
    return _cell;
}


@end
