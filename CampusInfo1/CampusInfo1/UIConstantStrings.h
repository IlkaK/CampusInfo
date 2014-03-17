/*
 UIConstantStrings.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header UIConstantStrings.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Stores all constants which are used in the application. </li>
 *      <li> There is no logic implemented, the class only holds the constants. </li>
 *  </ul>
 * </li> *
 * </ul>
 */

#import <Foundation/Foundation.h>

@interface UIConstantStrings : NSObject

// arrows for navigation bars and back buttons
extern NSString * const LeftArrowSymbol;
extern NSString * const RightArrowSymbol;

// background for navigation bars
extern NSString * const NavigationBarBackground;
// title for navigation bars
extern NSString * const NavigationBarFont;
extern NSString * const BoldFont;

extern float const NavigationBarTitleSize;
extern float const NavigationBarDescriptionSize;
extern NSString * const SegmentedControlBackground;
extern NSString * const DateButtonBackground;
extern NSString * const NoConnectionButtonBackground;


extern NSString * const TimeTableAcronym;

// time table error
extern  NSString * const TimeTableCourseError;
extern NSString * const TimeTableTeacherError;
extern NSString * const TimeTableRoomError;
extern NSString * const TimeTableClassError;
extern NSString * const TimeTableStudentError;


// time table types
extern NSString * const TimeTableTypeStudentEnglish ;
extern NSString * const TimeTableTypeStudentEnglishPlural;
extern NSString * const TimeTableTypeLecturerEnglishPlural;
extern NSString * const TimeTableTypeLecturerEnglish;
extern NSString * const TimeTableTypeCourseEnglishPlural;
extern NSString * const TimeTableTypeCourseEnglish;
extern NSString * const TimeTableTypeRoomEnglish;
extern NSString * const TimeTableTypeRoomEnglishPlural  ;
extern NSString * const TimeTableTypeClassEnglishPlural;
extern NSString * const TimeTableTypeClassEnglish;


// settings
extern NSString * const SettingsVCSearchType;
extern NSString * const SettingsVCSearchText;


// strings for mensa
extern NSString * const MensaTypeCafeteria;
extern NSString * const MensaTypeCanteen;


// strings for contactc

extern NSString * const ContactsVCRealEmailEngineering                ;
extern NSString * const ContactsVCDisplayEmailEngineering             ;
extern NSString * const ContactsVCRealEmailZurichEngineering          ;
extern NSString * const ContactsVCDisplayEmailZurichEngineering       ;

extern NSString * const ContactsVCDisplayPhoneAviatik                 ;
extern NSString * const ContactsVCRealPhoneAviatik                    ;
extern NSString * const ContactsVCResponsibleAviatik                  ;

extern NSString * const ContactsVCDisplayPhoneElectricalEngineering   ;
extern NSString * const ContactsVCRealPhoneElectricalEngineering      ;
extern NSString * const ContactsVCResponsibleElectricalEngineering    ;

extern NSString * const ContactsVCDisplayPhoneEnvironmentEngineering  ;
extern NSString * const ContactsVCRealPhoneEnvironmentEngineering     ;
extern NSString * const ContactsVCResponsibleEnvironmentEngineering   ;

extern NSString * const ContactsVCDisplayPhoneComputerScienceWinterthur ;
extern NSString * const ContactsVCRealPhoneComputerScienceWinterthur    ;
extern NSString * const ContactsVCResponsibleComputerScienceWinterthur  ;

extern NSString * const ContactsVCDisplayPhoneComputerScienceZurich     ;
extern NSString * const ContactsVCRealPhoneComputerScienceZurich        ;
extern NSString * const ContactsVCResponsibleComputerScienceZurich      ;

extern NSString * const ContactsVCDisplayPhoneMechanicalEngineering     ;
extern NSString * const ContactsVCRealPhoneMechanicalEngineering        ;
extern NSString * const ContactsVCResponsibleMechanicalEngineering      ;

extern NSString * const ContactsVCDisplayPhoneChemicalEngineering       ;
extern NSString * const ContactsVCRealPhoneChemicalEngineering          ;
extern NSString * const ContactsVCResponsibleChemicalEngineering        ;

extern NSString * const ContactsVCDisplayPhoneSystemEngineering         ;
extern NSString * const ContactsVCRealPhoneSystemEngineering            ;
extern NSString * const ContactsVCResponsibleSystemEngineering          ;

extern NSString * const ContactsVCDisplayPhoneTrafficEngineering        ;
extern NSString * const ContactsVCRealPhoneTrafficEngineering           ;
extern NSString * const ContactsVCResponsibleTrafficEngineering         ;

extern NSString * const ContactsVCDisplayPhoneBusinessEngineering       ;
extern NSString * const ContactsVCRealPhoneBusinessEngineering          ;
extern NSString * const ContactsVCResponsibleBusinessEngineering        ;

extern NSString * const ContactsVCDisplayPhoneMaster                    ;
extern NSString * const ContactsVCRealPhoneMaster                       ;
extern NSString * const ContactsVCResponsibleMaster                     ;
extern NSString * const ContactsVCRealEmailMaster                       ;
extern NSString * const ContactsVCDisplayEmailMaster                    ;

extern NSString * const ContactsVCRealEmailContinuedEducation           ;
extern NSString * const ContactsVCDisplayEmailContinuedEducation        ;

extern NSString * const ContactsVCDisplayPhone0ContinuedEducation        ;
extern NSString * const ContactsVCRealPhone0ContinuedEducation           ;
extern NSString * const ContactsVCResponsible0ContinuedEducation         ;

extern NSString * const ContactsVCDisplayPhone1ContinuedEducation        ;
extern NSString * const ContactsVCRealPhone1ContinuedEducation           ;
extern NSString * const ContactsVCResponsible1ContinuedEducation         ;

extern NSString * const ContactsVCDisplayPhone2ContinuedEducation        ;
extern NSString * const ContactsVCRealPhone2ContinuedEducation           ;
extern NSString * const ContactsVCResponsible2ContinuedEducation         ;


// emergency contacts
extern NSString * const EmergencyVCDisplayPhonePolice        ;
extern NSString * const EmergencyVCRealPhonePolice           ;

extern NSString * const EmergencyVCDisplayPhoneFire          ;
extern NSString * const EmergencyVCRealPhoneFire             ;

extern NSString * const EmergencyVCDisplayPhoneSanitary      ;
extern NSString * const EmergencyVCRealPhoneSanitary         ;

extern NSString * const EmergencyVCDisplayPhoneToxCentre     ;
extern NSString * const EmergencyVCRealPhoneToxCentre        ;

extern NSString * const EmergencyVCDisplayPhoneRega          ;
extern NSString * const EmergencyVCRealPhoneRega             ;

extern NSString * const EmergencyVCDisplayPhoneZHAWEmergency ;
extern NSString * const EmergencyVCRealPhoneZHAWEmergency    ;

extern NSString * const ServiceDeskVCRealPhone       ;
extern NSString * const ServiceDeskVCDisplayPhone    ;
extern NSString * const ServiceDeskVCRealEmail       ;
extern NSString * const ServiceDeskVCDisplayEmail    ;

extern NSString * const InformationVCDisplayEmail;
extern NSString * const InformationVCRealEmail;



extern NSString * const PublicTransportVCFromEnglish;
extern NSString * const PublicTransportVCToEnglish;


// news and events
extern NSString * const NewsWebViewHtml;
extern NSString * const NewsWebViewFont;



// language translation
extern NSString * const MondayEnglish ;
extern NSString * const TuesdayEnglish;
extern NSString * const WednesdayEnglish ;
extern NSString * const ThursdayEnglish ;
extern NSString * const FridayEnglish ;
extern NSString * const SaturdayEnglish ;
extern NSString * const SundayEnglish ;

// menu overview png
extern NSString * const AppIconTimeTable;
extern NSString * const AppIconTimeTableFeedback;
extern NSString * const AppIconMensa;
extern NSString * const AppIconMensaFeedback;
extern NSString * const AppIconPublicTransport;
extern NSString * const AppIconPublicTransportFeedback;
extern NSString * const AppIconContacts;
extern NSString * const AppIconContactsFeedback;
extern NSString * const AppIconMaps;
extern NSString * const AppIconMapsFeedback;
extern NSString * const AppIconSocialMedia;
extern NSString * const AppIconSocialMediaFeedback;
extern NSString * const AppIconSettings;
extern NSString * const AppIconSettingsFeedback;
extern NSString * const AppIconNews;
extern NSString * const AppIconNewsFeedback;
extern NSString * const AppIconEvents;
extern NSString * const AppIconEventsFeedback;

@end