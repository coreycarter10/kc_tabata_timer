import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/setup.dart';
import 'edit_tabata_page.dart';

class EditWorkoutPage extends StatefulWidget {
  static const route = '/editworkout';

  final String title;

  EditWorkoutPage({Key key, this.title}) : super(key: key);

  @override
  _EditWorkoutPageState createState() => _EditWorkoutPageState();
}

class _EditWorkoutPageState extends State<EditWorkoutPage> {
  Workout _workout;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppModel>(context);

    _workout = model.currentWorkout ?? Workout();

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title} -- Edit Workout"),
      ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _workout.tabatas.length,
          itemBuilder: (BuildContext context, int i) {
            final tabata = _workout.tabatas[i];

            return Card(
              child: ListTile(
                leading: const Icon(Icons.timer),
                title: Text(tabata.exercises.join(', ')),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    model.currentTabata = tabata;
                    Navigator.pushNamed(context, EditTabataPage.route);
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
          Navigator.pushNamed(context, EditTabataPage.route);
        },
      ),
    );
  }
}
