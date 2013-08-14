//
//  PublicTransportViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 14.08.13.
//
//

#import "PublicTransportViewController.h"

@interface PublicTransportViewController ()

@end

@implementation PublicTransportViewController
@synthesize _titleLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *_backgroundColor = [UIColor colorWithRed:1.0/255.0 green:100.0/255.0 blue:167.0/255.0 alpha:1.0];
    
    [_titleLabel setBackgroundColor:_backgroundColor];
    [_titleLabel setTextColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    self.tabBarController.selectedIndex = 0;
}

- (void)viewDidUnload {
    _titleLabel = nil;
    [super viewDidUnload];
}
@end
