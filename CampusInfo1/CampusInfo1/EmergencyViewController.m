//
//  EmergencyViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 02.08.13.
//
//

#import "EmergencyViewController.h"

@interface EmergencyViewController ()

@end

@implementation EmergencyViewController
@synthesize _backToSettingsNavigationItem;

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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView firstOtherButtonIndex])
    {
        NSLog(@"Launching the store");
        // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://1456987452"]];
    }
}


-(void) changeToCourseSchedule:(id)sender event:(id)event
{
    NSSet            *_touches              = [event    allTouches];
    UITouch          *_touch                = [_touches anyObject ];
    CGPoint           _currentTouchPosition = [_touch locationInView:self.view];
    
    NSLog(@"_currentTouchPosition x: %f y: %f", _currentTouchPosition.x , _currentTouchPosition.y);
    
    UIAlertView *_acronymAlertView = [[UIAlertView alloc]
                                      initWithTitle:@"Weitere Dienste"
                                      message:@"Anrufen?"
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:@"Cancel", nil];
    
    [_acronymAlertView show];
    
    NSLog(@"changeToCourseSchedule");
// [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://1456987452"]];
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
    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @1};
    
    int startLeft  = 20;
    int startRight = 130;

    int lengthLeft = 140;
    int lengthRight = 120;
    int lengthTitle = 250;
    
    double sizeTitle = 17.0;
    double sizeText = 14.0;
    double sizeComments = 12.0;
    
    int heightTitle = 20;
    int heightText = 18;
    int heightComments = 15;

    NSMutableParagraphStyle *mutParaStyle=[[NSMutableParagraphStyle alloc] init];
    [mutParaStyle setAlignment:NSTextAlignmentLeft];
    
    UILabel *_emergencyTitle = [[UILabel alloc] initWithFrame:CGRectMake(startLeft, 110, lengthTitle, heightTitle)];
    _emergencyTitle.font = [UIFont systemFontOfSize:sizeTitle];
    _emergencyTitle.numberOfLines = 0;
    _emergencyTitle.attributedText = [[NSAttributedString alloc] initWithString:@"1. Alarmieren > wenn nötig" attributes:underlineAttribute];
    [self.view addSubview:_emergencyTitle];
    
    UILabel *_police = [[UILabel alloc] initWithFrame:CGRectMake(startLeft, 140, lengthLeft, heightText)];
    _police.font = [UIFont systemFontOfSize:sizeText];
    _police.numberOfLines = 0;
    _police.text = [NSString stringWithFormat:@"Polizei"];
    [self.view addSubview:_police];
    
    UILabel *_fireservice = [[UILabel alloc] initWithFrame:CGRectMake(startLeft, 160, lengthLeft, heightText)];
    _fireservice.font = [UIFont systemFontOfSize:sizeText];
    _fireservice.numberOfLines = 0;
    _fireservice.text = [NSString stringWithFormat:@"Feuerwehr"];
    [self.view addSubview:_fireservice];
    
    UILabel *_sanitary = [[UILabel alloc] initWithFrame:CGRectMake(startLeft, 180, lengthLeft, heightText)];
    _sanitary.font = [UIFont systemFontOfSize:sizeText];
    _sanitary.numberOfLines = 0;
    _sanitary.text = [NSString stringWithFormat:@"Sanität"];
    [self.view addSubview:_sanitary];
    
    UILabel *_toxcentre = [[UILabel alloc] initWithFrame:CGRectMake(startLeft, 200, lengthLeft, heightText)];
    _toxcentre.font = [UIFont systemFontOfSize:sizeText];
    _toxcentre.numberOfLines = 0;
    _toxcentre.text = [NSString stringWithFormat:@"Tox-Zentrum"];
    [self.view addSubview:_toxcentre];

    UILabel *_rega = [[UILabel alloc] initWithFrame:CGRectMake(startLeft, 220, lengthLeft, heightText)];
    _rega.font = [UIFont systemFontOfSize:sizeText];
    _rega.numberOfLines = 0;
    _rega.text = [NSString stringWithFormat:@"REGA"];
    [self.view addSubview:_rega];
    
    UILabel *_policeNumber = [[UILabel alloc] initWithFrame:CGRectMake(startRight, 140, lengthRight, heightText)];
    _policeNumber.font = [UIFont systemFontOfSize:sizeText];
    _policeNumber.numberOfLines = 0;
    _policeNumber.text = [NSString stringWithFormat:@"(0)117"];
    [self.view addSubview:_policeNumber];
    
    UILabel *_fireserviceNumber = [[UILabel alloc] initWithFrame:CGRectMake(startRight, 160, lengthRight, heightText)];
    _fireserviceNumber.font = [UIFont systemFontOfSize:sizeText];
    _fireserviceNumber.numberOfLines = 0;
    _fireserviceNumber.text = [NSString stringWithFormat:@"(0)118"];
    [self.view addSubview:_fireserviceNumber];
    
    UILabel *_sanitaryNumber = [[UILabel alloc] initWithFrame:CGRectMake(startRight, 180, lengthRight, heightText)];
    _sanitaryNumber.font = [UIFont systemFontOfSize:sizeText];
    _sanitaryNumber.numberOfLines = 0;
    _sanitaryNumber.text = [NSString stringWithFormat:@"(0)144"];
    [self.view addSubview:_sanitaryNumber];

    UIButton  *_toxcentreNumber = [[UIButton alloc] initWithFrame:CGRectMake(startRight, 200, lengthRight, heightText)];
    NSMutableAttributedString *_toxcentreNumberString = [[NSMutableAttributedString alloc] initWithString:@"(0)145"];
    [_toxcentreNumberString addAttributes:[NSDictionary dictionaryWithObject:mutParaStyle
                                                                 forKey:NSParagraphStyleAttributeName]
                               range:NSMakeRange(0,[[_toxcentreNumberString string] length])];
    
    [_toxcentreNumberString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:sizeText]range:NSMakeRange(0, _toxcentreNumberString.length)];
    [_toxcentreNumber setAttributedTitle:_toxcentreNumberString forState:UIControlStateNormal];
    _toxcentreNumber.enabled = true;
    [_toxcentreNumber addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_toxcentreNumber];
    
    UIButton  *_regaNumber = [[UIButton alloc] initWithFrame:CGRectMake(startRight, 220, lengthRight, heightText)];
    NSMutableAttributedString *_regaNumberString = [[NSMutableAttributedString alloc] initWithString:@"(0)1414"];

    [_regaNumberString addAttributes:[NSDictionary dictionaryWithObject:mutParaStyle
                                                   forKey:NSParagraphStyleAttributeName]
                 range:NSMakeRange(0,[[_regaNumberString string] length])];
    
    [_regaNumberString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:sizeText]range:NSMakeRange(0, _regaNumberString.length)];
    [_regaNumber setAttributedTitle:_regaNumberString forState:UIControlStateNormal];
    _regaNumber.enabled = true;
    [_regaNumber addTarget:self action:@selector(changeToCourseSchedule  :event:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_regaNumber];
    
     
    UILabel *_informTitle = [[UILabel alloc] initWithFrame:CGRectMake(startLeft, 250, lengthTitle, heightTitle)];
    _informTitle.font = [UIFont systemFontOfSize:sizeTitle];
    _informTitle.numberOfLines = 0;
    _informTitle.attributedText = [[NSAttributedString alloc] initWithString:@"2. Informieren > immer" attributes:underlineAttribute];
    [self.view addSubview:_informTitle];
    
    UILabel *_zhawEmergency = [[UILabel alloc] initWithFrame:CGRectMake(startLeft, 280, lengthLeft, heightText)];
    _zhawEmergency.font = [UIFont systemFontOfSize:sizeText];
    _zhawEmergency.numberOfLines = 0;
    _zhawEmergency.text = [NSString stringWithFormat:@"ZHAW-Notfallnummer"];
    [self.view addSubview:_zhawEmergency];

    UILabel *_zhawEmergencyNumbers = [[UILabel alloc] initWithFrame:CGRectMake(startRight, 280, lengthRight, heightText)];
    _zhawEmergencyNumbers.font = [UIFont systemFontOfSize:sizeText];
    _zhawEmergencyNumbers.numberOfLines = 0;
    _zhawEmergencyNumbers.text = [NSString stringWithFormat:@"(0) 058 934 70 70"];
    [self.view addSubview:_zhawEmergencyNumbers];

    UILabel *_zhawEmergencyDaily = [[UILabel alloc] initWithFrame:CGRectMake(startLeft, 298, lengthLeft, heightComments)];
    _zhawEmergencyDaily.font = [UIFont systemFontOfSize:sizeComments];
    _zhawEmergencyDaily.numberOfLines = 0;
    _zhawEmergencyDaily.text = [NSString stringWithFormat:@"(365 Tage/24 Stunden)"];
    [self.view addSubview:_zhawEmergencyDaily];
    
    UILabel *_or = [[UILabel alloc] initWithFrame:CGRectMake(startLeft, 315, lengthLeft, heightText)];
    _or.font = [UIFont systemFontOfSize:sizeText];
    _or.numberOfLines = 0;
    _or.text = [NSString stringWithFormat:@"oder"];
    [self.view addSubview:_or];

    UILabel *_inHouse = [[UILabel alloc] initWithFrame:CGRectMake(startLeft, 335, lengthLeft, heightText)];
    _inHouse.font = [UIFont systemFontOfSize:sizeText];
    _inHouse.numberOfLines = 0;
    _inHouse.text = [NSString stringWithFormat:@"Hausdienst"];
    [self.view addSubview:_inHouse];
    
    UILabel *_inHouseNumber = [[UILabel alloc] initWithFrame:CGRectMake(startRight, 335, lengthRight, heightText)];
    _inHouseNumber.font = [UIFont systemFontOfSize:sizeText];
    _inHouseNumber.numberOfLines = 0;
    _inHouseNumber.text = [NSString stringWithFormat:@"Tel. je Standort"];
    [self.view addSubview:_inHouseNumber];

    UILabel *_inHouseDaily = [[UILabel alloc] initWithFrame:CGRectMake(startLeft, 353, lengthLeft, heightComments)];
    _inHouseDaily.font = [UIFont systemFontOfSize:sizeComments];
    _inHouseDaily.numberOfLines = 0;
    _inHouseDaily.text = [NSString stringWithFormat:@"(während Betriebszeit)"];
    [self.view addSubview:_inHouseDaily];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    _backToSettingsNavigationItem = nil;
    [super viewDidUnload];
}
@end
