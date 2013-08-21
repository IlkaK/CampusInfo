//
//  EmergencyViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 02.08.13.
//
//

#import <UIKit/UIKit.h>

@interface EmergencyViewController : UIViewController<UITableViewDelegate>
{

    IBOutlet UITableView        *_emergencyTable;
    IBOutlet UITableViewCell    *_emergencyDetailTableCell;
    IBOutlet UITableViewCell    *_emergencyOverviewTableCell;
    IBOutlet UITableViewCell    *_emergencyInformTableCell;
    
    NSString                    *_emergencyCallNumber;
    
    IBOutlet UINavigationBar    *_titleNavigationBar;
    IBOutlet UINavigationItem   *_titleNavigationItem;
    IBOutlet UILabel            *_titleNavigationLabel;
}

@property (nonatomic, retain) IBOutlet UITableView          *_emergencyTable;
@property (nonatomic, retain) IBOutlet UITableViewCell      *_emergencyDetailTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell      *_emergencyOverviewTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell      *_emergencyInformTableCell;

@property (nonatomic, retain) NSString                      *_emergencyCallNumber;

@property (nonatomic, retain) IBOutlet UINavigationBar      *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem     *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel              *_titleNavigationLabel;

@end
