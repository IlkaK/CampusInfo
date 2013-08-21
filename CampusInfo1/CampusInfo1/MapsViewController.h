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
    IBOutlet UINavigationBar            *_titleNavigationBar;
    IBOutlet UINavigationItem           *_titleNavigationItem;
    IBOutlet UILabel                    *_titleNavigationLabel;

    IBOutlet TechnikumViewController    *_technikumVC;
    IBOutlet ZurichViewController       *_zurichVC;
    IBOutlet UITableView                *_menuTableView;
}


@property (nonatomic, retain) IBOutlet UITableView                  *_menuTableView;

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleNavigationLabel;

@property (nonatomic, retain) IBOutlet TechnikumViewController      *_technikumVC;
@property (nonatomic, retain) IBOutlet ZurichViewController         *_zurichVC;


@end
