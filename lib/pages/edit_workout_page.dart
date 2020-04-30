import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/setup.dart';
import '../utils/utils.dart';
import '../widgets/min_sec_selector.dart';
import 'edit_tabata_page.dart';

class EditWorkoutPage extends StatefulWidget {
  static const route = '/editworkout';

  EditWorkoutPage({Key key}) : super(key: key);

  @override
  _EditWorkoutPageState createState() => _EditWorkoutPageState();
}

class _EditWorkoutPageState extends State<EditWorkoutPage> {
  final _nameTextCtrl = TextEditingController();

  Workout _workout;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppModel>(context);

    _workout = model.currentWorkout ?? Workout();

    if (_nameTextCtrl.text.isEmpty && _workout.name.isNotEmpty) {
      _nameTextCtrl.text = _workout.name;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Workout -- ${_workout.name}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _nameTextCtrl,
                    decoration: InputDecoration(hintText: 'Workout Name'),
                    onChanged: (String text) {
                      setState(() {
                        _workout.name = text;
                      });
                    },
                  ),
                ),
                SizedBox(width: 12,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Rest:"),
                    MinSecSelector(
                      duration: _workout.tabataRestDuration,
                      onChanged: (Duration value) {
                        setState(() {
                          _workout.tabataRestDuration = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12,),
            Expanded(
              child: ListView.builder(
                itemCount: _workout.tabatas.length,
                itemBuilder: (BuildContext context, int i) {
                  final tabata = _workout.tabatas[i];

                  return Card(
                    child: ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[Text(tabata.totalTime.format())],
                      ),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          model.clearCurrentTabata();
          Navigator.pushNamed(context, EditTabataPage.route);
        },
      ),
    );
  }
}
