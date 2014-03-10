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
extern float const NavigationBarTitleSize;
extern float const NavigationBarDescriptionSize;
extern NSString * const SegmentedControlBackground;
extern NSString * const DateButtonBackground;
extern NSString * const NoConnectionButtonBackground;


// strings for maps/standorte
extern NSString * const MapsVCTitle    ;
extern NSString * const MapsVCTechnikum;
extern NSString * const MapsVCZurich   ;
extern NSString * const MapsVCToessfeld;

extern NSString * const ZurichVCTitle     ;
extern NSString * const ZurichVCFileName  ;
extern NSString * const ZurichVCFileFormat;

extern NSString * const TechnikumVCTitle     ;
extern NSString * const TechnikumVCFileName  ;
extern NSString * const TechnikumVCFileFormat;

extern NSString * const ToessfeldVCTitle     ;
extern NSString * const ToessfeldVCFileName  ;
extern NSString * const ToessfeldVCFileFormat;

// strings for settings
extern NSString * const TimeTableTypeStudent     ;
extern NSString * const TimeTableTypeDozent      ;
extern NSString * const TimeTableTypeDozentPlural;
extern NSString * const TimeTableTypeKurs        ;
extern NSString * const TimeTableTypeRaum        ;
extern NSString * const TimeTableTypeKlasse      ;
extern NSString * const TimeTableTypeKlassePlural;

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

extern NSString * const TimeTableDescription;

extern NSString * const SettingsVCTitle;
extern NSString * const SettingsVCSearchType;
extern NSString * const SettingsVCSearchText;

extern NSString * const SearchVCTitle;
extern NSString * const SearchVCHint;

// store acronym for own time table
extern NSString * const TimeTableAcronym;

// strings for contacts
extern NSString * const ContactsOverVCTitle;

extern NSString * const ContactsVCTitle;
extern NSString * const EmergencyVCTitle;
extern NSString * const ServiceDeskVCTitle;
extern NSString * const InformationVCTitle;

extern NSString * const ContactsVCTitleBachelorSecretary              ;
extern NSString * const ContactsVCTitleMasterSecretary                ;
extern NSString * const ContactsVCTitleContinuedEducationSecretary    ;

extern NSString * const ContactsVCSectionTitleEngineering             ;
extern NSString * const ContactsVCRealEmailEngineering                ;
extern NSString * const ContactsVCDisplayEmailEngineering             ;

extern NSString * const ContactsVCSectionTitleZurichEngineering       ;
extern NSString * const ContactsVCRealEmailZurichEngineering          ;
extern NSString * const ContactsVCDisplayEmailZurichEngineering       ;

extern NSString * const ContactsVCTitleAviatik         				;
extern NSString * const ContactsVCDisplayPhoneAviatik                 ;
extern NSString * const ContactsVCRealPhoneAviatik                    ;
extern NSString * const ContactsVCResponsibleAviatik                  ;
;
extern NSString * const ContactsVCTitleElectricalEngineering          ;
extern NSString * const ContactsVCDisplayPhoneElectricalEngineering   ;
extern NSString * const ContactsVCRealPhoneElectricalEngineering      ;
extern NSString * const ContactsVCResponsibleElectricalEngineering    ;

extern NSString * const ContactsVCTitleEnvironmentEngineering  		 ;
extern NSString * const ContactsVCDisplayPhoneEnvironmentEngineering  ;
extern NSString * const ContactsVCRealPhoneEnvironmentEngineering     ;
extern NSString * const ContactsVCResponsibleEnvironmentEngineering   ;

extern NSString * const ContactsVCTitleComputerScienceWinterthur 		 ;
extern NSString * const ContactsVCDisplayPhoneComputerScienceWinterthur ;
extern NSString * const ContactsVCRealPhoneComputerScienceWinterthur    ;
extern NSString * const ContactsVCResponsibleComputerScienceWinterthur  ;

extern NSString * const ContactsVCTitleComputerScienceZurich     		 ;
extern NSString * const ContactsVCDisplayPhoneComputerScienceZurich     ;
extern NSString * const ContactsVCRealPhoneComputerScienceZurich        ;
extern NSString * const ContactsVCResponsibleComputerScienceZurich      ;

extern NSString * const ContactsVCTitleMechanicalEngineering     		 ;
extern NSString * const ContactsVCDisplayPhoneMechanicalEngineering     ;
extern NSString * const ContactsVCRealPhoneMechanicalEngineering        ;
extern NSString * const ContactsVCResponsibleMechanicalEngineering      ;

extern NSString * const ContactsVCTitleChemicalEngineering       		 ;
extern NSString * const ContactsVCDisplayPhoneChemicalEngineering       ;
extern NSString * const ContactsVCRealPhoneChemicalEngineering          ;
extern NSString * const ContactsVCResponsibleChemicalEngineering        ;

extern NSString * const ContactsVCTitleSystemEngineering                ;
extern NSString * const ContactsVCDisplayPhoneSystemEngineering         ;
extern NSString * const ContactsVCRealPhoneSystemEngineering            ;
extern NSString * const ContactsVCResponsibleSystemEngineering          ;

extern NSString * const ContactsVCTitleTrafficEngineering        		 ;
extern NSString * const ContactsVCDisplayPhoneTrafficEngineering        ;
extern NSString * const ContactsVCRealPhoneTrafficEngineering           ;
extern NSString * const ContactsVCResponsibleTrafficEngineering         ;

extern NSString * const ContactsVCTitleBusinessEngineering  			 ;
extern NSString * const ContactsVCDisplayPhoneBusinessEngineering       ;
extern NSString * const ContactsVCRealPhoneBusinessEngineering          ;
extern NSString * const ContactsVCResponsibleBusinessEngineering        ;

extern NSString * const ContactsVCSectionTitleMaster                    ;
extern NSString * const ContactsVCTitleMaster                    		;
extern NSString * const ContactsVCDisplayPhoneMaster                    ;
extern NSString * const ContactsVCRealPhoneMaster                       ;
extern NSString * const ContactsVCResponsibleMaster                     ;
extern NSString * const ContactsVCRealEmailMaster                       ;
extern NSString * const ContactsVCDisplayEmailMaster                    ;

extern NSString * const ContactsVCSectionTitleContinuedEducation        ;
extern NSString * const ContactsVCTitleContinuedEducation        		 ;
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


extern NSString * const ContactsVCMessageSendEmail;
extern NSString * const ContactsVCMessageCall;

extern NSString * const EmergencyVCSectionTitleAlarm  ;
extern NSString * const EmergencyVCSectionTitleInform ;


extern NSString * const EmergencyVCDisplayTitlePolice        ;
extern NSString * const EmergencyVCDisplayPhonePolice        ;
extern NSString * const EmergencyVCDisplayTextPolice         ;
extern NSString * const EmergencyVCRealPhonePolice           ;

extern NSString * const EmergencyVCDisplayTitleFire          ;
extern NSString * const EmergencyVCDisplayPhoneFire          ;
extern NSString * const EmergencyVCDisplayTextFire           ;
extern NSString * const EmergencyVCRealPhoneFire             ;

extern NSString * const EmergencyVCDisplayTitleSanitary      ;
extern NSString * const EmergencyVCDisplayPhoneSanitary      ;
extern NSString * const EmergencyVCDisplayTextSanitary       ;
extern NSString * const EmergencyVCRealPhoneSanitary         ;

extern NSString * const EmergencyVCDisplayTitleToxCentre     ;
extern NSString * const EmergencyVCDisplayPhoneToxCentre     ;
extern NSString * const EmergencyVCDisplayTextToxCentre      ;
extern NSString * const EmergencyVCRealPhoneToxCentre        ;

extern NSString * const EmergencyVCDisplayTitleRega          ;
extern NSString * const EmergencyVCDisplayPhoneRega          ;
extern NSString * const EmergencyVCDisplayTextRega           ;
extern NSString * const EmergencyVCRealPhoneRega             ;

extern NSString * const EmergencyVCDisplayTitleZHAWEmergency ;
extern NSString * const EmergencyVCDisplayPhoneZHAWEmergency ;
extern NSString * const EmergencyVCDisplayTextZHAWEmergency  ;
extern NSString * const EmergencyVCRealPhoneZHAWEmergency    ;
extern NSString * const EmergencyVCDisplayZHAWEmergencyAvailability ;

extern NSString * const ServiceDeskVCRealPhone       ;
extern NSString * const ServiceDeskVCDisplayPhone    ;
extern NSString * const ServiceDeskVCRealEmail       ;
extern NSString * const ServiceDeskVCDisplayEmail    ;
extern NSString * const ServiceDeskVCDescriptionEmail;
extern NSString * const ServiceDeskVCDescriptionPhone;

extern NSString * const InformationVCDisplayEmail;
extern NSString * const InformationVCRealEmail;
extern NSString * const InformationVCRealisation;
extern NSString * const InformationVCContact;


// alert view button titles
extern NSString * const AlertViewOk     ;
extern NSString * const AlertViewCancel ;


// social media
extern NSString * const SocialMediaVCTitle;
extern NSString * const SocialMediaFacebook       ;
extern NSString * const SocialMediaFacebookPNG    ;
extern NSString * const SocialMediaYoutube        ;
extern NSString * const SocialMediaYoutubePNG     ;
extern NSString * const SocialMediaTwitter        ;
extern NSString * const SocialMediaTwitterPNG     ;
extern NSString * const SocialMediaIssuu          ;
extern NSString * const SocialMediaIssuuPNG       ;
extern NSString * const SocialMediaXing           ;
extern NSString * const SocialMediaXingPNG        ;

// news and events
extern NSString * const NewsVCTitle;
extern NSString * const NewsVCSmallTitle;
extern NSString * const NewsDetailVCTitle;
extern NSString * const EventsVCTitle;
extern NSString * const EventsVCSmallTitle;
extern NSString * const NewsWebViewHtml;
extern NSString * const NewsWebViewFont;

// public transportation
extern NSString * const PublicTransportVCTitle;
extern NSString * const PublicTransportVCSearchStop;
extern NSString * const PublicTransportVCDetails;
extern NSString * const PublicTransportVCHint;
extern NSString * const PublicTransportVCStart;
extern NSString * const PublicTransportVCGoal;
extern NSString * const PublicTransportVCNew        ;
extern NSString * const PublicTransportVCFromGerman ;
extern NSString * const PublicTransportVCFromEnglish;
extern NSString * const PublicTransportVCToGerman   ;
extern NSString * const PublicTransportVCToEnglish  ;
extern NSString * const PublicTransportVCStartGerman;
extern NSString * const PublicTransportVCStopGerman ;

// time table
extern NSString * const TimeTableOverVCTitle;

// mensa
extern NSString * const MensaVCTitle;
extern NSString * const MensaClosed;

// choose date
extern NSString * const ChooseDateVCTitle;


// language translation
extern NSString * const MondayEnglish ;
extern NSString * const MondayGerman  ;
extern NSString * const TuesdayEnglish;
extern NSString * const TuesdayGerman  ;
extern NSString * const WednesdayEnglish ;
extern NSString * const WednesdayGerman  ;
extern NSString * const ThursdayEnglish ;
extern NSString * const ThursdayGerman  ;
extern NSString * const FridayEnglish ;
extern NSString * const FridayGerman  ;
extern NSString * const SaturdayEnglish ;
extern NSString * const SaturdayGerman  ;
extern NSString * const SundayEnglish ;
extern NSString * const SundayGerman  ;

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