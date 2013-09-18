//
//  NewsDetailViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 16.08.13.
//
//

#import <UIKit/UIKit.h>
#import "NewsItemDto.h"
#import "DateFormation.h"

@interface NewsDetailViewController : UIViewController
{

    IBOutlet UINavigationBar    *_titleNavigationBar;
    IBOutlet UINavigationItem   *_titleNavigationItem;
    IBOutlet UILabel            *_titleNavigationLabel;
    
    
    IBOutlet UINavigationBar    *_descriptionNavigationBar;
    IBOutlet UINavigationItem   *_descriptionNavigationItem;
    IBOutlet UILabel            *_descriptionTitleLabel;    
    
    IBOutlet UILabel            *_dateLabel;
    IBOutlet UIButton           *_linkButton;
    IBOutlet UIWebView          *_contentWebView;
    
    DateFormation               *_dateFormatter;
    NewsItemDto                 *_newsItem;
}

@property (nonatomic, retain) UINavigationBar                       *_titleNavigationBar;
@property (nonatomic, retain) UINavigationItem                      *_titleNavigationItem;
@property (nonatomic, retain) UILabel                               *_titleNavigationLabel;

@property (nonatomic, retain) UINavigationBar                       *_descriptionNavigationBar;
@property (nonatomic, retain) UINavigationItem                      *_descriptionNavigationItem;
@property (nonatomic, retain) UILabel                               *_descriptionTitleLabel;

@property (nonatomic, retain) UILabel                               *_dateLabel;
@property (nonatomic, retain) UIButton                              *_linkButton;
@property (nonatomic, retain) UIWebView                             *_contentWebView;

@property (strong, nonatomic) NewsItemDto                           *_newsItem;
@property (nonatomic, retain) DateFormation                         *_dateFormatter;

@end
