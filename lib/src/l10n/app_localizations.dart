import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Flutter Todo'**
  String get app_name;

  /// No description provided for @act_add_todo.
  ///
  /// In en, this message translates to:
  /// **'Add todo'**
  String get act_add_todo;

  /// No description provided for @act_try_again.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get act_try_again;

  /// No description provided for @title_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get title_settings;

  /// No description provided for @title_themes_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark theme'**
  String get title_themes_dark;

  /// No description provided for @title_languages.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get title_languages;

  /// No description provided for @title_complete_toto.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get title_complete_toto;

  /// No description provided for @title_incomplete_toto.
  ///
  /// In en, this message translates to:
  /// **'Incomplete'**
  String get title_incomplete_toto;

  /// No description provided for @subtitle_add_date.
  ///
  /// In en, this message translates to:
  /// **'Add date'**
  String get subtitle_add_date;

  /// No description provided for @msg_suggestion_no_todo.
  ///
  /// In en, this message translates to:
  /// **'You have no todo!'**
  String get msg_suggestion_no_todo;

  /// No description provided for @msg_suggestion_no_complete.
  ///
  /// In en, this message translates to:
  /// **'You have no completed todo!'**
  String get msg_suggestion_no_complete;

  /// No description provided for @msg_suggestion_no_incomplete.
  ///
  /// In en, this message translates to:
  /// **'You have no incomplete todo!'**
  String get msg_suggestion_no_incomplete;

  /// No description provided for @msg_text_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter some text'**
  String get msg_text_required;

  /// No description provided for @hint_add_todo.
  ///
  /// In en, this message translates to:
  /// **'Add todo'**
  String get hint_add_todo;

  /// No description provided for @en_EN.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get en_EN;

  /// No description provided for @vi_VN.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get vi_VN;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
