//
//  PButton.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 21.08.13.
//
//

#import <UIKit/UIKit.h>
@interface PButton : UIButton
@property (nonatomic, strong) UIBezierPath *buttonBorderPath;
@property (nonatomic, strong) NSMutableArray *normalEffects;
@property (nonatomic, strong) NSMutableArray *highlightEffects;
@property (nonatomic, strong) NSMutableArray *selectedEffects;
@end
