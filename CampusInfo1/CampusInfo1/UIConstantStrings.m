//
//  UIConstantStrings.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 30.08.13.
//
//

#import "UIConstantStrings.h"

@implementation UIConstantStrings

// arrows for navigation bars and back buttons
NSString * const LeftArrowSymbol  = @"\U000025C0\U0000FE0E";
NSString * const RightArrowSymbol = @"\U000025B6\U0000FE0E";


// strings for maps/standorte
NSString * const MapsVCTitle        = @"Standorte";
NSString * const MapsVCTechnikum    = @"Winterthur, Technikum";
NSString * const MapsVCZurich       = @"Zürich, Lagerstrasse";
NSString * const MapsVCToessfeld    = @"Winterthur, Tössfeld";

NSString * const ZurichVCTitle      = @"Zürich - Campus Lagerstrasse";
NSString * const ZurichVCFileName   = @"Zuerich";
NSString * const ZurichVCFileFormat = @"pdf";

NSString * const TechnikumVCTitle      = @"Winterthur - Campus Technikumstrasse";
NSString * const TechnikumVCFileName   = @"Technikumstrasse";
NSString * const TechnikumVCFileFormat = @"pdf";

NSString * const ToessfeldVCTitle      = @"Winterthur - Campus Tössfeld";
NSString * const ToessfeldVCFileName   = @"Toessfeld";
NSString * const ToessfeldVCFileFormat = @"pdf";


// strings for settings/ time table details
NSString * const TimeTableTypeStudent       = @"Student";
NSString * const TimeTableTypeDozent        = @"Dozent";
NSString * const TimeTableTypeDozentPlural  = @"Dozenten";
NSString * const TimeTableTypeKurs          = @"Kurs";
NSString * const TimeTableTypeRaum          = @"Raum";
NSString * const TimeTableTypeKlasse        = @"Klasse";
NSString * const TimeTableTypeKlassePlural  = @"Klassen:";

NSString * const TimeTableTypeStudentEnglish            = @"student";
NSString * const TimeTableTypeStudentEnglishPlural      = @"students";
NSString * const TimeTableTypeLecturerEnglishPlural     = @"lecturers";
NSString * const TimeTableTypeLecturerEnglish           = @"lecturer";
NSString * const TimeTableTypeCourseEnglishPlural       = @"courses";
NSString * const TimeTableTypeCourseEnglish             = @"course";
NSString * const TimeTableTypeRoomEnglish               = @"room";
NSString * const TimeTableTypeRoomEnglishPlural         = @"rooms";
NSString * const TimeTableTypeClassEnglishPlural        = @"classes";
NSString * const TimeTableTypeClassEnglish              = @"class";

NSString * const TimeTableDescription = @"Beschreibung";


NSString * const SettingsVCTitle      = @"Einstellungen";
NSString * const SettingsVCSearchType = @"SearchType";
NSString * const SettingsVCSearchText = @"SearchText";

NSString * const SearchVCTitle        = @"Stundenplan Suche";
NSString * const SearchVCHint         = @"Bitte ein Kürzel eingeben.";

// store acronym for own time table
NSString * const TimeTableAcronym     = @"TimeTableAcronym";


// strings for contacts
NSString * const ContactsOverVCTitle    = @"Kontakte";

NSString * const ContactsVCTitle        = @"Sekretariate";
NSString * const EmergencyVCTitle       = @"Notfall";
NSString * const ServiceDeskVCTitle     = @"Service Desk";

// strings for contacts secretary
NSString * const ContactsVCTitleBachelorSecretary                = @"Bachelorsekretariat";
NSString * const ContactsVCTitleMasterSecretary                  = @"Mastersekretariat";
NSString * const ContactsVCTitleContinuedEducationSecretary      = @"Weiterbildungssekretariat";

NSString * const ContactsVCSectionTitleEngineering              = @"Standort Winterthur";
NSString * const ContactsVCRealEmailEngineering                 = @"info-sg.engineering@zhaw.ch";
NSString * const ContactsVCDisplayEmailEngineering              = @"info-sg.engineering(at)zhaw.ch";

NSString * const ContactsVCSectionTitleZurichEngineering        = @"Standort Zürich";
NSString * const ContactsVCRealEmailZurichEngineering           = @"info-sg.zh.engineering@zhaw.ch";
NSString * const ContactsVCDisplayEmailZurichEngineering        = @"info-sg.zh.engineering(at)zhaw.ch";

NSString * const ContactsVCTitleAviatik         				 = @"Aviatik";
NSString * const ContactsVCDisplayPhoneAviatik                   = @"Tel. +41 58 934 75 60";
NSString * const ContactsVCRealPhoneAviatik                      = @"0041589347560";
NSString * const ContactsVCResponsibleAviatik                    = @"Gianna Scherrer";

NSString * const ContactsVCTitleElectricalEngineering            = @"Elektrotechnik";
NSString * const ContactsVCDisplayPhoneElectricalEngineering     = @"Tel. +41 58 934 73 66";
NSString * const ContactsVCRealPhoneElectricalEngineering        = @"0041589347366";
NSString * const ContactsVCResponsibleElectricalEngineering      = @"Eliane Roth";

NSString * const ContactsVCTitleEnvironmentEngineering  		 = @"Energie- und Umwelttechnik";
NSString * const ContactsVCDisplayPhoneEnvironmentEngineering    = @"Tel. +41 58 934 75 63";
NSString * const ContactsVCRealPhoneEnvironmentEngineering       = @"0041589347563";
NSString * const ContactsVCResponsibleEnvironmentEngineering     = @"Jennifer Hohl";

NSString * const ContactsVCTitleComputerScienceWinterthur 		 = @"Informatik Standort Winterthur";
NSString * const ContactsVCDisplayPhoneComputerScienceWinterthur = @"Tel. +41 58 934 75 63";
NSString * const ContactsVCRealPhoneComputerScienceWinterthur    = @"0041589347563";
NSString * const ContactsVCResponsibleComputerScienceWinterthur  = @"Jennifer Hohl";

NSString * const ContactsVCTitleComputerScienceZurich     		 = @"Informatik Standort Zürich";
NSString * const ContactsVCDisplayPhoneComputerScienceZurich     = @"Tel. +41 58 934 82 42";
NSString * const ContactsVCRealPhoneComputerScienceZurich        = @"0041589348242";
NSString * const ContactsVCResponsibleComputerScienceZurich      = @"Zita Fejér";

NSString * const ContactsVCTitleMechanicalEngineering     		 = @"Allgemeine Maschinentechnik";
NSString * const ContactsVCDisplayPhoneMechanicalEngineering     = @"Tel. +41 58 934 74 14";
NSString * const ContactsVCRealPhoneMechanicalEngineering        = @"0041589347414";
NSString * const ContactsVCResponsibleMechanicalEngineering      = @"Béatrice Schaffner";

NSString * const ContactsVCTitleChemicalEngineering       		 = @"Material- und Verfahrenstechnik";
NSString * const ContactsVCDisplayPhoneChemicalEngineering       = @"Tel. +41 58 934 74 14";
NSString * const ContactsVCRealPhoneChemicalEngineering          = @"0041589347414";
NSString * const ContactsVCResponsibleChemicalEngineering        = @"Béatrice Schaffner";

NSString * const ContactsVCTitleSystemEngineering                = @"Systemtechnik";
NSString * const ContactsVCDisplayPhoneSystemEngineering         = @"Tel. +41 58 934 73 66";
NSString * const ContactsVCRealPhoneSystemEngineering            = @"0041589347366";
NSString * const ContactsVCResponsibleSystemEngineering          = @"Eliane Roth";

NSString * const ContactsVCTitleTrafficEngineering        		 = @"Verkehrssysteme";
NSString * const ContactsVCDisplayPhoneTrafficEngineering        = @"Tel. +41 58 934 73 66";
NSString * const ContactsVCRealPhoneTrafficEngineering           = @"0041589347366";
NSString * const ContactsVCResponsibleTrafficEngineering         = @"Eliane Roth";

NSString * const ContactsVCTitleBusinessEngineering  			 = @"Wirtschaftsingenieurwesen";
NSString * const ContactsVCDisplayPhoneBusinessEngineering       = @"Tel. +41 58 934 75 60";
NSString * const ContactsVCRealPhoneBusinessEngineering          = @"0041589347560";
NSString * const ContactsVCResponsibleBusinessEngineering        = @"Gianna Scherrer";

NSString * const ContactsVCSectionTitleMaster                    = @"Masterstudiengang";
NSString * const ContactsVCTitleMaster                    		 = @"Master of Science in Engineering";
NSString * const ContactsVCDisplayPhoneMaster                    = @"Tel. +41 58 934 75 63";
NSString * const ContactsVCRealPhoneMaster                       = @"0041589347563";
NSString * const ContactsVCResponsibleMaster                     = @"Jennifer Hohl";
NSString * const ContactsVCRealEmailMaster                       = @"mse.engineering@zhaw.ch";
NSString * const ContactsVCDisplayEmailMaster                    = @"mse.engineering(at)zhaw.ch";

NSString * const ContactsVCSectionTitleContinuedEducation        = @"Weiterbildung";
NSString * const ContactsVCTitleContinuedEducation        		 = @"Weiterbildung (MAS, CAS, DAS und WBK)";
NSString * const ContactsVCRealEmailContinuedEducation           = @"weiterbildung.engineering@zhaw.ch";
NSString * const ContactsVCDisplayEmailContinuedEducation        = @"weiterbildung.engineering(at)zhaw.ch";

NSString * const ContactsVCDisplayPhone0ContinuedEducation        = @"Tel. +41 58 934 74 28";
NSString * const ContactsVCRealPhone0ContinuedEducation           = @"0041589347428";
NSString * const ContactsVCResponsible0ContinuedEducation         = @"Mirjam Holenstein";

NSString * const ContactsVCDisplayPhone1ContinuedEducation        = @"Tel. +41 58 934 74 28";
NSString * const ContactsVCRealPhone1ContinuedEducation           = @"0041589347428";
NSString * const ContactsVCResponsible1ContinuedEducation         = @"Silvia Cetti";

NSString * const ContactsVCDisplayPhone2ContinuedEducation        = @"Tel. +41 58 934 82 44";
NSString * const ContactsVCRealPhone2ContinuedEducation           = @"0041589348244";
NSString * const ContactsVCResponsible2ContinuedEducation         = @"Erika Wentsch";

NSString * const ContactsVCMessageSendEmail             = @"Sende E-mail an";
NSString * const ContactsVCMessageCall                  = @"anrufen";

NSString * const EmergencyVCSectionTitleAlarm           = @"1. Alarmieren > wenn nötig";
NSString * const EmergencyVCSectionTitleInform          = @"2. Informieren > immer";


NSString * const EmergencyVCDisplayTitlePolice          = @"Polizei";
NSString * const EmergencyVCDisplayPhonePolice          = @"117";
NSString * const EmergencyVCDisplayTextPolice           = @"Die Polizei";
NSString * const EmergencyVCRealPhonePolice             = @"117";

NSString * const EmergencyVCDisplayTitleFire          = @"Feuerwehr";
NSString * const EmergencyVCDisplayPhoneFire          = @"118";
NSString * const EmergencyVCDisplayTextFire           = @"Die Feuerwehr";
NSString * const EmergencyVCRealPhoneFire             = @"118";

NSString * const EmergencyVCDisplayTitleSanitary      = @"Sanität";
NSString * const EmergencyVCDisplayPhoneSanitary      = @"144";
NSString * const EmergencyVCDisplayTextSanitary       = @"Die Sanität";
NSString * const EmergencyVCRealPhoneSanitary         = @"144";

NSString * const EmergencyVCDisplayTitleToxCentre     = @"Tox-Zentrum";
NSString * const EmergencyVCDisplayPhoneToxCentre     = @"145";
NSString * const EmergencyVCDisplayTextToxCentre      = @"Das Tox-Zentrum";
NSString * const EmergencyVCRealPhoneToxCentre        = @"145";

NSString * const EmergencyVCDisplayTitleRega          = @"REGA";
NSString * const EmergencyVCDisplayPhoneRega          = @"1414";
NSString * const EmergencyVCDisplayTextRega           = @"Die REGA";
NSString * const EmergencyVCRealPhoneRega             = @"1414";

NSString * const EmergencyVCDisplayTitleZHAWEmergency = @"ZHAW-Notfallnummer";
NSString * const EmergencyVCDisplayPhoneZHAWEmergency = @"+41 58 934 70 70";
NSString * const EmergencyVCDisplayTextZHAWEmergency  = @"Die ZHAW-Notfallnummer";
NSString * const EmergencyVCRealPhoneZHAWEmergency    = @"0589347070";
NSString * const EmergencyVCDisplayZHAWEmergencyAvailability = @"(365 Tage/24 Stunden)";

NSString * const ServiceDeskVCRealPhone         = @"0041589346677";
NSString * const ServiceDeskVCDisplayPhone      = @"+41 58 934 66 77";
NSString * const ServiceDeskVCRealEmail         = @"servicedesk@zhaw.ch";
NSString * const ServiceDeskVCDisplayEmail      = @"servicedesk(at)zhaw.ch";
NSString * const ServiceDeskVCDescriptionEmail  = @"Email:";
NSString * const ServiceDeskVCDescriptionPhone  = @"Tel.:";

// alert view button titles
NSString * const AlertViewOk         = @"OK";
NSString * const AlertViewCancel     = @"Cancel";

// social media
NSString * const SocialMediaVCTitle         = @"Social Media";
NSString * const SocialMediaFacebook        = @"Facebook";
NSString * const SocialMediaFacebookPNG     = @"facebook.png";
NSString * const SocialMediaYoutube         = @"Youtube";
NSString * const SocialMediaYoutubePNG      = @"youtube.png";
NSString * const SocialMediaTwitter         = @"Twitter";
NSString * const SocialMediaTwitterPNG      = @"twitter.png";
NSString * const SocialMediaIssuu           = @"Issuu";
NSString * const SocialMediaIssuuPNG        = @"issuu.png";
NSString * const SocialMediaXing            = @"Xing";
NSString * const SocialMediaXingPNG         = @"xing.png";


// news and events
NSString * const NewsVCTitle        = @"News - School of Engineering";
NSString * const NewsVCSmallTitle   = @"News";
NSString * const NewsDetailVCTitle  = @"News";
NSString * const EventsVCTitle      = @"Events - School of Engineering";
NSString * const EventsVCSmallTitle = @"Events";
NSString * const NewsWebViewHtml    = @"<html> \n"
"<head> \n"
"<style type=\"text/css\"> \n"
"body {font-family: \"%@\";font-size: 13;}\n"
"</style> \n"
"</head> \n"
"<body>%@</body> \n"
"</html>";
NSString * const NewsWebViewFont   = @"helvetica";


// public transportation
NSString * const PublicTransportVCTitle         = @"Fahrplan";
NSString * const PublicTransportVCHint          = @"Bitte Start und Ziel eingeben.";
NSString * const PublicTransportVCStart         = @"Start";
NSString * const PublicTransportVCGoal          = @"Ziel";
NSString * const PublicTransportVCNew           = @"neu...";
NSString * const PublicTransportVCFromGerman    = @"ab";
NSString * const PublicTransportVCFromEnglish   = @"from";
NSString * const PublicTransportVCToGerman      = @"an";
NSString * const PublicTransportVCToEnglish     = @"to";


// time table
NSString * const TimeTableOverVCTitle = @"Stundenplan";

// mensa
NSString * const MensaVCTitle = @"Mensa";
NSString * const MensaClosed  = @"geschlossen";

// choose date
NSString * const ChooseDateVCTitle = @"Datum wählen";

// language translation
NSString * const MondayEnglish = @"monday";
NSString * const MondayGerman  = @"Montag";
NSString * const TuesdayEnglish = @"tuesday";
NSString * const TuesdayGerman  = @"Dienstag";
NSString * const WednesdayEnglish = @"wednesday";
NSString * const WednesdayGerman  = @"Mittwoch";
NSString * const ThursdayEnglish = @"thursday";
NSString * const ThursdayGerman  = @"Donnerstag";
NSString * const FridayEnglish = @"friday";
NSString * const FridayGerman  = @"Freitag";
NSString * const SaturdayEnglish = @"saturday";
NSString * const SaturdayGerman  = @"Samstag";
NSString * const SundayEnglish = @"sunday";
NSString * const SundayGerman  = @"Sonntag";

// menu overview png
NSString * const AppIconTimeTable                   = @"AppIconsSchriftStundenplan.png";
NSString * const AppIconTimeTableFeedback           = @"AppIconsSchriftStundenplanFeedback.png";
NSString * const AppIconMensa                       = @"AppIconsSchriftMensa.png";
NSString * const AppIconMensaFeedback               = @"AppIconsSchriftMensaFeedback.png";
NSString * const AppIconPublicTransport             = @"AppIconsSchriftFahrplan.png";
NSString * const AppIconPublicTransportFeedback     = @"AppIconsSchriftFahrplanFeedback.png";
NSString * const AppIconContacts                    = @"AppIconsSchriftKontakte.png";
NSString * const AppIconContactsFeedback            = @"AppIconsSchriftKontakteFeedback.png";
NSString * const AppIconMaps                        = @"AppIconsSchriftStandorte.png";
NSString * const AppIconMapsFeedback                = @"AppIconsSchriftStandorteFeedback.png";
NSString * const AppIconSocialMedia                 = @"AppIconsSchriftSocialMedia.png";
NSString * const AppIconSocialMediaFeedback         = @"AppIconsSchriftSocialMediaFeedback.png";
NSString * const AppIconSettings                    = @"AppIconsSchriftEinstellungen.png";
NSString * const AppIconSettingsFeedback            = @"AppIconsEinstellungenFeedback.png";
NSString * const AppIconNews                        = @"AppIconsSchriftNews.png";
NSString * const AppIconNewsFeedback                = @"AppIconsSchriftNewsFeedback.png";
NSString * const AppIconEvents                      = @"AppIconsSchriftEvents.png";
NSString * const AppIconEventsFeedback              = @"AppIconsSchriftEventsFeedback.png";


@end
