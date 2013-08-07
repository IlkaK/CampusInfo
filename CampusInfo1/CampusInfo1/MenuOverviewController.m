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
    // Do any additional setup after loading the view from its nib.
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


// table and table cell handling

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellSelection = indexPath.section;
    NSString         *_cellIdentifier;
    UITableViewCell  *_cell = nil;
    
    UIColor *_lectureBackgroundColor = [UIColor colorWithRed:202.0/255.0 green:225.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    
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
        UIButton *_timeTableButton  = (UIButton *) [_cell viewWithTag:1];
        _timeTableButton.enabled = true;
        [_timeTableButton addTarget:self action:@selector(moveToTimeTable:event:) forControlEvents:UIControlEventTouchUpInside];
        
        _cell.contentView.backgroundColor = _lectureBackgroundColor;
        _cell.backgroundColor = _cell.contentView.backgroundColor;
    }
    else
    //if (_cellSelection > 0)
    {
        _cellIdentifier  = @"MenuMensaTableCell";
        _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
        if (_cell == nil)
        {
            [[NSBundle mainBundle] loadNibNamed:@"MenuMensaTableCell" owner:self options:nil];
            _cell = _menuMensaTableCell;
            self._menuMensaTableCell = nil;
        }
        UIButton *_mensaButton  = (UIButton *) [_cell viewWithTag:1];
        _mensaButton.enabled = true;
        [_mensaButton addTarget:self action:@selector(moveToMensa:event:) forControlEvents:UIControlEventTouchUpInside];

        _cell.contentView.backgroundColor = _lectureBackgroundColor;
        _cell.backgroundColor = _cell.contentView.backgroundColor;
    }
    
    NSLog(@"_cellSelection: %i", _cellSelection);
    return _cell;
}


@end
