import 'package:flutter/material.dart';
import 'package:gym_trackr/ui/common/theme_data_provider.dart';
import 'package:gym_trackr/ui/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeDataProvider())
      ],
      child: const GymTrackr()
  )
);

class GymTrackr extends StatefulWidget {
  const GymTrackr({Key? key}) : super(key: key);

  @override
  _GymTrackrState createState() => _GymTrackrState();
}

class _GymTrackrState extends State<GymTrackr> {

  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    final themeDataProvider = context.watch<ThemeDataProvider>();

    return MaterialApp(
        title: 'gym trackr',
        debugShowCheckedModeBanner: false,
        theme: themeDataProvider.themeData.themeData,
        home: Scaffold(
          body: const SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: HomeScreen(),
              )
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: themeDataProvider.themeData.themeData.primaryColor,
            backgroundColor: themeDataProvider.themeData.themeData.scaffoldBackgroundColor,
            currentIndex: _currentTab,
            onTap: (int value) {
              setState(() {
                _currentTab = value;
              });
              Provider.of<ThemeDataProvider>(context, listen: false).toggleDarkMode();
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 30.0,
                  color: themeDataProvider.themeData.mainTextColor,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                  size: 30.0,
                  color: themeDataProvider.themeData.mainTextColor,
                ),
                label: "Settings",
              )
            ],
          ),
        ));
  }

}
