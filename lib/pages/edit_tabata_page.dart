import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

import '../models/setup.dart';
import '../dialogs/add_exercise_dialog.dart';
import '../widgets/min_sec_selector.dart';

class EditTabataPage extends StatefulWidget {
  static const route = '/edittabata';

  EditTabataPage({Key key}) : super(key: key);

  @override
  _EditTabataPageState createState() => _EditTabataPageState();
}

class _EditTabataPageState extends State<EditTabataPage> {
  Tabata _tabata;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppModel>(context);

    _tabata = model.currentTabata ?? Tabata();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Tabata"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Exercise:"),
                    MinSecSelector(
                      duration: _tabata.exerciseDuration,
                      onChanged: (Duration value) {
                        setState(() {
                          _tabata.exerciseDuration = value;
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
                      duration: _tabata.exerciseRestDuration,
                      onChanged: (Duration value) {
                        setState(() {
                          _tabata.exerciseRestDuration = value;
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
                      child: Text(_tabata.sets.toString()),
                      onPressed: () {
                        showMaterialNumberPicker(
                          context: context,
                          title: "Sets",
                          minNumber: 1,
                          maxNumber: 10,
                          selectedNumber: _tabata.sets,
                          onChanged: (int value) {
                            setState(() {
                              _tabata.sets = value;
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _tabata.exercises.length,
                itemBuilder: (BuildContext context, int i) {
                  final exercise = _tabata.exercises[i];

                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.directions_run),
                      title: Text(exercise),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () async {
                              final value = await _showAddExerciseDialog();

                              if (value != null) {
                                setState(() {
                                  _tabata.exercises[i] = value;
                                });
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_forever),
                            onPressed: () {
                              setState(() {
                                _tabata.remove(exercise);
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final value = await _showAddExerciseDialog();

          if (value != null) {
            setState(() {
              _tabata.add(value);
            });
          }
        },
      ),
    );
  }

  Future<String> _showAddExerciseDialog() async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AddExerciseDialog();
      }
    );
  }
}
