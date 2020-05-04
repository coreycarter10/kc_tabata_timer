import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/setup.dart';
import '../utils/utils.dart';
import '../widgets/min_sec_selector.dart';
import '../widgets/list_header.dart';
import '../widgets/empty_list_prompt.dart';
import 'edit_tabata_page.dart';

class EditWorkoutPage extends StatefulWidget {
  static const route = '/editworkout';

  EditWorkoutPage({Key key}) : super(key: key);

  @override
  _EditWorkoutPageState createState() => _EditWorkoutPageState();
}

class _EditWorkoutPageState extends State<EditWorkoutPage> {
  final _nameTextCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool adding = false;

    final model = Provider.of<AppModel>(context);

    // when adding a new workout...
    if (model.currentWorkout == null) {
      adding = true;
      model.currentWorkout = Workout();
      model.addWorkout(model.currentWorkout);

      scheduleMicrotask(_nameTextCtrl.selectAll);
    }

    final workout = model.currentWorkout;

    if (_nameTextCtrl.text.isEmpty && workout.name.isNotEmpty) {
      _nameTextCtrl.text = workout.name;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add/Edit Tabatas -- ${workout.name}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    autofocus: adding,
                    controller: _nameTextCtrl,
                    decoration: InputDecoration(hintText: 'Workout Name'),
                    onChanged: (String text) {
                      setState(() {
                        workout.name = text;
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
                      duration: workout.tabataRestDuration,
                      onChanged: (Duration value) {
                        setState(() {
                          workout.tabataRestDuration = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18,),
            ListHeader(text: "Tabatas",),
            Expanded(
              child: workout.tabatas.isNotEmpty ?
                _buildTabataList(model, workout) :
                EmptyListPrompt(text: "Add a tabata to get started!"),
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

  Widget _buildTabataList(AppModel model, Workout workout) {
    ListView.builder(
      itemCount: workout.tabatas.length,
      itemBuilder: (BuildContext context, int i) {
        final tabata = workout.tabatas[i];

        return Card(
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text(tabata.totalTime.format())],
            ),
            title: Text(tabata.exercises.join(', ')),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    model.currentTabata = tabata;
                    Navigator.pushNamed(context, EditTabataPage.route);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_forever),
                  onPressed: workout.tabatas.length > 1 ? () {
                    setState(() {
                      workout.remove(tabata);
                    });
                  } : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
