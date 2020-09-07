import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fst_app_flutter/models/preferences/theme_model.dart';
import 'package:fst_app_flutter/utils/app_theme.dart';

// TODO: document @richtwin567
class ThemeChooserDialog extends StatefulWidget {
  const ThemeChooserDialog({Key key}) : super(key: key);

  @override
  ThemeChooserDialogState createState() => ThemeChooserDialogState();
}

class ThemeChooserDialogState extends State<ThemeChooserDialog> {
  @override
  Widget build(BuildContext context) {
    var themeModel = ModalRoute.of(context).settings.arguments as ThemeModel;
    ThemeMode themeGroupValue = themeModel.selectedTheme;
    ThemeData currentTheme = AppTheme.getTheme(themeModel.selectedTheme,
        SchedulerBinding.instance.window.platformBrightness);

    var radioTextStyle = Theme.of(context)
        .textTheme
        .subtitle1
        .copyWith(color: currentTheme.textTheme.subtitle1.color);
    return AlertDialog(
        backgroundColor: currentTheme.cardColor,
        contentTextStyle: radioTextStyle,
        titleTextStyle: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: currentTheme.textTheme.headline6.color),
        actions: [
          FlatButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
        ],
        title: Text('Theme'),
        content: SingleChildScrollView(
            child: Container(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                trailing: Radio(
                  activeColor: currentTheme.toggleableActiveColor,
                  value: ThemeMode.system,
                  groupValue: themeGroupValue,
                  onChanged: (value) {
                    setState(() {
                      themeGroupValue = value;
                      themeModel.switchThemeTo(value);
                    });
                  },
                ),
                title: Text(
                  'System',
                  style: radioTextStyle,
                ),
              ),
              ListTile(
                trailing: Radio(
                  activeColor: currentTheme.toggleableActiveColor,
                  value: ThemeMode.dark,
                  groupValue: themeGroupValue,
                  onChanged: (value) {
                    setState(() {
                      themeGroupValue = value;
                      themeModel.switchThemeTo(value);
                    });
                  },
                ),
                title: Text(
                  'Dark',
                  style: radioTextStyle,
                ),
              ),
              ListTile(
                trailing: Radio(
                  activeColor: currentTheme.toggleableActiveColor,
                  value: ThemeMode.light,
                  groupValue: themeGroupValue,
                  onChanged: (value) {
                    setState(() {
                      themeGroupValue = value;
                      themeModel.switchThemeTo(value);
                    });
                  },
                ),
                title: Text(
                  'Light',
                  style: radioTextStyle,
                ),
              )
            ],
          ),
        )));
  }
}
