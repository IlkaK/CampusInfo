/*
 GradientButton.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header GradientButton.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Inherits from UIButton to create new outfit for buttons. </li>
 *  </ul>
 * </li>
 * <li> Receiving data:
 *   <ul>
 *      <li> The class does not receive any data. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> The class inherits from UIButton and returns itself when called. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <UIKit/UIKit.h>

@interface GradientButton : UIButton
{
    /*! @var normalGradientColors One of the two arrays which define the gradient that will be used when the button is in UIControlStateNormal (Colors) */
    NSArray  *normalGradientColors;     
    /*! @var normalGradientColors One of the two arrays which define the gradient that will be used when the button is in UIControlStateNormal (Locations)*/
    NSArray  *normalGradientLocations; 
    
    /*! @var highlightGradientColors One of the two arrays which define the gradient that will be used when the button is in UIControlStateHighlighted (Colors) */
    NSArray  *highlightGradientColors;    
    /*! @var highlightGradientColors One of the two arrays which define the gradient that will be used when the button is in UIControlStateHighlighted (Relative locations) */
    NSArray  *highlightGradientLocations; 

    /*! @var cornerRadius This defines the corner radius of the button */
    CGFloat         cornerRadius;

    /*! @var strokeWeight This defines the color of the stroke */
    CGFloat         strokeWeight;
    /*! @var strokeColor This defines the size of the stroke */
    UIColor         *strokeColor;
    
@private
    /*! @var normalGradient Holds normal gradient data */
    CGGradientRef   normalGradient;
    /*! @var highlightGradient Holds highlight gradient data */
    CGGradientRef   highlightGradient;
}

@property (nonatomic, retain) NSArray *normalGradientColors;
@property (nonatomic, retain) NSArray *normalGradientLocations;
@property (nonatomic, retain) NSArray *highlightGradientColors;
@property (nonatomic, retain) NSArray *highlightGradientLocations;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat strokeWeight;
@property (nonatomic, retain) UIColor *strokeColor;

/*!
 @function useAlertStyle
 Defines the alert style to be used on the button.
 */
- (void)useAlertStyle;
/*!
 @function useRedDeleteStyle
 Defines that red is used on the button.
 */
- (void)useRedDeleteStyle;
/*!
 @function useWhiteStyle
 Defines that white style is used on the button.
 */
- (void)useWhiteStyle;
/*!
 @function useBlackStyle
 Defines that black style is used on the button.
 */
- (void)useBlackStyle;
/*!
 @function useWhiteActionSheetStyle
 Defines that white is used on the button.
 */
- (void)useWhiteActionSheetStyle;
/*!
 @function useBlackActionSheetStyle
 Defines that black is used on the button.
 */
- (void)useBlackActionSheetStyle;
/*!
 @function useSimpleOrangeStyle
 Defines that orange is used on the button.
 */
- (void)useSimpleOrangeStyle;
/*!
 @function useGreenConfirmStyle
 Defines that green is used for confirmation.
 */
- (void)useGreenConfirmStyle;

@end