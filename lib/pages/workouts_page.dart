import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/setup.dart';
import '../utils/utils.dart';
import '../widgets/list_header.dart';
import '../widgets/empty_list_prompt.dart';
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
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
        child: model.workouts.isNotEmpty ?
        _buildWorkoutsList(model) :
          EmptyListPrompt(text: "Add a new workout to get started!"),
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

  Widget _buildWorkoutsList(AppModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListHeader(text: 'Workouts',),
        Expanded(
          child: ListView.builder(
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
                  subtitle: Text('Tabatas: ${workout.tabatas.length}  Rest: ${workout.tabataRestDuration.format()}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          model.currentWorkout = workout;
                          Navigator.pushNamed(context, EditWorkoutPage.route);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_forever),
                        onPressed: () {
                          setState(() {
                            model.removeWorkout(workout);
                          });
                        },
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
