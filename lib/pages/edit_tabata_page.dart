import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/setup.dart';
import '../dialogs/add_exercise_dialog.dart';

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

    print('$runtimeType::initState()');
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppModel>(context);

    _tabata = model.currentTabata ?? Tabata();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Tabata"),
      ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _tabata.exercises.length,
          itemBuilder: (BuildContext context, int i) {
            final exercise = _tabata.exercises[i];

            return Card(
              child: ListTile(
                leading: const Icon(Icons.timer),
                title: Text(exercise),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _showAddExerciseDialog();
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
        onPressed: () async {
          final newExercise = await _showAddExerciseDialog();
          print(newExercise);
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
