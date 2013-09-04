//
//  MenuOverviewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 07.08.13.
//
//

#import "MenuOverviewController.h"
#import "ColorSelection.h"
#import "UIConstantStrings.h"

@interface MenuOverviewController ()

@end

@implementation MenuOverviewController
@synthesize _menuTableView;
@synthesize _menuOverviewTableCell;

@synthesize _backgroundColor;

@synthesize _contactsVC;
@synthesize _settingsVC;
@synthesize _newsVC;
@synthesize _eventsVC;
@synthesize _publicTransportVC;
@synthesize _mapsVC;
@synthesize _socialMediaVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // set table controller
    if (_menuTableView == nil) {
		_menuTableView = [[UITableView alloc] init];
	}
    
    ColorSelection *_zhawColor = [[ColorSelection alloc]init];
    
    _backgroundColor = _zhawColor._zhawOriginalBlue;
    
    
    _menuTableView.separatorColor = _backgroundColor;
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _menuTableView.scrollEnabled = NO;
    
    [self.view setBackgroundColor:_backgroundColor];
    [_menuTableView setBackgroundColor:_backgroundColor];
    
    if (_contactsVC == nil)
    {
		_contactsVC = [[ContactsViewController alloc] init];
	}
    _contactsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if (_settingsVC == nil)
    {
		_settingsVC = [[SettingsViewController alloc] init];
	}
    _settingsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
  
    if (_newsVC == nil)
    {
		_newsVC = [[NewsViewController alloc] init];
	}
    _newsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if (_eventsVC == nil)
    {
		_eventsVC = [[EventsViewController alloc] init];
	}
    _eventsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if (_publicTransportVC == nil)
    {
		_publicTransportVC = [[PublicTransportViewController alloc] init];
	}
    _publicTransportVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    if (_mapsVC == nil)
    {
		_mapsVC = [[MapsViewController alloc] init];
	}
    _mapsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if (_socialMediaVC == nil)
    {
		_socialMediaVC = [[SocialMediaViewController alloc] init];
	}
    _socialMediaVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    _menuTableView = nil;    
    _contactsVC = nil;
    _settingsVC = nil;
    _newsVC = nil;
    _eventsVC = nil;
    _publicTransportVC = nil;    
    _mapsVC = nil;
    _socialMediaVC = nil;
    
    _menuOverviewTableCell = nil;
    [super viewDidUnload];
}

-(void) moveToTimeTable:(id)sender event:(id)event
{
    self.tabBarController.selectedIndex = 1;
    [self dismissModalViewControllerAnimated:YES];
}

-(void) moveToMensa:(id)sender event:(id)event
{
    self.tabBarController.selectedIndex = 2;
    [self dismissModalViewControllerAnimated:YES];
}

-(void) moveToOev:(id)sender event:(id)event
{
    //[self presentModalViewController:_settingsVC animated:YES];
    self.tabBarController.selectedIndex = 3;
    [self dismissModalViewControllerAnimated:YES];
}

-(void) moveToContacts:(id)sender event:(id)event
{
    self.tabBarController.selectedIndex = 4;
    [self dismissModalViewControllerAnimated:YES];
}

-(void) moveToNews:(id)sender event:(id)event
{
   [self presentModalViewController:_newsVC animated:YES];
}

-(void) moveToEvents:(id)sender event:(id)event
{
    [self presentModalViewController:_eventsVC animated:YES];
}

-(void) moveToSocialMedia:(id)sender event:(id)event
{
    [self presentModalViewController:_socialMediaVC animated:YES];
}

-(void) moveToSettings:(id)sender event:(id)event
{
    [self presentModalViewController:_settingsVC animated:YES];
}

-(void) moveToMaps:(id)sender event:(id)event
{
    [self presentModalViewController:_mapsVC animated:YES];
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
    return 92;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellSelection = indexPath.section;
    NSString         *_cellIdentifier;
    UITableViewCell  *_cell = nil;

    _cellIdentifier  = @"MenuOverviewTableCell";
    _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"MenuOverviewTableCell" owner:self options:nil];
        _cell = _menuOverviewTableCell;
        self._menuOverviewTableCell = nil;
    }
    
    
    if (_cellSelection == 0)
    {
        // time table
        UIButton *_timeTableIconButton  = (UIButton *) [_cell viewWithTag:1];
        _timeTableIconButton.enabled = true;
        [_timeTableIconButton addTarget:self action:@selector(moveToTimeTable:event:) forControlEvents:UIControlEventTouchUpInside];
        [_timeTableIconButton setImage:[UIImage imageNamed:@"timetable1_weiss.png"] forState:UIControlStateNormal];
        [_timeTableIconButton setImage:[UIImage imageNamed:@"timetable1_hellblau.png"] forState:UIControlStateSelected];
        [_timeTableIconButton setImage:[UIImage imageNamed:@"timetable1_hellblau.png"] forState:UIControlStateHighlighted];
        
        // mensa
        UIButton *_mensaIconButton  = (UIButton *) [_cell viewWithTag:2];
        _mensaIconButton.enabled = true;
        [_mensaIconButton addTarget:self action:@selector(moveToMensa:event:) forControlEvents:UIControlEventTouchUpInside];
        [_mensaIconButton setImage:[UIImage imageNamed:@"mensa1_weiss.png"] forState:UIControlStateNormal];
        [_mensaIconButton setImage:[UIImage imageNamed:@"mensa1_hellblau.png"] forState:UIControlStateSelected];
        [_mensaIconButton setImage:[UIImage imageNamed:@"mensa1_hellblau.png"] forState:UIControlStateHighlighted];
        
        //OeV
        UIButton *_oevIconButton  = (UIButton *) [_cell viewWithTag:3];
        _oevIconButton.enabled = true;
        [_oevIconButton addTarget:self action:@selector(moveToOev:event:) forControlEvents:UIControlEventTouchUpInside];
        [_oevIconButton setImage:[UIImage imageNamed:@"public_transportation1_weiss.png"] forState:UIControlStateNormal];
        [_oevIconButton setImage:[UIImage imageNamed:@"public_transportation1_hellblau.png"] forState:UIControlStateSelected];
        [_oevIconButton setImage:[UIImage imageNamed:@"public_transportation1_hellblau.png"] forState:UIControlStateHighlighted];
        
        _cell.contentView.backgroundColor = _backgroundColor;
        _cell.backgroundColor = _cell.contentView.backgroundColor;
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (_cellSelection == 1)
    {

        // contact
        UIButton *_contactsIconButton  = (UIButton *) [_cell viewWithTag:1];
        _contactsIconButton.enabled = true;
        [_contactsIconButton addTarget:self action:@selector(moveToContacts:event:) forControlEvents:UIControlEventTouchUpInside];
        [_contactsIconButton setImage:[UIImage imageNamed:@"contacts1_weiss.png"] forState:UIControlStateNormal];
        [_contactsIconButton setImage:[UIImage imageNamed:@"contacts1_hellblau.png"] forState:UIControlStateSelected];
        [_contactsIconButton setImage:[UIImage imageNamed:@"contacts1_hellblau.png"] forState:UIControlStateHighlighted];

        // card
        UIButton *_cardIconButton  = (UIButton *) [_cell viewWithTag:2];
        _cardIconButton.enabled = true;
        [_cardIconButton addTarget:self action:@selector(moveToMaps:event:) forControlEvents:UIControlEventTouchUpInside];
        [_cardIconButton setImage:[UIImage imageNamed:@"maps1_weiss.png"] forState:UIControlStateNormal];
        [_cardIconButton setImage:[UIImage imageNamed:@"maps1_hellblau.png"] forState:UIControlStateSelected];
        [_cardIconButton setImage:[UIImage imageNamed:@"maps1_hellblau.png"] forState:UIControlStateHighlighted];

        // social Media
        UIButton *_socialMediaIconButton  = (UIButton *) [_cell viewWithTag:3];
        _socialMediaIconButton.enabled = true;
        [_socialMediaIconButton addTarget:self action:@selector(moveToSocialMedia:event:) forControlEvents:UIControlEventTouchUpInside];
        [_socialMediaIconButton setImage:[UIImage imageNamed:@"social_media1_weiss.png"] forState:UIControlStateNormal];
        [_socialMediaIconButton setImage:[UIImage imageNamed:@"social_media1_hellblau.png"] forState:UIControlStateSelected];
        [_socialMediaIconButton setImage:[UIImage imageNamed:@"social_media1_hellblau.png"] forState:UIControlStateHighlighted];
        
        _cell.contentView.backgroundColor = _backgroundColor;
        _cell.backgroundColor = _cell.contentView.backgroundColor;
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (_cellSelection == 2)
    {
        // settings
        UIButton *_settingsIconButton  = (UIButton *) [_cell viewWithTag:1];
        _settingsIconButton.enabled = true;
        [_settingsIconButton addTarget:self action:@selector(moveToSettings:event:) forControlEvents:UIControlEventTouchUpInside];
        [_settingsIconButton setImage:[UIImage imageNamed:@"settings1_weiss.png"] forState:UIControlStateNormal];
        [_settingsIconButton setImage:[UIImage imageNamed:@"settings1_hellblau.png"] forState:UIControlStateSelected];
        [_settingsIconButton setImage:[UIImage imageNamed:@"settings1_hellblau.png"] forState:UIControlStateHighlighted];
        
        // news
        UIButton *_newsIconButton  = (UIButton *) [_cell viewWithTag:2];
        _newsIconButton.enabled = true;
        [_newsIconButton addTarget:self action:@selector(moveToNews:event:) forControlEvents:UIControlEventTouchUpInside];
        [_newsIconButton setImage:[UIImage imageNamed:@"news1_weiss.png"] forState:UIControlStateNormal];
        [_newsIconButton setImage:[UIImage imageNamed:@"news1_hellblau.png"] forState:UIControlStateSelected];
        [_newsIconButton setImage:[UIImage imageNamed:@"news1_hellblau.png"] forState:UIControlStateHighlighted];
        
        // events
        UIButton *_eventsIconButton  = (UIButton *) [_cell viewWithTag:3];
        _eventsIconButton.enabled = true;
        [_eventsIconButton addTarget:self action:@selector(moveToEvents:event:) forControlEvents:UIControlEventTouchUpInside];
        [_eventsIconButton setImage:[UIImage imageNamed:@"events1_weiss.png"] forState:UIControlStateNormal];
        [_eventsIconButton setImage:[UIImage imageNamed:@"events1_hellblau.png"] forState:UIControlStateSelected];
        [_eventsIconButton setImage:[UIImage imageNamed:@"events1_hellblau.png"] forState:UIControlStateHighlighted];
        
        _cell.contentView.backgroundColor = _backgroundColor;
        _cell.backgroundColor = _cell.contentView.backgroundColor;
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //NSLog(@"_cellSelection: %i", _cellSelection);
    return _cell;
}


@end
