import 'package:flutter/material.dart';

class AddExerciseDialog extends StatefulWidget {
  @override
  _AddExerciseDialogState createState() => _AddExerciseDialogState();
}

class _AddExerciseDialogState extends State<AddExerciseDialog> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(8),
      title: Text('New Exercise'),
      children: <Widget>[
        TextField(
          controller: _textEditingController,
          autofocus: true,
        ),
        const SizedBox(height: 12,),
        Row(
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context),
              child: const Text('Add'),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, _textEditingController.text),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ],
    );
  }
}
