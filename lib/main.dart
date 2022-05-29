import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_trackr/data/user/user_data_source.dart';
import 'package:gym_trackr/domain/model/user.dart';
import 'package:gym_trackr/ui/common/providers/current_tab_provider.dart';
import 'package:gym_trackr/ui/common/providers/delete_mode_provider.dart';
import 'package:gym_trackr/ui/common/providers/details_page_shown_provider.dart';
import 'package:gym_trackr/ui/common/providers/exercise_data_source_provider.dart';
import 'package:gym_trackr/ui/common/providers/exercise_deleted_provider.dart';
import 'package:gym_trackr/ui/common/providers/theme_data_provider.dart';
import 'package:gym_trackr/ui/screens/home/home_screen.dart';
import 'package:gym_trackr/ui/screens/settings/settings_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ThemeDataProvider()),
            ChangeNotifierProvider(create: (context) => CurrentTabProvider()),
            ChangeNotifierProvider(create: (context) => DetailsPageShownProvider()),
            ChangeNotifierProvider(create: (context) => ExerciseDataSourceProvider()),
            ChangeNotifierProvider(create: (context) => ExerciseDeletedProvider()),
            ChangeNotifierProvider(create: (context) => DeleteModeProvider()),
          ],
          child: const GymTrackr()
      )
  );
}

class GymTrackr extends StatefulWidget {
  const GymTrackr({Key? key}) : super(key: key);

  @override
  _GymTrackrState createState() => _GymTrackrState();
}

class _GymTrackrState extends State<GymTrackr> {

  Widget _buildPage(int currentTab) {

    switch(currentTab) {
      case 0: return const HomeScreen();
      default: return const SettingsScreen();
    }
  }

  Future<void> _checkUserId() async {
    if(!await UserDataSource.isUserIdSet()) {
      String generatedUserId = await UserDataSource.setUserId();
      final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

      await usersCollection.add(User(userId: generatedUserId).toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeDataProvider = context.watch<ThemeDataProvider>();
    final currentTabProvider = context.watch<CurrentTabProvider>();

    return FutureBuilder(
        future: _checkUserId(),
        builder: (context, val) {
          if(val.connectionState == ConnectionState.done) {
            return MaterialApp(
                title: 'gym trackr',
                debugShowCheckedModeBanner: false,
                theme: themeDataProvider.themeData.themeData,
                home: Scaffold(
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: _buildPage(currentTabProvider.currentTab),
                    ),
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    selectedItemColor: themeDataProvider.themeData.themeData
                        .primaryColor,
                    backgroundColor: themeDataProvider.themeData.themeData
                        .scaffoldBackgroundColor,
                    currentIndex: currentTabProvider.currentTab,
                    onTap: (int value) {
                      context.watch<CurrentTabProvider>().setCurrentTab(value);
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: const Icon(
                          Icons.home,
                          size: 30.0,
                        ),
                        label: "Home",
                        backgroundColor: themeDataProvider.themeData.themeData
                            .primaryColor,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(
                          Icons.settings,
                          size: 30.0,
                        ),
                        label: "Settings",
                        backgroundColor: themeDataProvider.themeData.themeData
                            .primaryColor,
                      )
                    ],
                  ),
                ));
          } else {
            return Container();
          }
        }
    );
  }

}
