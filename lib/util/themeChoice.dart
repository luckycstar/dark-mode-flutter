import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:theme_switcher/util/themeModeNotifier.dart';

class ThemeChoice extends StatefulWidget {
  ThemeChoice() : super();
  @override
  ThemeChoiceState createState() => ThemeChoiceState();
}

class ThemeChoiceState extends State<ThemeChoice> {
  ThemeMode _selectedThemeMode;

  List _options = [
    { "title": 'System', "value": ThemeMode.system },
    { "title": 'Light', "value": ThemeMode.light },
    { "title": 'Dark', "value": ThemeMode.dark }
  ];

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _createOptions(ThemeModeNotifier themeModeNotifier) {
    List<Widget> widgets = [];
    for (Map option in _options) {
      widgets.add(
        RadioListTile(
          value: option['value'],
          groupValue: _selectedThemeMode,
          title: Text(option['title']),
          onChanged: (mode) {
            _setSelectedThemeMode(mode, themeModeNotifier);
          },
          selected: _selectedThemeMode == option['value'],
          activeColor: Colors.orange,
        ),
      );
    }
    return widgets;
  }

  void _setSelectedThemeMode(ThemeMode mode, ThemeModeNotifier themeModeNotifier) async {
    themeModeNotifier.setThemeMode(mode);
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeMode', mode.index);
    setState(() {
      _selectedThemeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    // init radios with current themeMode
    final themeModeNotifier = Provider.of<ThemeModeNotifier>(context);
    setState(() {
      _selectedThemeMode = themeModeNotifier.getThemeMode();
    });
    // build the Widget
    return Column(
      children: <Widget>[
        Column(
          children: _createOptions(themeModeNotifier),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Current ThemeMode:',
              ),
              Text(
                '$_selectedThemeMode',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
