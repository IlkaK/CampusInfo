//
//  MapsViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 19.08.13.
//
//

#import <UIKit/UIKit.h>
#import <TechnikumViewController.h>
#import <ZurichViewController.h>

@class TechnikumViewController;
@class ZurichViewController;

@interface MapsViewController : UIViewController<UITableViewDelegate>
{

    IBOutlet UILabel                    *_titleLabel;
    
    IBOutlet TechnikumViewController    *_technikumVC;
    IBOutlet ZurichViewController       *_zurichVC;
    IBOutlet UITableView                *_menuTableView;
}

@property (nonatomic, retain) IBOutlet UILabel                      *_titleLabel;

@property (nonatomic, retain) IBOutlet UITableView                  *_menuTableView;

@property (nonatomic, retain) IBOutlet TechnikumViewController      *_technikumVC;
@property (nonatomic, retain) IBOutlet ZurichViewController         *_zurichVC;


- (IBAction)moveBackToMenuOverview:(id)sender;

@end
