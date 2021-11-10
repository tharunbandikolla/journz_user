import '/Common/AppTheme/AppTheme.dart';
import '/Common/AppTheme/StartupThemePreferences.dart';
import '/Common/AppTheme/ThemeBloc/theme_bloc.dart';
import '/Common/AppTheme/ThemePreferenses.dart';
import '/Common/Helper/SharedPrefCubitForSettingsScreen/sharedpref_cubit.dart';
import '/Common/Helper/StartupThemeHelperCubit/startupthemehelper_cubit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartupThemeSelection extends StatefulWidget {
  const StartupThemeSelection({Key? key}) : super(key: key);

  @override
  _StartupThemeSelectionState createState() => _StartupThemeSelectionState();
}

class _StartupThemeSelectionState extends State<StartupThemeSelection> {
  _setTheme(bool darkTheme, SharedPreferences preferences) {
    AppTheme selectedTheme =
        darkTheme ? AppTheme.lightTheme : AppTheme.darkTheme;

    context.read<ThemeBloc>().add(ThemeEvent(appTheme: selectedTheme));
    Preferences.saveTheme(selectedTheme, preferences);
    //   print('pref theme ${Preferences.getTheme(preferences)}');
  }

  @override
  Widget build(BuildContext context) {
    final changeTheme = BlocProvider.of<StartupthemehelperCubit>(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 30,
          title: Text('Select A Theme'),
          centerTitle: true,
        ),
        body: BlocBuilder<SharedprefCubit, SharedprefState>(
          builder: (context, state) {
            return BlocBuilder<StartupthemehelperCubit,
                StartupthemehelperState>(
              builder: (context, themeState) {
                print('nnn the data ${themeState.iconSizeChanger}');
                return Container(
                    /* padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.07,
                        vertical: context.screenWidth * 0.025), */
                    width: context.screenWidth,
                    height: context.screenHeight,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: context.screenWidth,
                            height: context.screenWidth * 1.25,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: !themeState.iconSizeChanger!
                                        ? AssetImage(
                                            'assets/images/appdark.jpeg')
                                        : AssetImage(
                                            'assets/images/appLight.jpeg'))),
                          ),

                          /* "Select A Theme"
                          .text
                          .xl2
                          .bold
                          .make()
                          .box
                          .p16
                          .alignCenterLeft
                          .make(), */
                          SizedBox(height: context.screenWidth * 0.07),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    _setTheme(true, state.pref);
                                    changeTheme.isDarkTheme(true);
                                    //Navigator.pushReplacementNamed(
                                    //  context, '/MyApp');
                                  },
                                  child: Text('Light Theme')),
                              ElevatedButton(
                                  onPressed: () {
                                    _setTheme(false, state.pref);
                                    changeTheme.isDarkTheme(false);
                                    //Navigator.pushReplacementNamed(
                                    //  context, '/MyApp');
                                  },
                                  child: Text('Dark Theme'))
                            ],
                          ),
                          SizedBox(height: context.screenWidth * 0.07),
                          ElevatedButton(
                              onPressed: () {
                                SharedPreferences.getInstance().then((value) {
                                  StartupThemePreferences.setShown(
                                      value, false);
                                });
                                Navigator.pushReplacementNamed(
                                    context, '/MyApp');
                              },
                              child: Text('Continue')),
                          SizedBox(height: context.screenWidth * 0.1),
                        ],
                      ),
                    ));
              },
            );
          },
        ));
  }
}
