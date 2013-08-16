//
//  NewsDetailViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 16.08.13.
//
//

#import <UIKit/UIKit.h>
#import <NewsItemDto.h>
#import <DateFormation.h>

@interface NewsDetailViewController : UIViewController
{

    IBOutlet UILabel            *_titleLabel;
    IBOutlet UILabel            *_descriptionTitleLabel;
    IBOutlet UILabel            *_dateLabel;
    IBOutlet UITextView         *_descriptionTextView;
    IBOutlet UITextView         *_contentTextView;
    IBOutlet UIButton           *_linkButton;
    
    DateFormation               *_dateFormatter;
    
    NewsItemDto                 *_newsItem;
}

@property (nonatomic, retain) UILabel                               *_titleLabel;
@property (nonatomic, retain) UILabel                               *_descriptionTitleLabel;
@property (nonatomic, retain) UILabel                               *_dateLabel;
@property (nonatomic, retain) UITextView                            *_descriptionTextView;
@property (nonatomic, retain) UITextView                            *_contentTextView;
@property (nonatomic, retain) UIButton                              *_linkButton;

@property (strong, nonatomic) NewsItemDto                           *_newsItem;

@property (nonatomic, retain) DateFormation                         *_dateFormatter;

- (IBAction)moveBackToMenuOverview:(id)sender;


@end
