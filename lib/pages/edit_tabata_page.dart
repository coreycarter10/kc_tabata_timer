import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

import '../models/setup.dart';
import '../dialogs/add_exercise_dialog.dart';
import '../widgets/min_sec_selector.dart';
import '../widgets/list_header.dart';

class EditTabataPage extends StatefulWidget {
  static const route = '/edittabata';

  EditTabataPage({Key key}) : super(key: key);

  @override
  _EditTabataPageState createState() => _EditTabataPageState();
}

class _EditTabataPageState extends State<EditTabataPage> {
  Tabata tabata;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppModel>(context);

    // when adding a new tabata...
    if (model.currentTabata == null) {
      model.currentTabata = Tabata();
      model.currentWorkout.add(model.currentTabata);
      scheduleMicrotask(() => _onEditExercise(model.currentTabata));
    }

    final workout = model.currentWorkout;
    final tabata = model.currentTabata;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add/Edit Exercises -- ${workout.name}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Exercise:"),
                    MinSecSelector(
                      duration: tabata.exerciseDuration,
                      onChanged: (Duration value) {
                        setState(() {
                          tabata.exerciseDuration = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Rest:"),
                    MinSecSelector(
                      duration: tabata.exerciseRestDuration,
                      onChanged: (Duration value) {
                        setState(() {
                          tabata.exerciseRestDuration = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Sets:"),
                    FlatButton(
                      child: Text(tabata.sets.toString()),
                      onPressed: () {
                        showMaterialNumberPicker(
                          context: context,
                          title: "Sets",
                          minNumber: 1,
                          maxNumber: 10,
                          selectedNumber: tabata.sets,
                          onChanged: (int value) {
                            setState(() {
                              tabata.sets = value;
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18,),
            ListHeader(text: "Exercises",),
            Expanded(
              child: ListView.builder(
                itemCount: tabata.exercises.length,
                itemBuilder: (BuildContext context, int i) {
                  final exercise = tabata.exercises[i];

                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.directions_run),
                      title: Text(exercise),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _onEditExercise(tabata, i),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_forever),
                            onPressed: tabata.exercises.length > 1 ? () {
                              setState(() {
                                tabata.remove(exercise);
                              });
                            } : null,
                          ),
                        ],
                      ),
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
        onPressed: () async {
          final value = await _showAddExerciseDialog();

          if (value != null) {
            setState(() {
              tabata.add(value);
            });
          }
        },
      ),
    );
  }

  void _onEditExercise(Tabata tabata, [int i = 0]) async {
    final value = await _showAddExerciseDialog(tabata.exercises[i]);

    if (value != null) {
      setState(() {
        tabata.exercises[i] = value;
      });
    }
  }

  Future<String> _showAddExerciseDialog([String exercise]) async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AddExerciseDialog(exercise: exercise,);
      }
    );
  }
}
