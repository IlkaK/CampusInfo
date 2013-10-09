/*
 Autocomplete.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header Autocomplete.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Handling autocomplete functionality, which means the candidate array is set via function AddCandidate and suggestions for autocompletion are got via GetSuggestions. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> The class receives an initial array for the candidates (initWithArray). Other candidates can be added via AddCandidate. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> With method GetSuggestions an array is given back to caller which includes all possible matches (suggestions) for given string. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import <Foundation/Foundation.h>

@interface Autocomplete : NSObject
{
    /*! @var _candidates Holds an array of candidates as possible suggestions */
	NSMutableArray *_candidates;
}

@property (nonatomic, retain) NSMutableArray *_candidates;

/*!
 @function initWithArray
 Initialization of the class and especially the candidates array.
 @param initialArray
 */
- (Autocomplete *)initWithArray:(NSArray *)initialArray;

/*!
 @function GetSuggestions
 Get suggestions for given input string out of stored array.
 @param root
 */
- (NSMutableArray *)GetSuggestions:(NSString *)root;

/*!
 @function AddCandidate
 Add new candidate to stored array.
 @param candidate
 */
- (void)AddCandidate:(NSString *)candidate;


@end
