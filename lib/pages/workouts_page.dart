import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/setup.dart';
import '../utils/utils.dart';
import 'edit_workout_page.dart';

class WorkoutsPage extends StatefulWidget {
  static const route = '/';

  final String title;

  WorkoutsPage({Key key, this.title}) : super(key: key);

  @override
  _WorkoutsPageState createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title} -- Workouts"),
      ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: model.workouts.length,
          itemBuilder: (BuildContext context, int i) {
            final workout = model.workouts[i];

            return Card(
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Text(workout.totalTime.format()),],
                ),
                title: Text(workout.name),
                subtitle: Text('${workout.tabatas.length} tabatas'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    model.currentWorkout = workout;
                    Navigator.pushNamed(context, EditWorkoutPage.route);
                  },
                ),
                onTap: () {},
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          model.clearCurrentWorkout();
          Navigator.pushNamed(context, EditWorkoutPage.route);
        },
      ),
    );
  }
}
