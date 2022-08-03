import 'package:flutter/material.dart';
import 'package:new_life/utils/my_theme.dart';
import 'package:provider/provider.dart';

class ChangeThemeButtonWidget extends StatefulWidget {
  const ChangeThemeButtonWidget({Key? key}) : super(key: key);

  @override
  State<ChangeThemeButtonWidget> createState() =>
      _ChangeThemeButtonWidgetState();
}

class _ChangeThemeButtonWidgetState extends State<ChangeThemeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode() {
      var brightness = MediaQuery.of(context).platformBrightness;
      bool isDarkMode = brightness == Brightness.dark;
      return isDarkMode;
    }

    // var brightness = MediaQuery.of(context).platformBrightness;
    // bool isDarkMode = brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
      activeColor: Colors.black,
      activeTrackColor: Colors.white.withOpacity(0.4),
      inactiveTrackColor: Colors.yellow.withOpacity(0.3),
      value: themeProvider.isDarkMode,
      inactiveThumbImage: AssetImage('assets/light_mode_3.png'),
      activeThumbImage: AssetImage('assets/Moon.png'),
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
        setState(() {});
      },
    );
  }
}
