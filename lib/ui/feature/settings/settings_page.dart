import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/ui/global/localization/app_localizations.dart';
import 'package:flutter_todo/ui/global/localization/bloc/bloc.dart';
import 'package:flutter_todo/ui/global/localization/localizations_delegates.dart';
import 'package:flutter_todo/ui/global/theme/bloc/theme_bloc.dart';
import 'package:flutter_todo/ui/global/theme/bloc/theme_event.dart';
import 'package:flutter_todo/ui/global/theme/theme_data/app_themes.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage();

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkTheme = false;
  Locale _currentLocale;
  bool alreadyInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!alreadyInit) {
      setState(() {
        _darkTheme = Theme.of(context).brightness == Brightness.dark;
        _currentLocale = Localizations.localeOf(context);
      });
      alreadyInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final translator = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(translator.translate('title_settings')),
      ),
      body: _buildBody(context, translator),
    );
  }

  Widget _buildBody(BuildContext context, AppLocalizations translator) {
    return ListView(
      children: <Widget>[
        _buildThemeItem(translator),
        _buildLanguageItem(translator),
      ],
    );
  }

  Widget _buildThemeItem(AppLocalizations translator) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(),
      child: ListTile(
          leading: Icon(Icons.format_paint),
          title: Text(translator.translate('title_themes_dark')),
          trailing: Switch.adaptive(
            value: _darkTheme,
            onChanged: (darkTheme) {
              _changeTheme();
            },
          ),
          onTap: _changeTheme),
    );
  }

  Widget _buildLanguageItem(AppLocalizations translator) {
    final supportedLocales = LocalizationsDelegates.instance.supportedLocales;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(),
      margin: EdgeInsets.all(0),
      child: ListTile(
        leading: Icon(Icons.language),
        title: Text(translator.translate('title_languages')),
        trailing: DropdownButton<Locale>(
          value: _currentLocale,
          icon: Icon(Icons.arrow_downward),
          iconSize: 18,
          elevation: 16,
          onChanged: (Locale newValue) {
            _changeLanguage(newValue);
          },
          items:
              supportedLocales.map<DropdownMenuItem<Locale>>((Locale locale) {
            return DropdownMenuItem<Locale>(
              value: locale,
              child: SizedBox(
                width: 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    //Icon(FontAwesomeIcons.globeAfrica, size: 16,),
                    SizedBox(
                      width: 4,
                    ),
                    Text(translator.translate(locale.toString())),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        //onTap: () => AppNavigator.instance.navToLanguagesSetting(context),
      ),
    );
  }

  void _changeLanguage(Locale locale) {
    setState(() {
      _currentLocale = locale;
      BlocProvider.of<LocalizationsBloc>(context)
          .add(LocaleChanged(locale: _currentLocale));
    });
  }

  void _changeTheme() {
    setState(() {
      _darkTheme = !_darkTheme;
    });
    BlocProvider.of<ThemeBloc>(context)
        .add(ChangeTheme(theme: _darkTheme ? ThemeType.Dark : ThemeType.Light));
  }
}
