import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/setup.dart';
import 'pages/workouts_page.dart';
import 'pages/edit_workout_page.dart';
import 'pages/edit_tabata_page.dart';

const appTitle = 'KC Tabata Timer';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AppModel>(
      create: (_) => AppModel(),
      child: MaterialApp(
        title: 'KC Tabata Timer',
        theme: ThemeData.dark(),
        routes: {
          WorkoutsPage.route: (_) => WorkoutsPage(title: appTitle),
          EditWorkoutPage.route: (_) => EditWorkoutPage(),
          EditTabataPage.route: (_) => EditTabataPage(),
        },
      ),
    );
  }
}