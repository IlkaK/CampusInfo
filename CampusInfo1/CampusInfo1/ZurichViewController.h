//
//  ZurichViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 19.08.13.
//
//

#import <UIKit/UIKit.h>

@interface ZurichViewController : UIViewController
{
    IBOutlet UIWebView          *_zurichWebView;
    
    IBOutlet UINavigationBar    *_titleNavigationBar;
    IBOutlet UINavigationItem   *_titleNavigationItem;
    IBOutlet UILabel            *_titleNavigationLabel;
    
}

@property (nonatomic, retain) IBOutlet UIWebView                      *_zurichWebView;

@property (nonatomic, retain) IBOutlet UINavigationBar                *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem               *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                        *_titleNavigationLabel;

@end
